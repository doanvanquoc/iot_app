import 'package:flutter/material.dart';
import 'package:iot_app/common/apps/app_color.dart';
import 'package:iot_app/common/apps/app_style.dart';

class CardNotification extends StatelessWidget {
  const CardNotification({
    Key? key, // Use Key? instead of super.key
    required this.deviceName,
    required this.area,
    required this.icon,
    required this.time,
    required this.date,
  }) : super(key: key);

  final String deviceName;
  final String area;
  final IconData icon;
  final String time;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 20,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColor.backgroundColor,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 70),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Ngày: $date', style: AppStyle.onCardSecondaryText),
              Text('Thời gian: $time', style: AppStyle.onCardSecondaryText),
              Text('$deviceName $area', style: AppStyle.onCardPrimaryText),
            ],
          )
        ],
      ),
    );
  }
}
