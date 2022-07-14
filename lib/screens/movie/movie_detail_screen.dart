import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:terafty_flutter/extensions/hexadecimal_convert.dart';

class MovieDetailScreen extends StatelessWidget {
  static const String routeName = '/streaming';

  static Route route() {
    return MaterialPageRoute(
      builder: (context) => const MovieDetailScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const MovieDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenPadding = MediaQuery.of(context).padding.top;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: screenPadding, left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    padding: EdgeInsets.zero,
                  )
                ],
              ),
            ),
            Column(
              children: [
                Stack(
                  children: [
                    Container(
                      constraints: BoxConstraints.expand(
                          width: double.maxFinite, height: size.height * 0.35),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/banner_1.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      constraints: BoxConstraints.expand(
                          width: double.maxFinite, height: size.height * 0.35),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: const [
                            0.05,
                            0.4,
                          ],
                          colors: [
                            const Color(0xFF131A20).withOpacity(0.7),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '우리들의 행복한 시간',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            '전체관람',
                            style: Theme.of(context).textTheme.headline6!.copyWith(fontSize: 12),
                          ),
                          _verticalLine(),
                          Text(
                            '시즌 1개',
                            style: Theme.of(context).textTheme.headline6!.copyWith(fontSize: 12),
                          ),
                          _verticalLine(),
                          Text(
                            '에피소드 5개',
                            style: Theme.of(context).textTheme.headline6!.copyWith(fontSize: 12),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Text(
                        '내전으로 고립된 낯선 도시, 모가디슈 지금부터 우리의 목표는 오로지 생존이다! 대한민국이 UN가입을 위해 동분서주하던 시기 1991년 소말리아의 수도 모가디슈에서는 일촉즉발의 내전이 일어난다.',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      const SizedBox(height: 27),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          ActionButton(
                            assets: 'assets/images/icons/like.svg',
                            text: '좋아요',
                          ),
                          SizedBox(width: 50),
                          ActionButton(
                            assets: 'assets/images/icons/Plus.svg',
                            text: '저장하기',
                          ),
                          SizedBox(width: 50),
                          ActionButton(
                            assets: 'assets/images/icons/share.svg',
                            text: '공유하기',
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(
                            double.maxFinite,
                            56,
                          ),
                        ),
                        child: Text(
                          '재생',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )
          ].reversed.toList(),
        ),
      ),
    );
  }

  SizedBox _verticalLine() {
    return SizedBox(
      height: 25,
      child: VerticalDivider(
        color: HexColor.fromHex('#BDC5CB'),
        thickness: 1,
        indent: 5,
        endIndent: 2,
        width: 15,
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final String assets;
  final String text;
  const ActionButton({
    required this.assets,
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          assets,
        ),
        Text(text),
      ],
    );
  }
}
