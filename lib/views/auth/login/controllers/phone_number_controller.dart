import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iot_app/view_models/login_view_model.dart';
import 'package:iot_app/views/auth/login/country_phone_code.dart';

class PhoneNumberController extends StatelessWidget {
  final LoginViewModel viewModel = Get.find();

  PhoneNumberController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => DropdownButtonFormField2<String>(
        alignment: Alignment.center,
        isExpanded: true,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        value: viewModel.selectedCountryCode.value,
        items: CountryPhoneCode.countryCodes.map((countryCode) {
          return DropdownMenuItem<String>(
            value: countryCode.code,
            child: Text('${countryCode.name} (${countryCode.code})'),
          );
        }).toList(),
        onChanged: (value) {
          viewModel.selectCountryCode(value!);
        },
        selectedItemBuilder: (BuildContext context) {
          return CountryPhoneCode.countryCodes.map((countryCode) {
            return Text(
              countryCode.code,
            );
          }).toList();
        },
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          width: 200,
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 16,
        ),
      ),
    );
  }
}
