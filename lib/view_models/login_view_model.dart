import 'package:get/get.dart';
import '../views/auth/login/country_phone_code.dart';

class LoginViewModel extends GetxController {
  var selectedSegment = 1.obs;
  var selectedCountryCode = CountryPhoneCode.countryCodes[0].code.obs;
  var length = 0.obs;

  void onSegmentChanged(int newValue) {
    selectedSegment(newValue);
  }

  void selectCountryCode(String newValue) {
    selectedCountryCode(newValue);
  }

}
