import 'package:flutter/material.dart';
import 'package:terafty_flutter/extensions/hexadecimal_convert.dart';
import 'package:terafty_flutter/screens/auth/login_main_screen.dart';

class BoardingScreen extends StatelessWidget {
  static const String routeName = '/boarding';

  static Route route() {
    return MaterialPageRoute(
      builder: (context) => const BoardingScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const BoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            constraints: const BoxConstraints.expand(),
            decoration: BoxDecoration(
              color: HexColor.fromHex('161F26'),
              image: const DecorationImage(
                image: AssetImage("assets/images/boarding.png"),
                fit: BoxFit.cover,
                opacity: 0.4,
              ),
            ),
          ),
          Container(
            constraints: const BoxConstraints.expand(),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  HexColor.fromHex('161F26'),
                  Colors.transparent,
                  HexColor.fromHex('161F26'),
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(height: 40),
                Image.asset(
                  'assets/images/Terafty.png',
                  scale: 1.5,
                ),
                const SizedBox(height: 60),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '로그인하고 더 많은 서비스를 이용하세요.',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    const SizedBox(height: 22),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, LoginMainScreen.routeName);
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(width * 0.9, 60),
                      ),
                      child: Text(
                        '로그인하기',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(width * 0.9, 60),
                        primary: Colors.transparent,
                        side: const BorderSide(width: 1, color: Colors.white),
                      ),
                      child: Text(
                        '로그인하기',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
