import 'package:flutter/material.dart';
import 'package:flutter_challenge/pages/login/login_page.dart';

void main() {
  runApp(const FlutterChallenge());
}

class FlutterChallenge extends StatelessWidget {
  const FlutterChallenge({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: LoginPage(),
      ),
    );
  }
}
