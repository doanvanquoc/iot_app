import 'dart:typed_data';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:iot_app/models/notification.dart';
import 'package:iot_app/view_models/authentication_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationViewModel extends GetxController {
  RxList<Noti> notifications = <Noti>[].obs;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  getNotifications() async {
    String homeId = await Get.find<AuthenticationViewModel>().getHomeId();
    FirebaseDatabase.instance
        .ref()
        .child('$homeId/notifications')
        .onValue
        .listen((event) {
      final notificationsData = event.snapshot.value;
      if (notificationsData is List<dynamic>) {
        notifications.value = notificationsData
            .where((item) => item != null)
            .map((json) => Noti.fromJson(Map<String, dynamic>.from(json)))
            .toList()
            .reversed
            .toList();
      }
      update();
    });
  }

  Future addNotification(String noti, String user) async {
    String homeId = await Get.find<AuthenticationViewModel>().getHomeId();
    String day = DateTime.now().day < 10
        ? '0${DateTime.now().day}'
        : '${DateTime.now().day}';
    String month = DateTime.now().month < 10
        ? '0${DateTime.now().month}'
        : '${DateTime.now().month}';
    String hour = DateTime.now().hour < 10
        ? '0${DateTime.now().hour}'
        : '${DateTime.now().hour}';
    String minute = DateTime.now().minute < 10
        ? '0${DateTime.now().minute}'
        : '${DateTime.now().minute}';
    String second = DateTime.now().second < 10
        ? '0${DateTime.now().second}'
        : '${DateTime.now().second}';
    await FirebaseDatabase.instance
        .ref('$homeId/notifications')
        .child('${notifications.length + 1}')
        .set({
      'date': '$day - $month - ${DateTime.now().year}',
      'time': '${hour}h : ${minute}m : ${second}s',
      'noti': noti,
      'user': user
    });

    update();
  }

  Future<void> listenToFirebellState() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userData = prefs.getString('userData');

    if (userData != null) {
      final databaseReference = FirebaseDatabase.instance.ref();
      databaseReference.child('myhome/firebell/state').onValue.listen((event) {
        final isFirebellActive = event.snapshot.value == true;
        if (isFirebellActive) {
          showFirebellNotification();
        } else {
          cancelFirebellNotification();
        }
      });
    }
  }

  Future<void> cancelFirebellNotification() async {
    await flutterLocalNotificationsPlugin.cancel(0);
  }

  Future<void> showFirebellNotification() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channel_id_0',
      'Âm thanh',
      channelDescription: 'Kênh âm thanh cảnh báo cháy',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
      sound: const RawResourceAndroidNotificationSound('firebell'),
      additionalFlags: Int32List.fromList([4]),
    );

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      'Cảnh báo!',
      'Hệ thống báo cháy đã được kích hoạt. Vui lòng kiểm tra ngay!',
      platformChannelSpecifics,
      payload: 'firebell_payload',
    );
  }

  Future<void> onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    if (notificationResponse.payload != null) {
      print('notification payload: ${notificationResponse.payload}');
    }
  }

  @override
  void onInit() {
    super.onInit();
    getNotifications();
  }
}
