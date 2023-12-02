import 'package:flutter/material.dart';

class Device {
  final int id;
  final String name;
  final int areaId;
  final IconData icon;
  bool state;

  Device({
    required this.id,
    required this.name,
    required this.areaId,
    required this.icon,
    required this.state,
  });

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      id: json['id'],
      name: json['name'],
      areaId: json['areaId'],
      icon: Icons.light,
      state: json['state'],
    );
  }
}
