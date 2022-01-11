import 'package:test_app/features/auth/data/datasources/auth_local_data_source_implementation.dart';
import 'package:test_app/features/auth/domain/entities/user.dart';
import 'package:test_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSourceImpl localDataSourceImpl;

  AuthRepositoryImpl({required this.localDataSourceImpl});

  @override
  Future<User> get currentUser => localDataSourceImpl.currentUser;

  @override
  Future<void> logInWithPassword(String login, String password) {
    return localDataSourceImpl.logInWithPassword(login, password);
  }

  @override
  Future<void> logOut() {
    return localDataSourceImpl.logOut();
  }
}
