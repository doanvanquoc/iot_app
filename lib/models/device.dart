import 'package:flutter/material.dart';

class Device {
  final int id;
  final String name;
  final int areaId;
  final IconData icon;
  bool state;
  int? lightValue;

  Device({
    required this.id,
    required this.name,
    required this.areaId,
    required this.icon,
    required this.state,
  });

  Device.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        areaId = json['areaId'],
        icon = Icons.light_outlined,
        state = json['state'],
        lightValue = json['lightValue'];
}
