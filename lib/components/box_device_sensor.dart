import 'package:flutter/material.dart';

class BoxDeviceSensor extends StatefulWidget {
  const BoxDeviceSensor(this.title, this.userAccelerometer, this.accelerometer,
      this.gyroscope, this.magnetometer,
      {super.key});

  final String title;
  final List<String>? userAccelerometer;
  final List<String>? accelerometer;
  final List<String>? gyroscope;
  final List<String>? magnetometer;

  @override
  State<BoxDeviceSensor> createState() => _BoxDeviceSensorState();
}

class _BoxDeviceSensorState extends State<BoxDeviceSensor> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          margin: EdgeInsets.only(top: 20),
          width: double.infinity,
          child: Card(
            color: Color(0xffeeeeee),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 40,
                    bottom: 0,
                    left: 10,
                    right: 10,
                  ),
                  child: Column(
                    children: [
                      Text(
                        '${widget.title}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('User Accelerometer'),
                      Text(widget.userAccelerometer.toString()),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Accelerometer'),
                      Text(widget.accelerometer.toString()),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Gyroscope'),
                      Text(widget.gyroscope.toString()),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Magnetometer'),
                      Text(widget.magnetometer.toString()),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        CircleAvatar(
          radius: 30 + 2,
          backgroundColor: Colors.black,
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/images/flutter_logo.png'),
            radius: 30,
          ),
        )
      ],
    );
    ;
  }
}
