import 'package:alpha_tenders_mobile_app/models/Device_Info.dart';
import 'package:alpha_tenders_mobile_app/models/Session_Activity.dart';
import 'package:alpha_tenders_mobile_app/services/device.dart';

class SessionActivityHandler {

  static DeviceInfo deviceInfo;
  static SessionActivity sessionActivity;

  static Future<SessionActivity> getSessionActivity(String sessionActivityType) async {
    deviceInfo = await DeviceService().getDeviceInfo();

    sessionActivity.deviceInfo = deviceInfo;
    sessionActivity.timestamp = DateTime.now();
    sessionActivity.type = sessionActivityType;

    return sessionActivity;
  }
}