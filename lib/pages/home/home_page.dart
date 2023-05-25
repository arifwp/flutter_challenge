import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_challenge/components/alert.dart';
import 'package:flutter_challenge/components/box_device_sensor.dart';
import 'package:flutter_challenge/components/custom_box.dart';
import 'package:flutter_challenge/theme.dart';
import 'package:sensors_plus/sensors_plus.dart';

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

  @override
  void initState() {
    super.initState();

    timeString =
        "${DateTime.now().hour} : ${DateTime.now().minute} : ${DateTime.now().second}";
    Timer.periodic(
      Duration(seconds: 1),
      (timer) => getTime(),
    );

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
    setState(() {
      timeString =
          "${DateTime.now().hour} : ${DateTime.now().minute} : ${DateTime.now().second}";
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

    return Container(
      decoration: BoxDecoration(color: mainBgColor),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: 80,
            left: 20,
            right: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomBox(
                'Time',
                timeString.toString(),
              ),
              SizedBox(
                height: 20,
              ),
              BoxDeviceSensor(
                'Device Sensor',
                userAccelerometer,
                accelerometer,
                gyroscope,
                magnetometer,
              ),
              SizedBox(
                height: 20,
              ),
              CustomBox('GPS Coordinate', 'data'),
            ],
          ),
        ),
      ),
    );
  }
}
