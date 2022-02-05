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

  static String? validateName(String? value) {
    if (value != null && value.length < 4) {
      return 'Please enter proper name!';
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

  static String? validateText(String? value) {
    if (value != null && value.isEmpty) {
      return 'Field cannot be empty';
    } else {
      return null;
    }
  }

  static String? validateTitle(String? value) {
    if (value != null && value.isEmpty) {
      return 'Title cannot be empty';
    } else {
      return null;
    }
  }

  static String? validateDescription(String? value) {
    if (value != null && value.isEmpty) {
      return 'Description cannot be empty';
    } else {
      return null;
    }
  }

  static String? validateMaxPeople(String? value) {
    if (value != null && value.isNotEmpty) {
      if (int.tryParse(value) == null) {
        return "Numbers only allowed";
      }
    }
  }
}
