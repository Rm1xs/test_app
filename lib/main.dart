import 'package:flutter/material.dart';
import 'package:test_app/features/auth/presentation/bloc/user_cubit.dart';
import 'features/auth/domain/entities/user.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/camera/presentation/authenticated/pages/camera_page_authenticated.dart';
import 'features/camera/presentation/guest/pages/camera_page.dart';
import 'features/filters/presentation/widgets/filters_widget.dart';
import 'injection.dart' as di;
import 'injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Test App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder<User>(
        future: sl<UserCubit>().check(),
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          switch (snapshot.connectionState) {
            default:
              if (snapshot.data!.login!.isNotEmpty &&
                  snapshot.data!.password!.isNotEmpty) {
                return const CameraPageAuthenticated();
              } else {
                return const LoginPage();
              }
          }
        },
      ),
    );
  }
}
