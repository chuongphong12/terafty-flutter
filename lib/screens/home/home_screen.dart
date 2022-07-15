import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:terafty_flutter/bloc/popular/popular_bloc.dart';
import 'package:terafty_flutter/screens/movie/movie_detail_screen.dart';
import 'package:terafty_flutter/widgets/app_drawer.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

  static Route route() {
    return MaterialPageRoute(
      builder: (context) => const HomeScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int activeIndex = 0;

  @override
  void initState() {
    BlocProvider.of<PopularBloc>(context).add(LoadPopularContent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenPadding = MediaQuery.of(context).padding.top;
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: screenPadding),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      _scaffoldKey.currentState!.openDrawer();
                    },
                    icon: const Icon(
                      Icons.menu,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      'Terafty',
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                            fontFamily: 'Galada',
                            color: Colors.white,
                            fontSize: 24,
                          ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      EvaIcons.search,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselSlider(
                  items: List.generate(
                    4,
                    (index) => Stack(
                      children: [
                        Container(
                          constraints: const BoxConstraints.expand(),
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/banner_1.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          constraints: const BoxConstraints.expand(),
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: [
                                0.05,
                                0.4,
                                0.9,
                              ],
                              colors: [
                                Color(0xFF131A20),
                                Colors.transparent,
                                Color(0xFF131A20),
                              ],
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '우리들의 행복한 시간',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1!
                                      .copyWith(fontSize: 32),
                                ),
                                Text(
                                  '‘지금 이순간이 좋아’',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4!
                                      .copyWith(fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  '일상에 생기를 불어 넣어 주는 영화',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4!
                                      .copyWith(fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  options: CarouselOptions(
                    height: 450,
                    aspectRatio: 16 / 9,
                    viewportFraction: 1,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    enlargeCenterPage: false,
                    scrollDirection: Axis.horizontal,
                    clipBehavior: Clip.hardEdge,
                    onPageChanged:
                        (int index, CarouselPageChangedReason reason) {
                      setState(() {
                        activeIndex = index;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: AnimatedSmoothIndicator(
                    activeIndex: activeIndex,
                    count: 4,
                    effect: const SlideEffect(
                      activeDotColor: Colors.white,
                      dotHeight: 8,
                      dotWidth: 8,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Popular',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
                const SizedBox(height: 20),
                const PopularGrid(),
              ],
            ),
          ].reversed.toList(),
        ),
      ),
      drawer: const AppDrawer(),
    );
  }
}

class PopularGrid extends StatelessWidget {
  const PopularGrid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopularBloc, PopularState>(
      builder: (context, state) {
        if (state is PopularLoading) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
        if (state is PopularLoaded) {
          final content = state.popular;
          return GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            crossAxisSpacing: 10,
            childAspectRatio: (9 / 18),
            children: List.generate(
              content.length,
              (index) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () {
                      Navigator.pushNamed(context, MovieDetailScreen.routeName);
                    },
                    child: CachedNetworkImage(
                      imageUrl: content[index].imageMobileDomestic,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => const Center(
                        child: Icon(
                          Icons.error,
                          color: Colors.red,
                        ),
                      ),
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                      height: 150,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    content[index].titleKr,
                    style: Theme.of(context).textTheme.headline4,
                  )
                ],
              ),
            ).toList(),
          );
        } else {
          return Center(
            child: Text(
              'Something went wrong!!',
              style: Theme.of(context).textTheme.headline5,
            ),
          );
        }
      },
    );
  }
}
