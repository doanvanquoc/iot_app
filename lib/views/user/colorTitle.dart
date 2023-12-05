// ignore_for_file: file_names

import 'package:flutter/material.dart';

class ColorTitle extends StatelessWidget {
  const ColorTitle({
    Key? key,
    required this.icon,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  final IconData icon;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Sử dụng onTap từ thuộc tính
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: ListTile(
          tileColor: const Color.fromRGBO(224, 231, 233, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          leading: Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.09),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(icon, color: Colors.black),
          ),
          title: Text(text, style: const TextStyle(fontSize: 16)),
          trailing: const Icon(Icons.arrow_forward_ios,
              color: Colors.black, size: 24),
        ),
      ),
    );
  }
}
