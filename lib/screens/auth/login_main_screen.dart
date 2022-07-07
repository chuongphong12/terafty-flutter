import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:terafty_flutter/extensions/hexadecimal_convert.dart';
import 'package:terafty_flutter/screens/auth/login_email_screen.dart';

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
            const SizedBox(height: 30),
            Image.asset(
              'assets/images/Terafty.png',
              scale: 1.5,
            ),
            const SizedBox(height: 120),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(width * 0.9, 60),
                    primary: Colors.white,
                  ),
                  icon: const Icon(
                    EvaIcons.google,
                    color: Colors.black,
                  ),
                  label: Text(
                    'Google로 계속하기',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton.icon(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(width * 0.9, 60),
                    primary: HexColor.fromHex('#FFCA42'),
                  ),
                  icon: const Icon(
                    EvaIcons.messageCircle,
                    color: Colors.black,
                  ),
                  label: Text(
                    '카카오로 계속하기',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, LoginEmailScreen.routeName);
                  },
                  icon: const Icon(Icons.mail),
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(width * 0.9, 60),
                    primary: HexColor.fromHex('#5A5A5A'),
                  ),
                  label: Text(
                    '이메일로 로그인하기',
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '아이디가 없나요?',
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                    const SizedBox(width: 5),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        '회원가입하세요.',
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              color: Colors.white,
                              decoration: TextDecoration.underline,
                            ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
              ],
            )
          ],
        ),
      ),
    );
  }
}
