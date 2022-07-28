import 'package:flutter/material.dart';
import 'package:terafty_flutter/models/screen_argument.dart';
import 'package:terafty_flutter/screens/auth/login_email_screen.dart';
import 'package:terafty_flutter/screens/auth/login_main_screen.dart';
import 'package:terafty_flutter/screens/boarding/boarding_screen.dart';
import 'package:terafty_flutter/screens/home/home_screen.dart';
import 'package:terafty_flutter/screens/movie/movie_detail_screen.dart';
import 'package:terafty_flutter/screens/movie/streaming_play_screen.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    late ScreenArguments arguments;
    if (settings.arguments != null) {
      arguments = settings.arguments as ScreenArguments;
    }
    switch (settings.name) {
      case '/':
        return BoardingScreen.route();
      case LoginMainScreen.routeName:
        return LoginMainScreen.route();
      case LoginEmailScreen.routeName:
        return LoginEmailScreen.route();
      case HomeScreen.routeName:
        return HomeScreen.route();
      case MovieDetailScreen.routeName:
        return MovieDetailScreen.route();
      case StreamingPlay.routeName:
        return StreamingPlay.route(arguments);
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
