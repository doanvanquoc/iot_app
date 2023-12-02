import 'package:get/get.dart';
import 'package:iot_app/models/device.dart';
import 'package:iot_app/view_models/device_view_model/device_view_model.dart';

class Area {
  final viewModel = Get.put(DeviceViewModel());
  final int id;
  final String name;

  final String imgUrl;
  List<Device> devices;

  Area(
      {required this.id,
      required this.name,
      required this.imgUrl,
      required this.devices});

  Area.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        imgUrl = json['imgUrl'],
        devices = [];
}
