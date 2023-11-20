import 'package:flutter/material.dart';
import 'package:iot_app/common/apps/app_color.dart';
import 'package:iot_app/common/apps/app_style.dart';
import 'package:iot_app/views/user/colorTitle.dart';
import 'package:iot_app/views/user/editUser_screen.dart';
import 'package:iot_app/views/user/notification_screen.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tài khoản",style: AppStyle.appBarText,),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding:  const EdgeInsets.all(5),
          child: Column(
            children: [

              /// -- Hình đại diện
              Stack(
                children: [
                  SizedBox(
                    width: 110,
                    height: 110,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100), child:  const Image(image: AssetImage('assets/images/logo.png'))),
                  ),
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
                ],
              ),
              const SizedBox(height: 10),
              const Text("Anh Quân",style: TextStyle(fontSize: 20,color: Color.fromRGBO(72, 77, 81, 1),fontWeight: FontWeight.bold),),
              const SizedBox(height: 20),

              ColorTitle(
                icon: Icons.person,
                text: "Thông tin cá nhân",
                onTap: () {
                  Navigator.push(context,MaterialPageRoute(builder: (context) => const EditUserScreen()),);
                },
              ),

              ColorTitle(
                icon: Icons.settings,
                text: "Cài đặt",
                onTap: () {},
              ),

              ColorTitle(
                icon: Icons.notifications,
                text: "Thông báo",
                onTap: () {
                   Navigator.push(context,MaterialPageRoute(builder: (context) => const NotificationScreen(),),);
                },
              ),

              ColorTitle(
                icon: Icons.logout,
                text: "Đăng xuất",
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}



