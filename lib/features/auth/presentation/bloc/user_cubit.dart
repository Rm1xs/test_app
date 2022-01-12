import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/features/auth/domain/entities/user.dart';
import 'package:test_app/features/auth/domain/usecases/auth_usecase.dart';

class UserCubit extends Cubit<void> {
  UserCubit(this._auth) : super(null);
  final AuthUseCase _auth;

  void addUser(String login, String password) async {
    await _auth.logInWithPassword(login, password);
  }

  Future<User> check() async {
    return await _auth.currentUser;
  }

  Future<void> logOut() async {
    await _auth.logOut();
  }
}
