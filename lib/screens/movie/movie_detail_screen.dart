import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:terafty_flutter/extensions/hexadecimal_convert.dart';

class MovieDetailScreen extends StatefulWidget {
  static const String routeName = '/streaming';

  static Route route() {
    return MaterialPageRoute(
      builder: (context) => const MovieDetailScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const MovieDetailScreen({Key? key}) : super(key: key);

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int selectedTab = 0;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(fontSize: 12),
                          ),
                          _verticalLine(),
                          Text(
                            '시즌 1개',
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(fontSize: 12),
                          ),
                          _verticalLine(),
                          Text(
                            '에피소드 5개',
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(fontSize: 12),
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
                      ),
                      const SizedBox(height: 40),
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 1,
                                color: Colors.lightBlue.shade900,
                              ),
                            ),
                          ),
                          width: size.width * 0.55,
                          child: TabBar(
                            controller: _tabController,
                            onTap: (int index) {
                              setState(() {
                                selectedTab = index;
                                _tabController.animateTo(selectedTab);
                              });
                            },
                            tabs: const [
                              Tab(
                                text: '회차',
                              ),
                              Tab(
                                text: '회차',
                              ),
                              Tab(
                                text: '회차',
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Builder(builder: (_) {
                        if (selectedTab == 0) {
                          return Tab1(size: size); //1st custom tabBarView
                        } else if (selectedTab == 1) {
                          return Container(); //2nd tabView
                        } else {
                          return Container(); //3rd tabView
                        }
                      }),
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

class Tab1 extends StatelessWidget {
  const Tab1({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButtonFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color(0xFFBDC5CB),
              ),
            ),
            constraints: BoxConstraints.tightFor(height: size.height * 0.06),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            filled: false,
          ),
          selectedItemBuilder: (BuildContext context) {
            return <String>['시즌 1', '시즌 2', '시즌 3', '시즌 4'].map((String value) {
              return Text(
                value,
                style: Theme.of(context).textTheme.headline4!.copyWith(
                      fontWeight: FontWeight.normal,
                    ),
              );
            }).toList();
          },
          isExpanded: true,
          value: '시즌 1',
          borderRadius: BorderRadius.circular(15),
          items: <String>['시즌 1', '시즌 2', '시즌 3', '시즌 4'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {},
        ),
        const SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          itemCount: 10,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) => Container(
            width: double.maxFinite,
            padding: const EdgeInsets.only(bottom: 24),
            child: Row(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 84,
                      width: 144,
                      decoration: BoxDecoration(color: Colors.blue.shade700),
                    ),
                    SvgPicture.asset('assets/images/icons/play.svg'),
                  ],
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${index + 1}화',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      const Text('00:05:30:00'),
                      const SizedBox(height: 10),
                      Text(
                        '내전으로 고립된 낯선 도시, 모가디슈 지금부터 우리의 목표내전으로 ...',
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(fontSize: 12),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
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
