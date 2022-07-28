import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:terafty_flutter/models/screen_argument.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class StreamingPlay extends StatefulWidget {
  static const String routeName = '/play';

  static Route route(ScreenArguments url) {
    return MaterialPageRoute(
      builder: (context) => const StreamingPlay(),
      settings: RouteSettings(name: routeName, arguments: url),
    );
  }

  const StreamingPlay({
    Key? key,
  }) : super(key: key);

  @override
  State<StreamingPlay> createState() => _StreamingPlayState();
}

class _StreamingPlayState extends State<StreamingPlay> {
  late VideoPlayerController _videoPlayerController;
  late YoutubePlayerController _youtubeController;
  ChewieController? _chewieController;
  final double _aspectRatio = 16 / 9;
  bool _isPlayerReady = false;

  @override
  void initState() {
    super.initState();
  }

  Future<Widget> playVideoByUrl() async {
    // _videoPlayerController = VideoPlayerController.network(
    //     'https://omn-video-input.s3.ap-northeast-2.amazonaws.com/10_2021/29/Video_60efd7629bfb7532d4a12646_1635491819.mp4');
    _videoPlayerController =
        VideoPlayerController.asset('assets/videos/sample-video.mp4');
    _chewieController = ChewieController(
      allowFullScreen: true,
      videoPlayerController: _videoPlayerController,
      aspectRatio: _aspectRatio,
      autoPlay: true,
      autoInitialize: true,
      showControls: true,
    );
    return _chewieController != null
        ? SafeArea(child: Chewie(controller: _chewieController!))
        : const Center(
            child: CircularProgressIndicator.adaptive(),
          );
  }

  Future<Widget> playYoutube(String url) async {
    _youtubeController = YoutubePlayerController(
        initialVideoId: 'iLnmTe5Q2Qw',
        flags: const YoutubePlayerFlags(
          autoPlay: true,
          mute: true,
        ));
    return YoutubePlayerBuilder(
      onExitFullScreen: () {
        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      },
      player: YoutubePlayer(
        controller: _youtubeController,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.blueAccent,
        topActions: <Widget>[
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              _youtubeController.metadata.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
              size: 25.0,
            ),
            onPressed: () {
              debugPrint('Settings Tapped!');
            },
          ),
        ],
        onReady: () {
          _isPlayerReady = true;
        },
      ), builder: (BuildContext , Widget ) {  },
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController!.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    return Scaffold(
      appBar: AppBar(),
      body: _chewieController != null
          ? SafeArea(child: Chewie(controller: _chewieController!))
          : const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
    );
  }
}
