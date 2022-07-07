import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:terafty_flutter/extensions/hexadecimal_convert.dart';
import 'package:terafty_flutter/screens/home/home_screen.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey formKey = GlobalKey<FormBuilderState>();
    return FormBuilder(
      key: formKey,
      child: Column(
        children: [
          FormBuilderTextField(
            name: 'email',
            decoration: InputDecoration(
              hintText: '이메일 주소 (example@gmail.com)',
              hintStyle: TextStyle(
                color: HexColor.fromHex('#BDC5CB'),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 8),
          FormBuilderTextField(
            name: 'password',
            decoration: InputDecoration(
              hintText: '비밀번호',
              hintStyle: TextStyle(
                color: HexColor.fromHex('#BDC5CB'),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, HomeScreen.routeName, (route) => false);
            },
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(double.maxFinite, 56),
            ),
            child: Text(
              '로그인하기',
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
