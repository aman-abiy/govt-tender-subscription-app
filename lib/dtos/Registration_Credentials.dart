import 'package:alpha_tenders_mobile_app/dtos/Mobile_Device.dart';
import 'package:alpha_tenders_mobile_app/dtos/Mobile_Number.dart';

class RegistrationCredentials {
  String fname;
  String lname;
  String email;
  MobileNumber mobile;
  String password;
  MobileDevice mobileDeviceInfo;
  
  RegistrationCredentials();

  Map<String, dynamic> toMap() {
    return {
      'fname': fname,
      'lname': lname,
      'email': email,
      'mobile': mobile.toMap(),
      'password': password,
      'mobileDeviceInfo': mobileDeviceInfo.toMap()
    };
  }
}