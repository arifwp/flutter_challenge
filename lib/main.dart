import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_challenge/pages/login/login_page.dart';
import 'package:flutter_challenge/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const FlutterChallenge());
}

class FlutterChallenge extends StatelessWidget {
  const FlutterChallenge({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xff042B59),
        resizeToAvoidBottomInset: false,
        body: LoginPage(),
      ),
    );
  }
}
