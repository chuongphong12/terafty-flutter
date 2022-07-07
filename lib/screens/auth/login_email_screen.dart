import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:terafty_flutter/widgets/login_form.dart';

class LoginEmailScreen extends StatefulWidget {
  static const String routeName = '/login/email';

  static Route route() {
    return MaterialPageRoute(
      builder: (context) => LoginEmailScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  final GlobalKey _formkey = GlobalKey<FormBuilderState>();
  LoginEmailScreen({Key? key}) : super(key: key);

  @override
  State<LoginEmailScreen> createState() => _LoginEmailScreenState();
}

class _LoginEmailScreenState extends State<LoginEmailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 80),
                  Text(
                    '로그인',
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '이메일과 비밀번호를 입력해주세요.',
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                  const SizedBox(height: 12),
                  const LoginForm(),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '비밀번호 찾기',
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                        ),
                  ),
                  const SizedBox(height: 16),
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
                      Text(
                        '회원가입하세요.',
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              color: Colors.white,
                              decoration: TextDecoration.underline,
                            ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}
