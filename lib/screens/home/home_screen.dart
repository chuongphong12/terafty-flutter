import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:terafty_flutter/bloc/popular/popular_bloc.dart';
import 'package:terafty_flutter/bloc/streaming/streaming_bloc.dart';
import 'package:terafty_flutter/models/popular_content_model.dart';
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
  late int banners;

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
                  Image.asset(
                    'assets/images/Terafty_Logo.png',
                    width: 150,
                    fit: BoxFit.contain,
                  ),
                  const Expanded(
                    child: SizedBox(),
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
            BlocBuilder<PopularBloc, PopularState>(
              builder: (context, state) {
                if (state is PopularLoading) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }
                if (state is PopularLoaded) {
                  final content = state.popular;
                  final banners = state.banners;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CarouselSlider(
                        items: List.generate(
                          banners.length,
                          (index) => Stack(
                            children: [
                              Container(
                                constraints: const BoxConstraints.expand(),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                      banners[index]['image'],
                                      errorListener: () => const Center(
                                        child: Icon(
                                          Icons.error,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
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
                                      1,
                                    ],
                                    colors: [
                                      Color(0xFF131A20),
                                      Colors.transparent,
                                      Color(0xFF131A20),
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
                      Center(
                        child: AnimatedSmoothIndicator(
                          activeIndex: activeIndex,
                          count: banners.length,
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
                      PopularGrid(
                        content: content,
                      ),
                    ],
                  );
                } else {
                  return const Center(
                    child: Text('error!!!'),
                  );
                }
              },
            ),
          ].reversed.toList(),
        ),
      ),
      drawer: const AppDrawer(),
    );
  }
}

class PopularGrid extends StatelessWidget {
  final List<Doc> content;
  const PopularGrid({
    required this.content,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      crossAxisSpacing: 12,
      childAspectRatio: (9 / 17),
      children: List.generate(
        content.length,
        (index) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () {
                BlocProvider.of<StreamingBloc>(context).add(
                  LoadSteamingDetail(
                      id: content[index].streamingId ??
                          content[index].crowdfundingId!.id),
                );
                Navigator.pushNamed(context, MovieDetailScreen.routeName);
              },
              child: CachedNetworkImage(
                imageUrl: content[index].imageMobileOversea,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => AspectRatio(
                  aspectRatio: 9 / 12.4,
                  child: Center(
                    child: Image.asset(
                      'assets/images/Terafty_Logo.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.fitHeight,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 150,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              content[index].titleEng,
              style: Theme.of(context).textTheme.headline4,
              softWrap: false,
              overflow: TextOverflow.fade,
            )
          ],
        ),
      ).toList(),
    );
  }
}
