import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:iot_app/models/notification.dart';
import 'package:iot_app/view_models/authentication_view_model.dart';

class NotificationViewModel extends GetxController {
  RxList<Noti> notifications = <Noti>[].obs;

  // addNoti(DateTime dateTime, String noti) {
  //   final notification = Noti(datetime: dateTime, noti: noti);
  //   notifications.add(notification);
  // }

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

  @override
  void onInit() {
    super.onInit();
    getNotifications();
  }
}
