import 'package:flutter/material.dart';
import 'package:iot_app/common/apps/app_color.dart';

class TextEditUser extends StatelessWidget {
  const TextEditUser({Key? key, required this.label, required this.controller})
      : super(key: key);
  final String label;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 20,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 5),
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.secondaryColor),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.primaryColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
