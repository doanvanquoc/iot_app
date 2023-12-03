import 'package:flutter/material.dart';
import 'package:iot_app/common/apps/app_color.dart';
import 'package:iot_app/common/apps/app_style.dart';
import 'package:iot_app/models/notification.dart';

class CardNotification extends StatelessWidget {
  const CardNotification({
    Key? key, // Use Key? instead of super.key

    required this.icon,
    required this.notification,
  }) : super(key: key);

  final Noti notification;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 20,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColor.backgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Ngày: ${notification.date}',
                style: AppStyle.onCardSecondaryText),
            Text('Thời gian: ${notification.time}',
                style: AppStyle.onCardSecondaryText),
            Text(notification.noti, style: AppStyle.onCardPrimaryText),
            Text('Người thực hiện: ${notification.user}',
                style: AppStyle.onCardPrimaryText),
          ],
        ),
      ),
    );
  }
}
