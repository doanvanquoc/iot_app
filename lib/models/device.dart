import 'package:flutter/material.dart';

// class Device {
//   final int idDevice;
//   final String nameDevice;
//   final String area;
//   final IconData icon;
//   late bool state;
//   Device({
//     required this.idDevice,
//     required this.nameDevice,
//     required this.area,
//     required this.icon,
//     required this.state,
//   });
// }

class Device {
  final int idDevice;
  final String nameDevice;
  final int idArea;
  final IconData icon;
  bool state; // Removed 'final' to make it mutable

  Device({
    required this.idDevice,
    required this.nameDevice,
    required this.idArea,
    required this.icon,
    required this.state,
  });

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      idDevice: json['idDevice'],
      nameDevice: json['nameDevice'],
      idArea: json['idArea'],
      icon: Icons.light,
      state: json['state'],
    );
  }
}
