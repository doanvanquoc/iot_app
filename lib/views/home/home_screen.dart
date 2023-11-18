import 'package:flutter/material.dart';
import 'package:iot_app/common/apps/app_color.dart';
import 'package:iot_app/common/apps/app_style.dart';
import 'package:iot_app/views/home/widgets/add_area.dart';
import 'package:iot_app/views/home/widgets/add_bg.dart';
import 'package:iot_app/views/home/widgets/complete_add.dart';
import 'package:iot_app/views/home/widgets/room_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List<Widget> lstShowModal = [];

  void onNext() {
    setState(() {
      currentIndex++;
    });
    Navigator.pop(context);
    showModalBottomSheetAction();
  }

  void onBack() {
    setState(() {
      currentIndex--;
    });
    Navigator.pop(context);
    showModalBottomSheetAction();
  }

  void onDone() {
    currentIndex = 0;
    Navigator.pop(context);
  }

  void showModalBottomSheetAction() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: AppColor.backgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: lstShowModal[currentIndex],
        ),
      ),
    );
  }

  @override
  void initState() {
    lstShowModal = [
      AddArea(onNext: onNext),
      AddBackground(onNext: onNext, onBack: onBack),
      CompleteAdd(onDone: onDone)
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Trang chủ', style: AppStyle.appBarText),
        actions: [
          IconButton(
            onPressed: showModalBottomSheetAction,
            icon: const Icon(
              Icons.add_circle,
              color: AppColor.secondaryColor,
            ),
          ),
        ],
      ),
      body: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 9),
          itemCount: 3,
          itemBuilder: (_, index) {
            return const RoomItem();
          }),
    );
  }
}
