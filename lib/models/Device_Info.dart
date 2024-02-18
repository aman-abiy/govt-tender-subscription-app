import 'dart:convert';

import 'package:alpha_tenders_mobile_app/models/Device.dart';

class DeviceInfo {
  String ip;
  Device device;

  DeviceInfo({
    this.ip,
    this.device,
  });

  Map<String, dynamic> toMap() {
    return {
      'ip': ip,
      'device': device.toMap(),
    };
  }

  DeviceInfo.fromJson(Map<String, dynamic> json) {
    ip = json['ip'];
    device = Device.fromJson(json['device']);
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'DeviceInfo(ip: $ip, device: $device)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is DeviceInfo &&
      other.ip == ip &&
      other.device == device;
  }

  @override
  int get hashCode => ip.hashCode ^ device.hashCode;
}
