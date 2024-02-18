class Version {
  String baseOS;
  String codename;
  String incremental;
  int previewSdkInt;
  String release;
  int sdkInt;
  String securityPatch;

  Version(
      {this.baseOS,
      this.codename,
      this.incremental,
      this.previewSdkInt,
      this.release,
      this.sdkInt,
      this.securityPatch});

  Version.fromJson(Map<String, dynamic> json) {
    baseOS = json['baseOS'];
    codename = json['codename'];
    incremental = json['incremental'];
    previewSdkInt = json['previewSdkInt'];
    release = json['release'];
    sdkInt = json['sdkInt'];
    securityPatch = json['securityPatch'];
  }

  Map<String, dynamic> toMap() {
    return {
      'baseOS': baseOS,
      'codename': codename,
      'incremental': incremental,
      'previewSdkInt': previewSdkInt,
      'release': release,
      'sdkInt': sdkInt,
      'securityPatch': securityPatch,
    };
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['baseOS'] = baseOS;
    data['codename'] = codename;
    data['incremental'] = incremental;
    data['previewSdkInt'] = previewSdkInt;
    data['release'] = release;
    data['sdkInt'] = sdkInt;
    data['securityPatch'] = securityPatch;
    return data;
  }
}
