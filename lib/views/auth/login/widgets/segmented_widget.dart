import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iot_app/view_models/login_view_model.dart';

class SegmentedController extends StatelessWidget {
  final LoginViewModel viewModel;

  const SegmentedController({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(4),
        decoration: const BoxDecoration(
          color: Color(0xffE0E7E9),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: CustomSlidingSegmentedControl<int>(
          isStretch: true,
          initialValue: 1,
          onValueChanged: viewModel.onSegmentChanged,
          children: {
            1: _buildSegmentText('Email', 1),
            2: _buildSegmentText('Số điện thoại', 2),
          },
          decoration: const BoxDecoration(
            color: Color(0xffF4F9F9),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          thumbDecoration: BoxDecoration(
            color: const Color(0xff8FACC0),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.3),
                blurRadius: 4.0,
                spreadRadius: 1.0,
                offset: const Offset(0.0, 2.0),
              ),
            ],
          ),
          duration: const Duration(milliseconds: 70),
          curve: Curves.easeInToLinear,
        ),
      ),
    );
  }

  Text _buildSegmentText(String text, int value) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.w600,
        color: viewModel.selectedSegment.value == value
            ? const Color(0xffF7FBFC)
            : const Color(0xff484D51),
      ),
    );
  }
}
