// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iot_app/common/apps/app_color.dart';
import 'package:iot_app/common/widgets/my_button.dart';
import 'package:iot_app/view_models/edit_user_view_model.dart';
import 'package:iot_app/views/user/text_edit_user.dart';

class EditUserScreen extends StatelessWidget {
  const EditUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final EditUserViewModel viewModel = Get.put(EditUserViewModel());

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: const Text("Thông tin tài khoản"),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              /// -- Hình đại diện
              Stack(
                children: [
                  SizedBox(
                    width: 110,
                    height: 110,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: const Image(
                            image: AssetImage('assets/images/logo.png'))),
                  ),
                  //Viền ngoài cùng
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 110,
                      height: 110,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.transparent,
                        border: Border.all(
                          color: AppColor.primaryColor,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                  //Icon camera
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: AppColor.primaryColor,
                        border: Border.all(
                          color: AppColor.primaryColor,
                          width: 2.0,
                        ),
                      ),
                      child: const Icon(Icons.camera_alt_rounded,
                          color: Colors.black, size: 20),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                'Smart Home',
                style: TextStyle(
                    fontSize: 24,
                    color: Color.fromRGBO(72, 77, 81, 1),
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                child: Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextEditUser(
                        label: 'Thông tin tài khoản',
                        controller: viewModel.fullNameController,
                      ),
                      const SizedBox(height: 15),
                      TextEditUser(
                        label: 'Email',
                        controller: viewModel.emailController,
                      ),
                      const SizedBox(height: 15),
                      TextEditUser(
                        label: 'Số điện thoại',
                        controller: viewModel.phoneController,
                      ),
                      const SizedBox(height: 50),
                      Obx(() {
                        return MyButton(
                            bgColor: viewModel.isDataChanged.value
                                ? AppColor.primaryColor
                                : Colors.grey,
                            text: 'Cập nhật',
                            onTap: () {
                              viewModel.isDataChanged.value
                                  ? viewModel.updateUserData()
                                  : null;
                            });
                      })
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
