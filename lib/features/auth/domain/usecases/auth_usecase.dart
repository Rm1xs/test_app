import 'package:test_app/features/auth/domain/entities/user.dart';
import 'package:test_app/features/auth/domain/repositories/auth_repository.dart';

class AuthUseCase {
  final AuthRepository repository;

  AuthUseCase(this.repository);

  Future<User> get currentUser {
    return repository.currentUser;
  }

  Future<void> logInWithPassword(String login, String password) async {
    return await repository.logInWithPassword(login, password);
  }

  Future<void> logOut() async {
    await repository.logOut();
  }
}
