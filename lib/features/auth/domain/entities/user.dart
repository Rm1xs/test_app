class User {
  const User({required this.login, this.password});

  final String? login;

  final String? password;

  static User empty = const User(login: '', password: '');

  bool get isEmpty => this == User.empty;

  bool get isNotEmpty => this != User.empty;
}
