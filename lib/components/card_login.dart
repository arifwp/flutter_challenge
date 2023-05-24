import 'package:flutter/material.dart';
import 'package:flutter_challenge/components/style_textfield.dart';

class CardLogin extends StatelessWidget {
  const CardLogin({super.key});

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
        height: 260,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              StyleTextField('Username'),
              SizedBox(
                height: 20,
              ),
              StyleTextField('Password'),
              SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
