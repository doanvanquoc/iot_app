import 'package:flutter/material.dart';
import 'package:iot_app/common/apps/app_color.dart';
import 'package:iot_app/common/apps/app_style.dart';
import 'package:iot_app/common/widgets/my_button.dart';

class AddBackground extends StatelessWidget {
  const AddBackground({super.key, required this.onNext, required this.onBack});
  final Function() onNext;
  final Function() onBack;
  @override
  Widget build(BuildContext context) {
    List<String> imgs = [
      'assets/images/bg1.png',
      'assets/images/bg2.png',
      'assets/images/bg3.png',
      'assets/images/bg4.png',
      'assets/images/bg5.png',
      'assets/images/bg6.png',
    ];
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.cancel,
              ),
            )
          ],
        ),
        Text(
          'Ảnh nền',
          style: AppStyle.appBarText.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 16,
            childAspectRatio: 3 / 2,
          ),
          itemCount: imgs.length,
          itemBuilder: (_, index) {
            return Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: AssetImage(imgs[index]),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 16),
        MyButton(text: 'Tiếp tục', onTap: onNext),
        const SizedBox(height: 8),
        MyButton(
          text: 'Trở về',
          textStyle: AppStyle.buttonText.copyWith(color: AppColor.primaryColor),
          onTap: onBack,
          bgColor: Colors.transparent,
        ),
      ],
    );
  }
}
