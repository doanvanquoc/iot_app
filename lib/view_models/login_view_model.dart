import 'package:get/get.dart';
import 'package:iot_app/models/country_phone_code.dart';
import 'package:iot_app/view_models/authentication_view_model.dart';
import 'package:iot_app/views/auth/login/authentication_screen.dart';

class LoginViewModel extends GetxController {
  var selectedSegment = 1.obs;
  var selectedCountryCode = CountryPhoneCode.countryCodes[0].code.obs;
  RxString phoneNumber = "".obs;
  RxString email = "".obs;
  bool get isPhoneComplete => phoneNumber.trim().isNotEmpty;
  bool get isEmailComplete => email.trim().isNotEmpty && isEmail;

  final AuthenticationViewModel viewModelAuth =
      Get.put(AuthenticationViewModel());

  void onSegmentChanged(int newValue) {
    selectedSegment(newValue);
  }

  void selectCountryCode(String newValue) {
    selectedCountryCode(newValue);
  }

  bool get checkInPutCompletion {
    return selectedSegment.value == 1 ? isPhoneComplete : isEmailComplete;
  }

  void sendOTP() {
    print(phoneNumber.value);
    print('go to auth');
    //Get.to(() => AuthenticationScreen(), arguments: phoneNumber.value);
    Get.toNamed('/auth-screen', arguments: phoneNumber.value);
    viewModelAuth.startTime();
  }

  bool get isEmail {
    const emailPattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    final regExp = RegExp(emailPattern);
    return regExp.hasMatch(email.value);
  }
}
