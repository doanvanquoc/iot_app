import 'package:flutter/material.dart';
import 'package:iot_app/common/apps/app_color.dart';
import 'package:iot_app/common/apps/app_style.dart';
import 'package:iot_app/view_models/area_view_model.dart';

import '../../../models/area.dart';

class RoomItem extends StatelessWidget {
  const RoomItem({super.key, required this.onTap, required this.area});
  final Area area;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    final areaViewModel = AreaViewModel();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Stack(
            children: [
              FutureBuilder(
                future: areaViewModel.getImageUrl(area.imgUrl),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    return Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(.5),
                            blurRadius: 2,
                            spreadRadius: 2,
                            offset: const Offset(0, 1),
                          )
                        ],
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                        image: DecorationImage(
                          image: NetworkImage(snapshot.data!),
                          fit: BoxFit.cover,
                        ),
                      ),
                      height: 160,
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
              Positioned(
                top: 20,
                left: 24,
                child: Text(area.name, style: AppStyle.onImagePrimaryText),
              ),
              const Positioned(
                top: 42,
                left: 24,
                child: Text(
                  '${3} / ${3} đang bật',
                  style: AppStyle.onImageSecondaryText,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                backgroundColor: AppColor.primaryColor,
                child: Image.asset(
                  'assets/images/led.png',
                  width: 30,
                  height: 30,
                ),
              ),
              const SizedBox(width: 8),
              CircleAvatar(
                backgroundColor: AppColor.primaryColor,
                child: Image.asset(
                  'assets/images/led.png',
                  width: 30,
                  height: 30,
                ),
              ),
              const SizedBox(width: 8),
              CircleAvatar(
                child: Image.asset(
                  'assets/images/led.png',
                  width: 30,
                  height: 30,
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
