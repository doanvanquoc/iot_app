import 'package:get/get.dart';
import 'package:iot_app/models/device.dart';
import 'package:iot_app/view_models/detail_room_model/view.dart';
import 'package:iot_app/view_models/device_view_model/device_view_model.dart';

class Area {
  final viewModel = Get.put(DeviceViewModel());
  final int id;
  final String name;
  final String imgUrl = "assets/images/living_room.png";
  List<Device>? devices;

  Area({required this.id, required this.name});

  Area.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        devices = [];
}
