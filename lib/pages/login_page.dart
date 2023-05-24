import 'package:flutter/material.dart';
import 'package:flutter_challenge/components/card_login.dart';
import 'package:flutter_challenge/theme.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(color: mainBgColor),
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 180)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/flutter_logo.png',
                  width: 200,
                ),
              ],
            ),
            SizedBox(
              height: 60,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CardLogin(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
