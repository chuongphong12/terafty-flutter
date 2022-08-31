import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:terafty_flutter/bloc/auth/auth_bloc.dart';
import 'package:terafty_flutter/extensions/hexadecimal_convert.dart';
import 'package:terafty_flutter/screens/auth/login_main_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List itemMenus = ['홈', '스트리밍', '크라우드 펀딩', '이벤트', '지원하기'];

    return Drawer(
      backgroundColor: Theme.of(context).primaryColor,
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context),
            _buildListItem(context, itemMenus),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) => Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 40),
      );

  Widget _buildListItem(BuildContext context, List items) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage:
                      NetworkImage('https://robohash.org/ttn?set=set4'),
                  radius: 35,
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '로그인이 필요합니다.',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    Text(
                      '로그인이 필요합니다.',
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: HexColor.fromHex('#BDC5CB')),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => ListTile(
                title: Text(
                  items[index],
                  style: Theme.of(context).textTheme.headline4,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              itemCount: items.length,
            ),
            const SizedBox(height: 200),
            ListTile(
              onTap: () {
                BlocProvider.of<AuthBloc>(context).add(LoggedOut());
                Navigator.pushNamedAndRemoveUntil(
                    context, LoginMainScreen.routeName, (route) => false);
              },
              trailing: const Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
              title: Text(
                'Logout',
                style: Theme.of(context).textTheme.headline4,
              ),
            )
          ],
        ),
      );
}
