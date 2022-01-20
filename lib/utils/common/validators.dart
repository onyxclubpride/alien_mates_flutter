class Validator {
  static String? validatePassword(String? value) {
    RegExp regex = RegExp(
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,13}$');
    if (value != null) {
      if (value.isEmpty) {
        return 'Password must not be empty';
      }
      if (!regex.hasMatch(value)) {
        return "Password must contain lower, upper, 1 character and between 8-13.";
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
        return 'Please enter your phone number';
      }
      if (!regex.hasMatch(value)) {
        // number_must_be_between_10_and_11
        return "Number must be between 10 or 11";
      }
    } else {
      return null;
    }
  }

  static String? validateOtp(String? value) {
    RegExp regex = RegExp(r'^[0-9]{6,10}$');
    if (value != null) {
      if (value.isEmpty) {
        // enter_phone_number
        return 'Enter Verification Code!';
      }
      if (!regex.hasMatch(value)) {
        // number_must_be_between_10_and_11
        return "Verification Code must be 6 digits!";
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
      return '\u200d⚠️  At least 6 characters please\u200d‼️';
    } else {
      return null;
    }
  }

  static String? validateTitle(String? value) {
    if (value != null && value.length < 10) {
      return '\u200d⚠️  At least 10 characters please\u200d‼️\u200d😐';
    } else {
      return null;
    }
  }

  static String? validateDescription(String? value) {
    if (value != null && value.length < 60) {
      return '\u200d⚠️  At least 30 words please\u200d‼️️\u200d😑';
    } else {
      return null;
    }
  }

  static String? validateMaxPeople(String? value) {
    if (value != null) {
      int val = int.parse(value);
      if (val < 0) return 'BRUH\u200d‼️‼️😑';
      if (val == 0) return null;
      if (val < 3 && val > 0) {
        return 'A group of 3 friends is always the best. \u200d💛';
      }
      if (val > 6) {
        return 'Already forgot about COVID? \u200d🚫\u200d💉\u200d😷 ';
      }
    } else {
      return null;
    }
  }
}
