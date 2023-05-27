import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_challenge/components/app_dropdown.dart';

class CustomBox extends StatefulWidget {
  const CustomBox(this.title, this.data, this.dataDropdown, {super.key});

  final String title;
  final String? data;
  final Widget? dataDropdown;

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
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      (widget.data != null)
                          ? Text(widget.data.toString())
                          : AppDropdown(),
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
  }
}
