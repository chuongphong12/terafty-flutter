import 'package:flutter/material.dart';
import 'package:terafty_flutter/screens/auth/login_email_screen.dart';
import 'package:terafty_flutter/screens/auth/login_main_screen.dart';
import 'package:terafty_flutter/screens/boarding/boarding_screen.dart';
import 'package:terafty_flutter/screens/home/home_screen.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return BoardingScreen.route();
      case LoginMainScreen.routeName:
        return LoginMainScreen.route();
      case LoginEmailScreen.routeName:
        return LoginEmailScreen.route();
      case HomeScreen.routeName:
        return HomeScreen.route();
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      builder: (context) => const Scaffold(
        body: Center(
          child: Text('Error'),
        ),
      ),
      settings: const RouteSettings(name: '/error'),
    );
  }
}
