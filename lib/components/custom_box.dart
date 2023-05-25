import 'dart:async';

import 'package:flutter/material.dart';

class CustomBox extends StatefulWidget {
  const CustomBox(this.title, this.data, {super.key});

  final String title;
  final String data;

  @override
  State<CustomBox> createState() => _CustomBoxState();
}

class _CustomBoxState extends State<CustomBox> {
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
                      Text(widget.data),
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
  }
}
