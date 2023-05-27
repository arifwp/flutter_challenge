import 'package:flutter/material.dart';

class BoxDeviceSensor extends StatefulWidget {
  const BoxDeviceSensor(
      this.title,
      this.titleData1,
      this.data1,
      this.titleData2,
      this.data2,
      this.titleData3,
      this.data3,
      this.titleData4,
      this.data4,
      this.titleData5,
      this.data5,
      {super.key});

  final String title;
  final String titleData1;
  final dynamic data1;
  final String titleData2;
  final dynamic data2;
  final String titleData3;
  final dynamic data3;
  final String titleData4;
  final dynamic data4;
  final String? titleData5;
  final dynamic data5;

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
            elevation: 20,
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
                      Text(widget.titleData1),
                      Text(widget.data1.toString()),
                      SizedBox(
                        height: 10,
                      ),
                      Text(widget.titleData2),
                      Text(widget.data2.toString()),
                      SizedBox(
                        height: 10,
                      ),
                      Text(widget.titleData3),
                      Text(widget.data3.toString()),
                      SizedBox(
                        height: 10,
                      ),
                      Text(widget.titleData4),
                      Text(widget.data4.toString()),
                      SizedBox(
                        height: 10,
                      ),
                      (widget.titleData5 != null)
                          ? Column(
                              children: [
                                Text(widget.titleData5.toString()),
                                Text(widget.data5.toString()),
                              ],
                            )
                          : SizedBox(
                              height: 0,
                            ),
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
            backgroundImage: AssetImage(
              'assets/images/flutter_small_logo.png',
            ),
            radius: 30,
          ),
        )
      ],
    );
    ;
  }
}
