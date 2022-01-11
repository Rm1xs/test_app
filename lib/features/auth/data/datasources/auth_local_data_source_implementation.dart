import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_app/features/auth/data/models/user_model.dart';
import 'package:test_app/features/auth/domain/entities/user.dart';
import 'auth_local_data_source.dart';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;
  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  AuthLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<User> get currentUser async {
    try {
      String result = '';
      await prefs.then((value) {
        if (value.getString('user') != null) {
          result = value.getString('user')!;
        }
      });
      if (result.isNotEmpty) {
        final List<UserModel> user = UserModel.decode(result);
        var currentUser = user.first.toUser;
        return currentUser;
      } else {
        return User.empty;
      }
    } on Exception {
      return User.empty;
    }
  }

  Future<String?> getUser() async {
    String? result = '';
    await prefs.then((value) => {result = value.getString('user')});
    return result;
  }

  @override
  Future<void> logInWithPassword(String login, String password) async {
    try {
      final String encodedData = UserModel.encode([
        UserModel(login: login, password: password),
      ]);

      await prefs.then((value) => value.setString('user', encodedData));
      var x = await prefs.then((value) => value.getString('user'));
    } on Exception {
      throw Exception('error');
    }
  }

  @override
  Future<void> logOut() async {
    await prefs.then((value) => value.remove('user'));
  }
}

extension on UserModel {
  User get toUser {
    return User(login: login, password: password);
  }
}
