import 'dart:ffi';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_challenge/components/app_crud.dart';
import 'package:flutter_challenge/components/app_drawer.dart';
import 'package:flutter_challenge/components/app_dropdown.dart';
import 'package:flutter_challenge/components/box_device_sensor.dart';
import 'package:flutter_challenge/components/custom_box.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DataPage extends StatefulWidget {
  const DataPage({super.key});

  @override
  State<DataPage> createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  String? versionCode;
  String? buildNumber;
  String? buildSignature;
  String? model;
  String? manufacturer;
  int sdk = 0;

  @override
  void initState() {
    super.initState();
    initPackageInfo();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    AndroidDeviceInfo build;
    if (!mounted) return;
    setState(() {
      sdk = androidInfo.version.sdkInt;
      manufacturer = androidInfo.manufacturer;
      model = androidInfo.model;
    });
  }

  void initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      versionCode = info.version;
      buildNumber = info.buildNumber;
      buildSignature = info.buildSignature;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Data Management Page'),
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
                BoxDeviceSensor(
                  'Data SoC',
                  'Manufacturer',
                  manufacturer,
                  'Model',
                  model,
                  'Build',
                  'Build Number : ${buildNumber} & Build Signature : ${buildSignature}',
                  'SDK',
                  sdk,
                  'Version Code',
                  versionCode,
                ),
                CustomBox(
                  'Change Device Sensor Refresh Rate',
                  null,
                  null,
                ),
                AppCrud(),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ));
  }
}
