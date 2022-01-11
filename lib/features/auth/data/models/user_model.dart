import 'dart:convert';

import 'package:test_app/features/auth/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required String login,
    required String password,
  }) : super(login: login, password: password);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      login: json['login'],
      password: json['password'],
    );
  }

  static Map<String, dynamic> toMap(UserModel user) => {
    'login': user.login,
    'password': user.password,
  };

  static String encode(List<UserModel> user) => json.encode(
    user
        .map<Map<String, dynamic>>((user) => UserModel.toMap(user))
        .toList(),
  );
  static List<UserModel> decode(String user) =>
      (json.decode(user) as List<dynamic>)
          .map<UserModel>((item) => UserModel.fromJson(item))
          .toList();
}