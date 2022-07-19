import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:terafty_flutter/bloc/streaming/streaming_bloc.dart';
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
                  child: BlocBuilder<StreamingBloc, StreamingState>(
                    builder: (context, state) {
                      if (state is StreamingLoading) {
                        return const Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      }
                      if (state is StreamingLoaded) {
                        final streaming = state.streaming;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              streaming.titleKr,
                              style: Theme.of(context).textTheme.headline2,
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Text(
                                  streaming.categoryGenre.nameKr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(fontSize: 12),
                                ),
                                _verticalLine(),
                                Text(
                                  '시즌 ${streaming.quantitySeason}개',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(fontSize: 12),
                                ),
                                _verticalLine(),
                                Text(
                                  '에피소드 ${streaming.quantityEpisodes}개',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(fontSize: 12),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            Text(
                              streaming.storyKr,
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
                                return Tab2(size: size); //2nd tabView
                              } else {
                                return Tab3(size: size); //3rd tabView
                              }
                            }),
                          ],
                        );
                      } else {
                        return const Center(
                          child: Text('Something went wrong!'),
                        );
                      }
                    },
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

class Tab3 extends StatelessWidget {
  final Size size;
  const Tab3({
    required this.size,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField(
          icon: const Icon(Icons.arrow_drop_down_circle_outlined),
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
        const SizedBox(height: 16),
        DropdownButtonFormField(
          icon: const Icon(Icons.arrow_drop_down_circle_outlined),
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
            return <String>['1회차', '2회차', '3회차', '4회차'].map((String value) {
              return Text(
                value,
                style: Theme.of(context).textTheme.headline4!.copyWith(
                      fontWeight: FontWeight.normal,
                    ),
              );
            }).toList();
          },
          isExpanded: true,
          value: '1회차',
          borderRadius: BorderRadius.circular(15),
          items: <String>['1회차', '2회차', '3회차', '4회차'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {},
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: BoxConstraints.tightFor(width: size.width * 0.8),
          child: Text(
            '한비수가 한비수에게 줄 생일 선물을 골라 주세요.',
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          '내전으로 고립된 낯선 도시, 모가디슈 지금부터 우리의 목표는 오로지 생존이다! 대한민국이 UN가입을 위해 동분서주하던 시기 1991년 소말리아의 수도 모가디슈에서는 일촉즉발의 내전이 일어난다.',
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(height: 16),
        Text(
          '기간: 2021.12.12 ~ 2021.12.12',
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(fontSize: 12, color: const Color(0xFF888F95)),
        ),
        const ProductListView(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset('assets/images/icons/User.svg'),
                const SizedBox(width: 7),
                Text(
                  '490명 참여',
                  style: Theme.of(context).textTheme.headline6,
                )
              ],
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(157, 48),
              ),
              onPressed: () {},
              child: Text(
                '투표하기',
                style: Theme.of(context).textTheme.headline5,
              ),
            )
          ],
        )
      ],
    );
  }
}

class ProductListView extends StatelessWidget {
  const ProductListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 2,
      padding: const EdgeInsets.symmetric(vertical: 20),
      itemBuilder: (context, index) => Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: ListTile(
          leading: Image.asset('assets/images/product.png', fit: BoxFit.cover),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(
              color: Color(0xFF2A343D),
            ),
          ),
          title: Text(
            'A. 버버리 포이베 파우치',
            style: Theme.of(context).textTheme.headline4,
          ),
          minVerticalPadding: 30,
          minLeadingWidth: 80,
          trailing: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.check_circle_outline_outlined,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class Tab2 extends StatelessWidget {
  final Size size;
  const Tab2({
    required this.size,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '등장인물',
          style: Theme.of(context).textTheme.headline2,
        ),
        const SizedBox(height: 8),
        const ActorHorizontalList(),
        const SizedBox(height: 48),
        Text(
          '줄거리',
          style: Theme.of(context).textTheme.headline2,
        ),
        const SizedBox(height: 8),
        Text(
          '내전으로 고립된 낯선 도시, 모가디슈 지금부터 우리의 목표는 오로지 생존이다! 대한민국이 UN가입을 위해 동분서주하던 시기 1991년 소말리아의 수도 모가디슈에서는 일촉즉발의 내전이 일어난다.',
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(height: 48),
        Text(
          '제작정보',
          style: Theme.of(context).textTheme.headline2,
        ),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          crossAxisSpacing: 10,
          childAspectRatio: (21 / 4),
          children: List.generate(
            3,
            (index) => Row(
              children: [
                Text(
                  '감독',
                  style: Theme.of(context).textTheme.headline5,
                ),
                const SizedBox(width: 10),
                Text(
                  '한비수',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: size.height * 0.2)
      ],
    );
  }
}

class ActorHorizontalList extends StatelessWidget {
  const ActorHorizontalList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 6,
        itemBuilder: (context, index) => Container(
          margin: const EdgeInsets.only(right: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/actor.png',
                scale: 1.75,
              ),
              const SizedBox(height: 5),
              Text(
                '한비수 역',
                style: Theme.of(context).textTheme.headline6,
              ),
              const Text('이민기'),
            ],
          ),
        ),
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
          icon: const Icon(Icons.arrow_drop_down_circle_outlined),
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
        const EpisodeList()
      ],
    );
  }
}

class EpisodeList extends StatelessWidget {
  const EpisodeList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
                    '내전으로 고립된 낯선 도시, 모가디슈 지금부터 우리의 목표내전으로...',
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
