import 'dart:developer';

import 'package:alien_mates/mgr/redux/middleware/api_middleware.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class BiometricsController {
  static final LocalAuthentication _auth = LocalAuthentication();

  ///Returns true if the device has biometrics enabled
  static Future<bool> _checkAnyBioAvailable() async {
    final bool canAuthenticateWithBiometrics = await _auth.canCheckBiometrics;
    final bool canAuthenticate =
        canAuthenticateWithBiometrics || await _auth.isDeviceSupported();
    final List<BiometricType> availableBiometrics =
        await _auth.getAvailableBiometrics();
    return canAuthenticate &&
        canAuthenticateWithBiometrics &&
        availableBiometrics.isNotEmpty;
  }

  /// Returns true if auth with bio is success
  static Future<bool> authenticateWithBio(
      {required VoidCallback onSuccess,
      required VoidCallback onCancel,
      String? bioMessage}) async {
    final bool canAuthenticate = await _checkAnyBioAvailable();

    if (!canAuthenticate) {
      showError("No biometrics available");
      return false;
    }
    final didAuth = _auth
        .authenticate(
            options: const AuthenticationOptions(
              stickyAuth: true,
              useErrorDialogs: false,
              biometricOnly: true,
            ),
            localizedReason: bioMessage ?? 'Please register your biometrics!')
        .then((value) async {
      await closeLoading();
      if (value) {
        onSuccess();
      } else {
        onCancel();
      }
      return value;
    }).onError(
      (error, stackTrace) async {
        log("value: $error");

        await closeLoading();
        onCancel();
        return false;
        if (error is PlatformException) {
          if (error.code == "NotAvailable") {}
          log(error.code);
          log(error.details);
          log(error.message.toString());
        }
        log(error.toString());
      },
    );
    return didAuth;
  }
}
