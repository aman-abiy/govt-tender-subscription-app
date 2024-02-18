import 'package:alpha_tenders_mobile_app/utils/consts.dart';
import 'package:email_validator/email_validator.dart';

class Validators {
  static String emailValidator(String email) {
    bool validationResult = EmailValidator.validate(email);

    if(validationResult) {
      return null;
    } else {
      return 'Email is not valid.';
    }
  }

  static String passwordValidator(String password) {
    String sanitizedPassword = password.trim();

    if(sanitizedPassword == null) {
      return 'Please enter password.';
    } 
    if(sanitizedPassword.length < 6) {
      return 'Password should be at least 6 characters long.';
    }
    return null;
  }

  static String nameValidator(String name) {
    String sanitizedName = name.trim();

    if((sanitizedName == null) || (sanitizedName.isEmpty)) {
      return 'Please add you name.';
    }
    return null;
  }
}