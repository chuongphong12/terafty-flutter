import 'package:flutter/material.dart';
import 'package:terafty_flutter/extensions/hexadecimal_convert.dart';

class LoginMainScreen extends StatelessWidget {
  static const String routeName = '/login';

  static Route route() {
    return MaterialPageRoute(
      builder: (context) => const LoginMainScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const LoginMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: HexColor.fromHex('#1C1D1E'),
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
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                        color: Colors.white,
                      ),
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
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                          color: Colors.white,
                        ),
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
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
