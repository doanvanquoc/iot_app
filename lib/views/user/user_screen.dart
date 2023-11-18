import 'package:flutter/material.dart';
import 'package:iot_app/common/apps/app_color.dart';
import 'package:iot_app/common/apps/app_style.dart';
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

              GestureDetector(
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context) => const EditUserScreen(),),);
                },
                child: colorTile(Icons.person, Colors.black, "Thông tin cá nhân"),
              ),
              GestureDetector(
                onTap: (){},
                child: colorTile(Icons.settings, Colors.black, "Cài đặt"),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,MaterialPageRoute(builder: (context) => const NotificationScreen(),),);
                },
                child: colorTile(Icons.notifications, Colors.black, "Thông báo"),
              ),

              GestureDetector(
                onTap: (){},
                child: colorTile(Icons. login, Colors.black, "Đăng xuất"),
              )
            ],
          ),
        ),
      ),
    );
  }
}


Widget colorTile(IconData icon, Color color, String text) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 15), 
    child: ListTile(
      tileColor: const Color.fromRGBO(224, 231, 233, 1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      leading: Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
          color: color.withOpacity(0.09),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Icon(icon, color: color),
      ),
      title: Text(text,style:const TextStyle(fontSize: 16),),
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.black, size: 24),
    ),
  );
}


