import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';

  static Route route() {
    return MaterialPageRoute(
      builder: (context) => const HomeScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: Text('Home Screen'),
    ));
  }
}
