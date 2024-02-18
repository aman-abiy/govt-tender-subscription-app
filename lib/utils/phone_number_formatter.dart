import 'package:alpha_tenders_mobile_app/dtos/Mobile_Number.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class PhoneNumberFormatter {
  static MobileNumber mobileNumber = MobileNumber();
  
  static MobileNumber formattedMobileNumber(PhoneNumber number) {
    String parsedPhoneNumber = number.parseNumber();
    String sanitizedPhoneNumber = number.phoneNumber;

    if(parsedPhoneNumber.startsWith('0')) {
      parsedPhoneNumber = number.parseNumber().substring(1);
      sanitizedPhoneNumber = '${number.phoneNumber.substring(0, 4)}${number.phoneNumber.substring(5)}';
    }

    mobileNumber.countryCode = number.isoCode;
    mobileNumber.phoneNumber = parsedPhoneNumber;
    mobileNumber.isValid = true;
    mobileNumber.countryCallingCode = number.dialCode.split('+')[1];
    mobileNumber.nationalNumber = parsedPhoneNumber;
    mobileNumber.formatInternational = '${sanitizedPhoneNumber.substring(0, 4)} ${sanitizedPhoneNumber.substring(4, 6)} ${sanitizedPhoneNumber.substring(6, 9)} ${sanitizedPhoneNumber.substring(9)}';
    mobileNumber.formatNational = '0${parsedPhoneNumber.substring(0, 2)} ${parsedPhoneNumber.substring(2, 5)} ${parsedPhoneNumber.substring(5, 9)}';
    mobileNumber.uri = 'tel:$sanitizedPhoneNumber';
    mobileNumber.e164 = sanitizedPhoneNumber;

    return mobileNumber;
  }
}