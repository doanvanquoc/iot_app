import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iot_app/common/apps/app_style.dart';
import 'package:iot_app/view_models/notification_view_model.dart';
import 'package:iot_app/views/user/card_notification.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          "Thông báo",
          style: AppStyle.appBarText,
        ),
      ),
      body: GetBuilder<NotificationViewModel>(
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ListView.separated(
              itemCount: controller.notifications.length,
              itemBuilder: (context, index) {
                log("test: ${controller.notifications.length}");
                return CardNotification(
                    icon: Icons.light,
                    notification: controller.notifications[index]);
              },
              separatorBuilder: (context, index) => const SizedBox(height: 10),
            ),
          );
        },
      ),
    );
  }
}
