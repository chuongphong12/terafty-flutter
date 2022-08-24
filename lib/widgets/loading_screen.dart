import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  static const String routeName = '/';

  static Route route() {
    return MaterialPageRoute(
      builder: (context) => const LoadingScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
