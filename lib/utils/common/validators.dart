import 'package:flutter/material.dart';

class Validator {
  static String? validatePassword(String? value) {
    RegExp regex = RegExp(
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,13}$');
    if (value != null) {
      if (value.isEmpty) {
        return '대문자 소문자,숫자,특수문자 조합 8~13자리';
      }
      if (!regex.hasMatch(value)) {
        return "대문자 소문자,숫자,특수문자 조합 8~13자리";
      }
    } else {
      return null;
    }
  }

  static String? validateQuery(String? value) {
    if (value != null && value.length < 1) {
      // query_must_not_be_empty
      return '죄송합니다. 검색결과가 없습니다. 다시 검색해 주세요.';
    } else {
      return null;
    }
  }

  static String? validateId(String? value) {
    if (value != null && value.length < 4) {
      // id_must_be_more_than_4_character
      return '아이디를 입력 해 주세요.';
    } else {
      return null;
    }
  }

  static String? validateAddress(String? value) {
    if (value != null && value.isEmpty) {
      // address_must_not_be_empty
      return '상세주소를 입력 해 주세요.';
    } else {
      return null;
    }
  }

  static String? validateDate(String? value) {
    if (value != null && value.isEmpty) {
      // please_choose_the_date
      return '계약 시작일과 종료일을 다시 확인 해 주세요.';
    } else {
      return null;
    }
  }

  static String? validateName(String? value) {
    if (value != null && value.length < 4) {
      return 'Please enter proper name!';
    } else {
      return null;
    }
  }

  static String? validateKoreanSign(String? value) {
    if (value != null && value.length < 2) {
      // name_must_be_more_than_2_character
      return "계약서명을 입력해주세요";
    } else {
      return null;
    }
  }

  static String? validatePhoneNumber(String? value) {
    RegExp regex = RegExp(r'^[0-9]{10,11}$');
    if (value != null) {
      if (value.isEmpty) {
        // enter_phone_number
        return '전화번호를 입력 해 주세요.';
      }
      if (!regex.hasMatch(value)) {
        // number_must_be_between_10_and_11
        return "number_must_be_between_10_and_11";
      }
    } else {
      return null;
    }
  }

  static String? validateBin(String? value) {
    if (value != null && value.length != 10) {
      // bin_must_consist_of_10_digits
      return '주민번호/사업자번호를 정확히 입력 해 주세요.';
    } else {
      return null;
    }
  }

  static String? validateNumber(String? value) {
    RegExp regex = RegExp(r'^(0|[1-9][0-9]*)$');
    if (value != null) {
      if (value.length > 15) {
        // enter_correct_number
        return '숫자만 입력 가능합니다.';
      }
      if (!regex.hasMatch(value)) {
        // enter_correct_number
        return "숫자만 입력 가능합니다.";
      }
    } else {
      return null;
    }
  }

  static String? validateDay(String? value) {
    RegExp regex = RegExp(r'\b(1?[1-9]|[12][0-9]|3[01])\b');
    if (value != null) {
      if (value.isEmpty) {
        // day_must_be_less_than_or_equal_to_2_character
        return '임대료 결제일을 다시 확인 해 주세요.';
      }
      if (!regex.hasMatch(value)) {
        // day_must_be_less_than_or_equal_to_2_character
        return "임대료 결제일을 다시 확인 해 주세요.";
      }
    } else {
      return null;
    }
  }

  static String? validateText(String? value) {
    if (value != null && value.length < 6) {
      return 'Value length must be more than 6 characters';
    } else {
      return null;
    }
  }
}
