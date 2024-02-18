import 'dart:convert';

class Device {
  String platform;
  bool isWebApp;
  bool isMobileApp;
  bool isAndroidApp;
  bool isIOSApp;

  Device({
    this.platform,
    this.isWebApp,
    this.isMobileApp,
    this.isAndroidApp,
    this.isIOSApp,
  });

  Map<String, dynamic> toMap() {
    return {
      'platform': platform,
      'isWebApp': isWebApp == true,
      'isMobileApp': isMobileApp == true,
      'isAndroidApp': isAndroidApp == true,
      'isIOSApp': isIOSApp == true,
    };
  }

  Device.fromJson(Map<String, dynamic> json) {
    platform = json['platform'];
    isWebApp = json['isWebApp'] ?? false;
    isMobileApp = json['isMobileApp'] ?? false;
    isAndroidApp = json['isAndroidApp'] ?? false;
    isIOSApp = json['isIOSApp'] ?? false;
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Device(platform: $platform, isWebApp: $isWebApp, isMobileApp: $isMobileApp, isAndroidApp: $isAndroidApp, isIOSApp: $isIOSApp)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Device &&
      other.platform == platform &&
      other.isWebApp == isWebApp &&
      other.isMobileApp == isMobileApp &&
      other.isAndroidApp == isAndroidApp &&
      other.isIOSApp == isIOSApp;
  }

  @override
  int get hashCode {
    return platform.hashCode ^
      isWebApp.hashCode ^
      isMobileApp.hashCode ^
      isAndroidApp.hashCode ^
      isIOSApp.hashCode;
  }
}
