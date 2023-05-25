import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuth {
  final LocalAuthentication auth = LocalAuthentication();

  Future<bool> checkBiometric() async {
    try {
      return await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      return false;
    }
  }

  Future<bool> authenticate() async {
    final isAvailable = await checkBiometric();
    if (!isAvailable) return false;

    try {
      return await auth.authenticate(
          localizedReason: 'Scan Your Face to Login');
    } on PlatformException catch (e) {
      print("Erorr on biometrics : $e");
      return false;
    }
  }
}
