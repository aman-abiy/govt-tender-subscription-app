import 'dart:convert';

import 'package:alpha_tenders_mobile_app/models/Device_Info.dart';

class SessionActivity {
  String type;
  DateTime timestamp;
  DeviceInfo deviceInfo;

  SessionActivity({
    this.type,
    this.timestamp,
    this.deviceInfo,
  });

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'deviceInfo': deviceInfo.toMap(),
    };
  }

  SessionActivity.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    timestamp = DateTime.fromMillisecondsSinceEpoch(json['timestamp']);
    deviceInfo = DeviceInfo.fromJson(json['deviceInfo']);
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'SessionActivity(type: $type, timestamp: $timestamp, deviceInfo: $deviceInfo)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is SessionActivity &&
      other.type == type &&
      other.timestamp == timestamp &&
      other.deviceInfo == deviceInfo;
  }

  @override
  int get hashCode => type.hashCode ^ timestamp.hashCode ^ deviceInfo.hashCode;
}
