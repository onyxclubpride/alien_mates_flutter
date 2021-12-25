import 'package:flutter/material.dart';

class Validator {
  static String? validatePassword(String? value) {
    if (value != null && value.length < 6) {
      return 'password_must_be_more_than_6_character';
    } else {
      return null;
    }
  }

  static String? validatePhoneNumber(String? value) {
    if (value != null && value.length < 11 && value.length > 13) {
      return 'Phone number must be between 11-13';
    } else {
      return null;
    }
  }
}
