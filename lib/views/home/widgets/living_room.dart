import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iot_app/common/apps/app_style.dart';
import 'package:iot_app/common/widgets/my_card.dart';
import 'package:iot_app/models/area.dart';
import 'package:iot_app/view_models/area_view_model.dart';

class AreaDetailItem extends StatelessWidget {
  const AreaDetailItem({super.key, required this.area});
  final Area area;

  @override
  Widget build(BuildContext context) {
    AreaViewModel areaViewModel = Get.find();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            FutureBuilder(
              future: areaViewModel.getImageUrl(area.imgUrl),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
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
            GetBuilder<AreaViewModel>(builder: (controller) {
              return Positioned(
                top: 42,
                left: 24,
                child: Text(
                  '${area.devices.where((element) => element.state).length} / ${area.devices.length} đang bật',
                  style: AppStyle.onImageSecondaryText,
                ),
              );
            }),
          ],
        ),
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text("Thiết Bị",
              style: TextStyle(
                color: Color(0xff484D51),
                fontSize: 18,
              )),
        ),
        Expanded(
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16.0,
              childAspectRatio: 1.2,
            ),
            itemCount: area.devices.length,
            itemBuilder: (_, int index) {
              return GetBuilder<AreaViewModel>(builder: (context) {
                return MyCard(
                  device: area.devices[index],
                );
              });
            },
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Mô Tả",
                    style: TextStyle(
                      color: Color(0xff484D51),
                      fontSize: 18,
                    )),
                Text(area.des),
                if (area.devices.firstWhereOrNull(
                        (element) => element.lightValue != null) !=
                    null)
                  GetBuilder<AreaViewModel>(builder: (context) {
                    return Text(
                        'Độ sáng hiện tại: ${area.devices.singleWhere((element) => element.lightValue != null).lightValue}/100');
                  })
              ],
            ),
          ),
        ),
      ],
    );
  }
}
