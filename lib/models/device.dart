import 'package:flutter/material.dart';

class Device {
  final int idDevice;
  final String nameDevice;
  final String area;
  final IconData icon;
  late bool state;
  Device({
    required this.idDevice,
    required this.nameDevice,
    required this.area,
    required this.icon,
    required this.state,
  });
}
