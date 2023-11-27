// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:iot_app/common/widgets/my_button.dart';
// import 'package:iot_app/view_models/authentication_view_model.dart';
// import 'package:iot_app/views/auth/login/widgets/otp_wiget.dart';

// class OTPController extends StatelessWidget {
//   OTPController({super.key});

//   final AuthenticationViewModel viewModel = Get.put(AuthenticationViewModel());
//   final String? phoneNumber = Get.arguments;

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(children: [
//         const SizedBox(height: 16),
//         const Text(
//           'Nhập mã xác minh 6 chữ số đã được gửi đến số điện thoại của bạn',
//           style: TextStyle(
//             height: 1.8,
//             color: Color(0xff484D51),
//             fontSize: 20,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         const SizedBox(height: 24),
//         OTPField(idx: 1),
//         const SizedBox(height: 32),
//         Obx(() => Text('Mã còn hiệu lực trong ${viewModel.timeLeft} giây')),
//         const SizedBox(height: 20),
//         Obx(
//           () => TextButton(
//             onPressed: () {
//               viewModel.resCode.value
//                   ? viewModel.resendCode(phoneNumber!)
//                   : null;
//             },
//             child: Text(
//               'Gửi lại mã',
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w600,
//                 color: viewModel.resCode.value
//                     ? const Color(0xffFF7B54)
//                     : Colors.grey,
//               ),
//             ),
//           ),
//         ),
//         const SizedBox(height: 271),
//         MyButton(
//           text: 'Đăng nhập',
//           onTap: viewModel.checkOTPCompletion,
//         ),
//       ]),
//     );
//   }
// }