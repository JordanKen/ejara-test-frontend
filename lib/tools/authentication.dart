import 'dart:async';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class localAuthentication {

  static Future<bool> authenticateWithBiometrics() async {

    bool isAuthenticated = false;
    final LocalAuthentication localAuthentication = LocalAuthentication();
    bool isBiometricSupported = await localAuthentication.isDeviceSupported();
    bool canCheckBiometrics = await localAuthentication.canCheckBiometrics;
    try {
      if (isBiometricSupported && canCheckBiometrics) {
        //List<BiometricType> biometricTypes = await localAuthentication.getAvailableBiometrics();
        // print(biometricTypes);
        isAuthenticated = await localAuthentication.authenticate(
            localizedReason: 'Scan your fingerprint to authenticate',
            useErrorDialogs: true,
            stickyAuth: true,
          ///biometricOnly: true,
        );
        return isAuthenticated;
      }
      return isAuthenticated;
    } catch (e) {
      print("PlatformException" + e.toString());
      return isAuthenticated;
    }
  }

}