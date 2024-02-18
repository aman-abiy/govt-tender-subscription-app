import 'dart:convert';

class BuildInfo {
  String version;
  String appName;
  String buildNumber;
  String packageName;

  BuildInfo({
    this.version,
    this.appName,
    this.buildNumber,
    this.packageName,
  });

  Map<String, dynamic> toMap() {
    return {  
      'version': version,
      'appName': appName,
      'buildNumber': buildNumber,
      'packageName': packageName,
    };
  }

  BuildInfo.fromJson(Map<String, dynamic> json) {
    version = json['version'] ?? '';
    appName = json['appName'] ?? '';
    buildNumber = json['buildNumber'] ?? '';
    packageName = json['packageName'] ?? '';
  }

  String toJson() => json.encode(toMap());


  @override
  String toString() {
    return 'BuildInfo(version: $version, appName: $appName, buildNumber: $buildNumber, packageName: $packageName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is BuildInfo &&
      other.version == version &&
      other.appName == appName &&
      other.buildNumber == buildNumber &&
      other.packageName == packageName;
  }

  @override
  int get hashCode {
    return version.hashCode ^
      appName.hashCode ^
      buildNumber.hashCode ^
      packageName.hashCode;
  }
}
