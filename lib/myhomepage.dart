import 'package:flutter/material.dart';
import 'package:iot_app/common/widgets/my_card.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(mainAxisSize: MainAxisSize.min, children: [
        MyCard(
            deviceName: 'deviceName',
            area: 'area',
            icon: Icons.person,
            onChanged: (value) {},
            value: true),
        MyCard(
            deviceName: 'deviceName',
            area: 'area',
            icon: Icons.person,
            onChanged: (value) {},
            value: true),
      ]),
    );
  }
}
