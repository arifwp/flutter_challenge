import 'package:flutter/material.dart';
import 'package:flutter_challenge/components/alert.dart';
import 'package:flutter_challenge/components/style_textfield.dart';
import 'package:flutter_challenge/db/database_helper.dart';
import 'package:flutter_challenge/utils/local_auth.dart';
import 'package:flutter_challenge/models/user.dart';
import 'package:flutter_challenge/pages/home/home_page.dart';

class CardLogin extends StatefulWidget {
  const CardLogin({super.key});

  @override
  State<CardLogin> createState() => _CardLoginState();
}

class _CardLoginState extends State<CardLogin> {
  final conUsername = TextEditingController();
  final conPassword = TextEditingController();
  User initData = User('', "demo", "demo@gmail.com", "demo123");

  @override
  void initState() {
    super.initState();
    DatabaseHelper().saveUser(initData);
  }

  login() async {
    String username = conUsername.text;
    String password = conPassword.text;

    if (username.isEmpty) {
      alertDialog(context, "Enter your username");
    } else if (password.isEmpty) {
      alertDialog(context, "Enter your password");
    } else {
      await DatabaseHelper().getUserLogin(username, password).then((value) {
        if (value != null) {
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (_) => HomePage()), (route) => false);
        } else {
          alertDialog(context, "Credential Not Found");
        }
      }).catchError((error) {
        print(error);
        alertDialog(context, "Sistem sedang dibenahi");
      });
    }
  }

  authenticate() async {
    final hasBiometric = await LocalAuth().checkBiometric();
    final isAuthenticated = await LocalAuth().authenticate();
    print("isAuthenticated : $isAuthenticated");
    if (hasBiometric == false) {
      alertDialog(context, "Not available");
    } else {
      if (isAuthenticated) {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_) => HomePage()));
      } else {
        alertDialog(context, "System error");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 20,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: SizedBox(
        width: 340,
        height: 310,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  StyleTextField('Username', conUsername, false),
                  SizedBox(
                    height: 20,
                  ),
                  StyleTextField('Password', conPassword, true),
                  SizedBox(
                    height: 24,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: login,
                          child: Text(
                            'Login',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: authenticate,
                          child: Text(
                            'Login Using Face Recognition',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
