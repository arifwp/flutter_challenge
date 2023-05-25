import 'package:flutter/material.dart';
import 'package:flutter_challenge/pages/login/card_login.dart';
import 'package:flutter_challenge/theme.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
    );
  }
}
