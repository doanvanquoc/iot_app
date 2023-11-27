// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:iot_app/common/apps/app_style.dart';
// import 'package:iot_app/common/widgets/my_card.dart';
// import 'package:iot_app/models/room.dart';
// import 'package:iot_app/view_models/detail_room_model/view.dart';

// class Living_Item extends StatelessWidget {
//   Living_Item({super.key, required this.room});
//   final Room room;
//   bool isswit = false;

//   @override
//   Widget build(BuildContext context) {
//     viewModel view = Get.put(viewModel());
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Stack(
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(.5),
//                     blurRadius: 2,
//                     spreadRadius: 2,
//                     offset: const Offset(0, 1),
//                   )
//                 ],
//                 borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(16),
//                   topRight: Radius.circular(16),
//                 ),
//                 image: DecorationImage(
//                   image: AssetImage(room.imgUrl),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               height: 160,
//             ),
//             Positioned(
//               top: 20,
//               left: 24,
//               child: Text(room.name, style: AppStyle.onImagePrimaryText),
//             ),
//             Positioned(
//               top: 42,
//               left: 24,
//               child: Text(
//                 '${room.turningDevices} / ${room.totalDevices} đang bật',
//                 style: AppStyle.onImageSecondaryText,
//               ),
//             ),
//           ],
//         ),
//         const Padding(
//           padding: EdgeInsets.all(10.0),
//           child: Text("Thiết Bị",
//               style: TextStyle(
//                 color: Color(0xff484D51),
//                 fontSize: 18,
//               )),
//         ),
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(5.0),
//               child: MyCard(
//                   deviceName: "Điều hòa",
//                   area: room.name,
//                   icon: Icons.air,
//                   onChanged: view.onHandelSwitch,
//                   value: true),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(5.0),
//               child: MyCard(
//                   deviceName: "Điều hòa",
//                   area: room.name,
//                   icon: Icons.air,
//                   onChanged: view.onHandelSwitch,
//                   value: true),
//             )
//           ],
//         ),
//         Padding(
//           padding: const EdgeInsets.all(5.0),
//           child: MyCard(
//               deviceName: "Quạt",
//               area: room.name,
//               icon: Icons.wind_power,
//               onChanged: view.onHandelSwitch,
//               value: true),
//         )
//         // GridView(gridDelegate: gridDelegate)
//       ],
//     );
//   }
// }
