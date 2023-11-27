// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:iot_app/common/apps/app_color.dart';
// import 'package:iot_app/common/apps/app_style.dart';
// import 'package:iot_app/common/widgets/my_button.dart';
// import 'package:iot_app/view_models/authentication_view_model.dart';
// import 'package:iot_app/view_models/login_view_model.dart';

// class EmailController extends StatelessWidget {
//   EmailController({Key? key}) : super(key: key);

//   final AuthenticationViewModel viewModel = Get.put(AuthenticationViewModel());

//   // final String email = Get.arguments;
//   // late final int idx;

//   // EmailController({super.key}) {
//   //   final args = Get.arguments as Map<String, dynamic>;
//   //   email = args['email'] as String;
//   //   idx = args['idx'] as int;
//   // }

//   // final AuthenticationViewModel viewModel = Get.put(AuthenticationViewModel());
//   // final String? phoneNumber = Get.arguments;

//   @override
//   Widget build(BuildContext context) {
//     //final args = Get.arguments as Map<String, dynamic>;
//     final String? email = Get.arguments;

//     //final int idx = args['idx'] as int;

//     return Padding(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Image.asset(
//             'assets/images/email.png',
//             color: AppColor.primaryColor,
//             fit: BoxFit.cover,
//             height: 200,
//           ),
//           const SizedBox(height: 50),
//           const Text(
//             'Xác thực địa chỉ email của bạn',
//             style: AppStyle.appBarText,
//           ),
//           const SizedBox(height: 50),
//           const Text(
//             'Chúng tôi vừa gửi một liên kết đến địa chỉ email của bạn. Vui lòng kiểm tra email và nhấp vào liên kết đó để xác nhận',
//             style: TextStyle(
//               color: Color(0xff484D51),
//               fontSize: 18,
//               fontWeight: FontWeight.w500,
//             ),
//             softWrap: true,
//             textAlign: TextAlign.center,
//           ),
//           const SizedBox(height: 50),
//           TextButton(
//             onPressed: () {
//               LoginViewModel().sendEmailVerification();
//             },
//             child: Text(
//               'Gửi lại link',
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w600,
//                 color: viewModel.resCode.value
//                     ? const Color(0xffFF7B54)
//                     : Colors.grey,
//               ),
//             ),
//           ),
//           const SizedBox(height: 20),
//           MyButton(
//             text: 'Đăng nhập',
//             onTap: () => LoginViewModel().login(),
//           ),
//         ],
//       ),
//     );
//   }
// }
