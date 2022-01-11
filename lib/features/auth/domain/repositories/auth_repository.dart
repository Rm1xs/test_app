import 'package:test_app/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<void> logInWithPassword(String login, String password);

  Future<User> get currentUser;

  Future<void> logOut();
}
