import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:terafty_flutter/bloc/login/login_bloc.dart';
import 'package:terafty_flutter/extensions/hexadecimal_convert.dart';
import 'package:terafty_flutter/screens/home/home_screen.dart';

class LoginForm extends StatelessWidget {
  LoginForm({
    Key? key,
  }) : super(key: key);

  final formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    void _onButtonPressed() async {
      formKey.currentState!.save();
      if (formKey.currentState!.validate()) {
        final data = formKey.currentState!.value;
        try {
          BlocProvider.of<LoginBloc>(context).add(
            LoginButtonPressed(
              email: data['email'],
              password: data['password'],
            ),
          );
        } catch (e) {
          print(e.toString());
        }
      }
    }

    return FormBuilder(
      key: formKey,
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, (route) => false);
          }
          if (state is LoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Login Failed'),
              ),
            );
          }
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.email(errorText: 'Please input valid email'),
                FormBuilderValidators.required(errorText: 'Email is required'),
              ]),
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
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(errorText: 'Password is required'),
              ]),
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                _onButtonPressed();
              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(double.maxFinite, 56),
              ),
              child: Text(
                '로그인하기',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
