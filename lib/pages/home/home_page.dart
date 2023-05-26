import 'dart:async';

import 'package:battery_info/battery_info_plugin.dart';
import 'package:battery_info/model/android_battery_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_challenge/components/alert.dart';
import 'package:flutter_challenge/components/app_drawer.dart';
import 'package:flutter_challenge/components/box_device_sensor.dart';
import 'package:flutter_challenge/components/custom_box.dart';
import 'package:flutter_challenge/theme.dart';
import 'package:flutter_challenge/utils/global_data.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? timeString;

  static const int _snakeRows = 20;
  static const int _snakeColumns = 20;
  static const double _snakeCellSize = 10.0;

  List<double>? userAccelerometerValues;
  List<double>? accelerometerValues;
  List<double>? gyroscopeValues;
  List<double>? magnetometerValues;
  final streamSubscriptions = <StreamSubscription<dynamic>>[];

  bool serviceStatus = false;
  bool hasPermission = false;
  late LocationPermission permission;
  late Position position;
  String long = '';
  String lat = '';
  String errMsg = '';
  late StreamSubscription<Position> positionStream;

  var ref = GlobalData();

  @override
  void initState() {
    super.initState();

    checkGps();

    timeString =
        "${DateTime.now().hour} : ${DateTime.now().minute} : ${DateTime.now().second}";
    Timer.periodic(
      Duration(seconds: 1),
      (timer) => getTime(),
    );

    if (ref.refreshEvery == 0) {
      initDeviceSensor();
    } else {
      Timer.periodic(
        Duration(seconds: ref.refreshEvery),
        (timer) => initDeviceSensor(),
      );
    }
  }

  void initDeviceSensor() async {
    streamSubscriptions.add(userAccelerometerEvents.listen(
      (event) {
        setState(() {
          userAccelerometerValues = <double>[event.x, event.y, event.z];
        });
      },
      onError: (e) {
        alertDialog(context,
            'Sensor not found, your device not support User Accelerometer Sensor');
      },
      cancelOnError: true,
    ));

    streamSubscriptions.add(accelerometerEvents.listen(
      (event) {
        setState(() {
          accelerometerValues = <double>[event.x, event.y, event.z];
        });
      },
      onError: (e) {
        alertDialog(context,
            'Sensor not found, your device not support Accelerometer Sensor');
      },
      cancelOnError: true,
    ));

    streamSubscriptions.add(gyroscopeEvents.listen(
      (event) {
        setState(() {
          gyroscopeValues = <double>[event.x, event.y, event.z];
        });
      },
      onError: (e) {
        alertDialog(context,
            'Sensor not found, your device not support Gyroscope Sensor');
      },
      cancelOnError: true,
    ));

    streamSubscriptions.add(magnetometerEvents.listen(
      (event) {
        setState(() {
          magnetometerValues = <double>[event.x, event.y, event.z];
        });
      },
      onError: (e) {
        alertDialog(context,
            'Sensor not found, your device not support Magnetometer Sensor');
      },
      cancelOnError: true,
    ));
  }

  @override
  void dispose() {
    super.dispose();
    for (final subscription in streamSubscriptions) {
      subscription.cancel();
    }
  }

  void getTime() {
    if (mounted) {
      setState(() {
        timeString =
            "${DateTime.now().hour} : ${DateTime.now().minute} : ${DateTime.now().second}";
      });
    }
  }

  void checkGps() async {
    serviceStatus = await Geolocator.isLocationServiceEnabled();
    var status = await Permission.location.status;
    if (await Permission.location.serviceStatus.isDisabled) {
      alertDialog(context, 'Turn on your GPS');
    }

    if (status.isGranted) {
      getLocation();
    } else if (status.isDenied) {
      alertDialog(context, 'Location permissions denied');
      Map<Permission, PermissionStatus> statusLoc = await [
        Permission.location,
      ].request();
      print(statusLoc);
    }

    if (await Permission.location.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  void getLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );

    StreamSubscription<Position> positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position position) {
      long = position.longitude.toString();
      lat = position.latitude.toString();
    });

    setState(() {
      long = position.longitude.toString();
      lat = position.latitude.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    final userAccelerometer = userAccelerometerValues
        ?.map((double v) => v.toStringAsFixed(1))
        .toList();
    final accelerometer =
        accelerometerValues?.map((double v) => v.toStringAsFixed(1)).toList();
    final gyroscope =
        gyroscopeValues?.map((double v) => v.toStringAsFixed(1)).toList();
    final magnetometer =
        magnetometerValues?.map((double v) => v.toStringAsFixed(1)).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        backgroundColor: Colors.blueGrey,
      ),
      drawer: AppDrawer(),
      backgroundColor: Color(0xff042B59),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomBox(
                'Time',
                timeString.toString(),
                null,
              ),
              SizedBox(
                height: 20,
              ),
              BoxDeviceSensor(
                'Device Sensor',
                'User Accelerometer',
                userAccelerometer,
                'Accelerometer',
                accelerometer,
                'Gyroscope',
                gyroscope,
                'Magnetometer',
                magnetometer,
                null,
                null,
              ),
              SizedBox(
                height: 20,
              ),
              CustomBox(
                'GPS Coordinate',
                '${long} + ${lat}',
                null,
              ),
              SizedBox(
                height: 20,
              ),
              FutureBuilder<AndroidBatteryInfo?>(
                future: BatteryInfoPlugin().androidBatteryInfo,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return CustomBox(
                      'Battery Level',
                      snapshot.data!.batteryLevel.toString(),
                      null,
                    );
                  }
                  return CircularProgressIndicator();
                },
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
