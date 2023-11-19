import 'package:flutter/material.dart';
import 'package:iot_app/common/apps/app_style.dart';
import 'package:iot_app/views/user/card_notification.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Thông báo",style: AppStyle.appBarText,),
      ),
      body:  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
            shrinkWrap: true,
            children: const [
              CardNotification(
                deviceName: 'Mở cửa',
                area: 'chính',
                icon: Icons.door_front_door_outlined,
                time: '12:59:59',
                date: '10/10/2023',
              ),
              SizedBox(height: 10,),

              CardNotification(
                deviceName: 'Bật đèn',
                area: 'Phòng khách',
                icon: Icons.light_mode_sharp,
                time: '12:59:59',
                date: '10/10/2023',
              ),
              SizedBox(height: 10,),
              
              CardNotification(
                deviceName: 'Tắt đèn',
                area: 'Phòng khách',
                icon: Icons.nightlight,
                time: '12:59:59',
                date: '10/10/2023',
              ),
              SizedBox(height: 10,),
              
              CardNotification(
                deviceName: 'Bật đèn',
                area: 'Phòng bếp',
                icon: Icons.light_mode_sharp,
                time: '12:59:59',
                date: '10/10/2023',
              ),
              SizedBox(height: 10,),
              
              CardNotification(
                deviceName: 'Tắt đèn',
                area: 'phòng bếp',
                icon: Icons.nightlight,
                time: '12:59:59',
                date: '10/10/2023',
              ),
              SizedBox(height: 10,),
              
              CardNotification(
                deviceName: 'Mở cửa',
                area: 'chính',
                icon: Icons.door_front_door_outlined,
                time: '12:59:59',
                date: '10/10/2023',
              ),
              SizedBox(height: 10,),
              
              CardNotification(
                deviceName: 'Mở cửa',
                area: 'chính',
                icon: Icons.door_front_door_outlined,
                time: '12:59:59',
                date: '10/10/2023',
              ),
              SizedBox(height: 10,),

              CardNotification(
                deviceName: 'Mở cửa',
                area: 'chính',
                icon: Icons.door_front_door_outlined,
                time: '12:59:59',
                date: '10/10/2023',
              ),
              SizedBox(height: 10,),
              
              CardNotification(
                deviceName: 'Mở cửa',
                area: 'chính',
                icon: Icons.door_front_door_outlined,
                time: '12:59:59',
                date: '10/10/2023',
              ),
            ],
          ),
      ),
      );
  }
}
