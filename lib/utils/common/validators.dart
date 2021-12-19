import 'package:flutter/material.dart';

class Validator {
  String? validateDomain(value, VoidCallback callback) {
    if (value == null) {
      callback();
      return 'domain_must_be_selected';
    } else {
      return null;
    }
  }

  String? validatePassword(String? value) {
    if (value != null && value.length < 6) {
      return 'password_must_be_more_than_6_character';
    } else {
      return null;
    }
  }

  String? validateId(String? value) {
    if (value != null && value.length < 6) {
      return 'id_must_be_more_than_6_character';
    } else {
      return null;
    }
  }
}
