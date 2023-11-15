
import 'package:flutter/cupertino.dart';
import 'package:iot_app/common/apps/app_color.dart';
import 'package:iot_app/common/apps/app_style.dart';

class MyCard extends StatelessWidget {
  const MyCard(
      {super.key,
      required this.deviceName,
      required this.area,
      required this.icon,
      required this.onChanged, required this.value});

  final String deviceName;
  final String area;
  final IconData icon;
  final Function(bool value) onChanged;
  final bool value;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColor.backgroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, size: 40),
              const SizedBox(width: 100),
              CupertinoSwitch(
                  value: value,
                  onChanged: onChanged,
                  activeColor: AppColor.primaryColor),
            ],
          ),
          const SizedBox(height: 16),
          Text(deviceName, style: AppStyle.onCardPrimaryText),
          Text(area, style: AppStyle.onCardSecondaryText),
        ],
      ),
    );
  }
}
