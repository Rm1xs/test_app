import 'package:test_app/features/auth/domain/entities/user.dart';

abstract class AuthLocalDataSource {
  Future<void> logInWithPassword(String login, String password);

  Future<User> get currentUser;

  Future<void> logOut();
}

