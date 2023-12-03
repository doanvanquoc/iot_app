// ignore_for_file: public_member_api_docs, sort_constructors_first
class Noti {
  final String date;
  final String time;
  final String noti;
  final String user;
  Noti({
    required this.date,
    required this.time,
    required this.noti,
    required this.user,
  });

  Noti.fromJson(Map<String, dynamic> json)
      : date = json['date'],
        time = json['time'],
        noti = json['noti'],
        user = json['user'];
}
