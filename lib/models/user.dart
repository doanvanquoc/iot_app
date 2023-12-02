class UserModel {
  String? avatar;
  String email;
  String fullname;
  String password;
  String phoneNo;

  UserModel({
    this.avatar,
    required this.email,
    required this.fullname,
    required this.password,
    required this.phoneNo,
  });

  UserModel.fromMap(Map<String, dynamic> map)
      : avatar = map['avatar'],
        email = map['email'],
        fullname = map['fullname'],
        password = map['password'],
        phoneNo = map['phoneNo'];

  Map<String, dynamic> toJson() {
    return {
      'avatar': avatar,
      'email': email,
      'fullname': fullname,
      'password': password,
      'phoneNo': phoneNo,
    };
  }

  static UserModel fromJson(Map<String, dynamic> json) {
    return UserModel(
      avatar: json['avatar'],
      email: json['email'],
      fullname: json['fullname'],
      password: json['password'],
      phoneNo: json['phoneNo'],
    );
  }

  @override
  String toString() {
    return 'User{avatar: $avatar, email: $email, fullname: $fullname, password: $password, phoneNo: $phoneNo}';
  }
}
