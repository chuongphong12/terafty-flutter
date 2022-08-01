import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:terafty_flutter/bloc/episode/episode_bloc.dart';
import 'package:terafty_flutter/bloc/streaming/streaming_bloc.dart';
import 'package:terafty_flutter/extensions/hexadecimal_convert.dart';
import 'package:terafty_flutter/models/episode_model.dart';
import 'package:terafty_flutter/models/screen_argument.dart';
import 'package:terafty_flutter/models/stream_detail_model.dart';
import 'package:terafty_flutter/repository/streaming_repository.dart';
import 'package:terafty_flutter/screens/movie/streaming_play_screen.dart';

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
  int selectedEpisode = 0;
  String streamingLink = '';
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

  void playSelectedEpisode(int episode, String link) {
    setState(() {
      selectedEpisode = episode;
      streamingLink = link;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenPadding = MediaQuery.of(context).padding.top;
    final size = MediaQuery.of(context).size;
    final StreamingRepository streamRepo = context.read<StreamingRepository>();

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
                    BlocBuilder<StreamingBloc, StreamingState>(
                      builder: (context, state) {
                        if (state is StreamingLoading) {
                          return const Center(
                            child: CircularProgressIndicator.adaptive(),
                          );
                        }
                        if (state is StreamingLoaded) {
                          final data = state.streaming;
                          return CachedNetworkImage(
                            imageUrl: data.representativeImageMobileOversea,
                            imageBuilder: (context, imageProvider) => Container(
                              constraints: BoxConstraints.expand(
                                  width: double.maxFinite,
                                  height: size.height * 0.35),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator.adaptive(),
                            ),
                          );
                        } else {
                          return const Center(
                            child: Text('Error'),
                          );
                        }
                      },
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
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  selectedEpisode = 0;
                                });
                              },
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
                                    Tab(text: '회차'),
                                    Tab(text: '회차'),
                                    Tab(text: '회차')
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Builder(builder: (_) {
                              if (selectedTab == 0) {
                                return Tab1(
                                  size: size,
                                  streamID: streaming.id,
                                  streamingRepository: streamRepo,
                                  selectedEpisode: selectedEpisode,
                                ); //1st custom tabBarView
                              } else if (selectedTab == 1) {
                                return Tab2(
                                  size: size,
                                  streamingRepository: streamRepo,
                                  streamingID: streaming.id,
                                  seasonID:
                                      BlocProvider.of<StreamingBloc>(context)
                                          .seasonID,
                                ); //2nd tabView
                              } else {
                                return Tab3(
                                  size: size,
                                  streamingRepository: streamRepo,
                                  streamingId: streaming.id,
                                  seasonId:
                                      BlocProvider.of<StreamingBloc>(context)
                                          .seasonID,
                                ); //3rd tabView
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

class Tab3 extends StatefulWidget {
  final Size size;
  final StreamingRepository streamingRepository;
  final String seasonId;
  final String streamingId;
  const Tab3({
    required this.size,
    Key? key,
    required this.streamingRepository,
    required this.seasonId,
    required this.streamingId,
  }) : super(key: key);

  @override
  State<Tab3> createState() => _Tab3State();
}

class _Tab3State extends State<Tab3> {
  String initialEpisode = '에피소드 1';
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FutureBuilder(
          future: widget.streamingRepository.getListEpisodeByStreamIDAndSeason(
            streamID: widget.streamingId,
            seasonID: widget.seasonId,
          ),
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            if (snapshot.hasData) {
              final List? episode = snapshot.data;
              return DropdownButtonFormField(
                icon: const Icon(Icons.arrow_drop_down_circle_outlined),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Color(0xFFBDC5CB),
                    ),
                  ),
                  constraints: BoxConstraints.tightFor(
                      height: widget.size.height * 0.06),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  filled: false,
                ),
                selectedItemBuilder: (BuildContext context) {
                  return episode!.map((dynamic value) {
                    return Text(
                      value['episodesTemplateID']['name_kr'],
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                            fontWeight: FontWeight.normal,
                          ),
                    );
                  }).toList();
                },
                isExpanded: true,
                value: initialEpisode,
                borderRadius: BorderRadius.circular(15),
                items: episode!.map((dynamic value) {
                  return DropdownMenuItem<dynamic>(
                    value: value['episodesTemplateID']['name_kr'],
                    child: Text(
                      value['episodesTemplateID']['name_kr'],
                    ),
                  );
                }).toList(),
                onChanged: (dynamic newValue) {
                  setState(() {
                    initialEpisode = newValue;
                  });
                },
              );
            } else {
              return Container();
            }
          },
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: BoxConstraints.tightFor(width: widget.size.width * 0.8),
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
  final StreamingRepository streamingRepository;
  final String seasonID;
  final String streamingID;
  const Tab2({
    required this.size,
    required this.streamingRepository,
    required this.seasonID,
    required this.streamingID,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: streamingRepository.getDetailBySeason(
        seasonId: seasonID,
        streamingId: streamingID,
      ),
      builder: (context, AsyncSnapshot<StreamDetail> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
        if (snapshot.hasData) {
          final detail = snapshot.data;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '등장인물',
                style: Theme.of(context).textTheme.headline2,
              ),
              const SizedBox(height: 8),
              ActorHorizontalList(participants: detail!.programParticipants),
              const SizedBox(height: 48),
              Text(
                '줄거리',
                style: Theme.of(context).textTheme.headline2,
              ),
              const SizedBox(height: 8),
              Text(
                detail.storyKr,
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
                  detail.productInformation.length,
                  (index) => Row(
                    children: [
                      Text(
                        detail.productInformation[index].nameKr,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        detail.productInformation[index].dataKr,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.2)
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}

class ActorHorizontalList extends StatelessWidget {
  final List<ProgramParticipant> participants;
  const ActorHorizontalList({
    required this.participants,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: participants.length,
        itemBuilder: (context, index) => Container(
          margin: const EdgeInsets.only(right: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 100,
                width: 100,
                child: CachedNetworkImage(
                  imageUrl: participants[index].avatar,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                  errorWidget: (context, url, error) => Center(
                    child: Image.asset(
                      'assets/images/Terafty_Logo.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                participants[index].dataNameActorKr,
                style: Theme.of(context).textTheme.headline6,
              ),
              Text(participants[index].dataNameCharacterKr),
            ],
          ),
        ),
      ),
    );
  }
}

class Tab1 extends StatefulWidget {
  const Tab1({
    Key? key,
    required this.streamID,
    required this.size,
    required this.streamingRepository,
    this.selectedEpisode,
  }) : super(key: key);

  final Size size;
  final String streamID;
  final StreamingRepository streamingRepository;
  final int? selectedEpisode;

  @override
  State<Tab1> createState() => _Tab1State();
}

class _Tab1State extends State<Tab1> {
  late String _mySelection;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder(
          future: widget.streamingRepository
              .getAllSeasonByStreamID(widget.streamID),
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            if (snapshot.hasData) {
              final List<dynamic> listSeason = snapshot.data!;
              _mySelection = listSeason[0]['_id'];
              BlocProvider.of<EpisodeBloc>(context).add(
                LoadEpisodeBySeasonID(
                    seasonID: _mySelection, streamID: widget.streamID),
              );
              BlocProvider.of<StreamingBloc>(context).add(
                UpdateSeasonID(seasonID: _mySelection),
              );
              return DropdownButtonFormField(
                icon: const Icon(Icons.arrow_drop_down_circle_outlined),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Color(0xFFBDC5CB),
                    ),
                  ),
                  constraints: BoxConstraints.tightFor(
                      height: widget.size.height * 0.06),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  filled: false,
                ),
                selectedItemBuilder: (BuildContext context) {
                  return listSeason.map((dynamic value) {
                    return Text(
                      value['seasonTemplateID']['name_kr'],
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                            fontWeight: FontWeight.normal,
                          ),
                    );
                  }).toList();
                },
                isExpanded: true,
                value: _mySelection,
                borderRadius: BorderRadius.circular(15),
                items: listSeason.map((dynamic value) {
                  return DropdownMenuItem<String>(
                    value: value['_id'],
                    child: Text(value['seasonTemplateID']['name_kr']),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      BlocProvider.of<EpisodeBloc>(context).add(
                        LoadEpisodeBySeasonID(
                            seasonID: newValue, streamID: widget.streamID),
                      );
                      BlocProvider.of<StreamingBloc>(context).add(
                        UpdateSeasonID(seasonID: newValue),
                      );
                      _mySelection = newValue;
                    });
                  }
                },
              );
            } else {
              return DropdownButtonFormField(
                icon: const Icon(Icons.arrow_drop_down_circle_outlined),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Color(0xFFBDC5CB),
                    ),
                  ),
                  constraints: BoxConstraints.tightFor(
                      height: widget.size.height * 0.06),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  filled: false,
                ),
                isExpanded: true,
                value: 'none',
                borderRadius: BorderRadius.circular(15),
                items: <String>['none'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: null,
              );
            }
          },
        ),
        const SizedBox(height: 10),
        EpisodeList(selectedEp: widget.selectedEpisode),
        const SizedBox(height: 30),
      ],
    );
  }
}

class EpisodeList extends StatelessWidget {
  const EpisodeList({
    this.selectedEp,
    Key? key,
  }) : super(key: key);

  final int? selectedEp;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EpisodeBloc, EpisodeState>(
      builder: (context, state) {
        if (state is EpisodeLoading) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
        if (state is EpisodeLoaded) {
          final List<Episode> episodes = state.episodes;
          return ListView.builder(
            shrinkWrap: true,
            itemCount: episodes.length,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) => Container(
              width: double.maxFinite,
              margin: const EdgeInsets.only(bottom: 24),
              child: InkWell(
                borderRadius: BorderRadius.circular(4),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    StreamingPlay.routeName,
                    arguments: ScreenArguments('link', episodes[index].url),
                  );
                },
                child: Row(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        CachedNetworkImage(
                          imageUrl:
                              episodes[index].thumbnailImageOverseaEpisodes,
                          placeholder: (context, url) => const SizedBox(
                            height: 84,
                            width: 144,
                            child: Center(
                              child: CircularProgressIndicator.adaptive(),
                            ),
                          ),
                          errorWidget: (context, url, error) => const Center(
                            child: Icon(
                              Icons.error,
                              color: Colors.red,
                            ),
                          ),
                          imageBuilder: (context, imageProvider) => Container(
                            height: 84,
                            width: 144,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
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
                            '${episodes[index].number}화',
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          const Text('00:05:30:00'),
                          const SizedBox(height: 10),
                          Text(
                            episodes[index].storyEpisodeEng,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
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
            ),
          );
        } else {
          return const Center(
            child: Text('Something went wrong!!'),
          );
        }
      },
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
    return InkResponse(
      onTap: () {},
      child: Column(
        children: [
          SvgPicture.asset(
            assets,
          ),
          Text(text),
        ],
      ),
    );
  }
}
