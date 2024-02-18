class MobileNumber {
  
  String countryCode;
  String phoneNumber;
  bool isValid;
  String countryCallingCode;
  String nationalNumber;
  String formatInternational;
  String formatNational;
  String uri;
  String e164;

  MobileNumber();

  Map<String, dynamic> toMap() {
    return {
      'countryCode': countryCode,
      'phoneNumber': phoneNumber,
      'isValid': isValid,
      'countryCallingCode': countryCallingCode,
      'nationalNumber': nationalNumber,
      'formatInternational': formatInternational,
      'formatNational': formatNational,
      'uri': uri,
      'e164': e164,
    };
  }
}
