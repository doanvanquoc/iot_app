import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iot_app/common/apps/app_color.dart';
import 'package:iot_app/common/widgets/my_button.dart';
import 'package:iot_app/my_app.dart';
import 'package:iot_app/repository/authentication_repository.dart';
import 'package:iot_app/view_models/authentication_view_model.dart';
import 'package:iot_app/view_models/login_view_model.dart';
import 'package:iot_app/views/auth/login/widgets/phone_number_widget.dart';
import 'package:iot_app/views/auth/login/widgets/segmented_widget.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatelessWidget {
  final LoginViewModel viewModel = Get.put(LoginViewModel());

  final phoneNo = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7FBFC),
      body: Stack(children: [
        SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height / 2,
                  color: AppColor.primaryColor,
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Đăng Nhập Tài Khoản',
                          style: TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff484D51),
                          )),
                      const SizedBox(height: 24),
                      SegmentedController(viewModel: viewModel),
                      const SizedBox(height: 24),
                      Obx(() {
                        if (viewModel.selectedSegment.value == 1) {
                          return SizedBox(
                            height: 128,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: email,
                                  onChanged: (value) =>
                                      viewModel.email.value = value,
                                  style: const TextStyle(
                                    color: Color(0xff484D51),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    hintText: 'your_email@gmail.com',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    contentPadding: const EdgeInsets.all(16),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                  obscureText: viewModel.isObs.value,
                                  controller: password,
                                  onChanged: (value) =>
                                      viewModel.password.value = value,
                                  style: const TextStyle(
                                    color: Color(0xff484D51),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        viewModel.isObs.value
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                      ),
                                      onPressed: () {
                                        viewModel.isObs.value =
                                            !viewModel.isObs.value;
                                        (context as Element).markNeedsBuild();
                                      },
                                    ),
                                    hintText: 'Password',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    contentPadding: const EdgeInsets.all(16),
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Row(
                            children: [
                              Expanded(
                                child: PhoneNumberController(),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                flex: 3,
                                child: SizedBox(
                                  height: 56,
                                  child: TextFormField(
                                    controller: phoneNo,
                                    onChanged: (value) =>
                                        viewModel.phoneNumber.value = value,
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            decimal: false),
                                    style: const TextStyle(
                                      color: Color(0xff484D51),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      contentPadding: const EdgeInsets.all(16),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                      }),
                      Obx(() {
                        if (viewModel.selectedSegment.value == 1) {
                          return const SizedBox(height: 24);
                        } else {
                          return const SizedBox(height: 96);
                        }
                      }),
                      Obx(() {
                        if (viewModel.selectedSegment.value == 1) {
                          return MyButton(
                            text: 'Đăng nhập',
                            onTap: () {
                              if (viewModel.checkInPutCompletion) {
                                viewModel.signInWithEmailAndPassword();
                              } else {
                                Get.snackbar(
                                  'Thông báo',
                                  'Vui lòng điền đầy đủ thông tin!',
                                  colorText: AppColor.primaryColor,
                                  backgroundColor: const Color(0xffDDE6ED),
                                  snackPosition: SnackPosition.TOP,
                                );
                                AuthenticationRepository
                                    .instance.isLoading.value = false;
                              }
                            },
                          );
                        } else {
                          return MyButton(
                            text: 'Gửi mã OTP',
                            onTap: () {
                              if (viewModel.checkInPutCompletion) {
                                AuthenticationViewModel.instance
                                    .phoneAuthentification(phoneNo.text.trim());
                                print(phoneNo.text.trim());
                              } else {
                                AuthenticationRepository
                                    .instance.isLoading.value = false;
                                Get.snackbar(
                                  'Thông báo',
                                  'Vui lòng điền đầy đủ thông tin!',
                                  colorText: AppColor.primaryColor,
                                  backgroundColor: const Color(0xffDDE6ED),
                                  snackPosition: SnackPosition.TOP,
                                );
                              }
                            },
                          );
                        }
                      })
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Obx(() {
          if (viewModel.selectedSegment.value == 1) {
            if (viewModel.isSuccess.value) {
              Future.delayed(const Duration(seconds: 2), () {
                Get.offAll(() => const NavScreen());
                viewModel.isSuccess.value = false;
              });
              return Container(
                color: Colors.black.withOpacity(0.3),
                child: Center(
                  child: Lottie.asset('assets/lotties/loading.json'),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          } else {
            if (AuthenticationRepository.instance.isLoading.value) {
              return Container(
                color: Colors.black.withOpacity(0.3),
                child: Center(
                  child: Lottie.asset('assets/lotties/loading.json'),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          }
        }),
      ]),
    );
  }
}
