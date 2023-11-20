import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iot_app/common/apps/app_color.dart';

class MyBottomNavBar extends StatelessWidget {
  const MyBottomNavBar({super.key});
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      fixedColor: AppColor.primaryColor,
      items: const [
        BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.house), label: 'Trang chủ'),
        BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.lightbulb), label: 'Thiết bị'),
        BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.user), label: 'Cá nhân'),
      ],
    );
  }
}
