import 'package:flutter/material.dart';
import 'package:test_app/features/auth/presentation/pages/login_page.dart';

const String loginPage = '/loginPage';
const String guestCamerasPage = '/guestCamerasPage';
const String authCameraPage = '/authCameraPage';

class CustomRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginPage:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case guestCamerasPage:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case authCameraPage:
        return MaterialPageRoute(builder: (_) => Center(child: Text('auth ${settings.name}')));
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
