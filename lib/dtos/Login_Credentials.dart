import 'package:alpha_tenders_mobile_app/dtos/Mobile_Device.dart';

class LoginCredentials {
  String email;
  String mobile;
  String password;
  MobileDevice mobileDeviceInfo;
  
  LoginCredentials();

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'mobile': mobile,
      'password': password,
      'mobileDeviceInfo': mobileDeviceInfo?.toMap()
    };
  }
}