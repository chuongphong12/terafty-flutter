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
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    debugPrint(args.message);
    return Scaffold(
      appBar: AppBar(),
      body: args.message.contains('youtube')
          ? YoutubeVideoPlayer(youtubeId: args.message)
          : NetworkVideoPlayer(videoUrl: args.message),
    );
  }
}

class NetworkVideoPlayer extends StatefulWidget {
  final String videoUrl;
  const NetworkVideoPlayer({
    Key? key,
    required this.videoUrl,
  }) : super(key: key);

  @override
  State<NetworkVideoPlayer> createState() => _NetworkVideoPlayerState();
}

class _NetworkVideoPlayerState extends State<NetworkVideoPlayer> {
  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;

  double aspectRatio = 16 / 9;
  Future playVideoByUrl() async {
    if (widget.videoUrl.contains('http')) {
      videoPlayerController = VideoPlayerController.network(widget.videoUrl);
    } else {
      videoPlayerController =
          VideoPlayerController.asset('assets/videos/sample-video.mp4');
    }

    chewieController = ChewieController(
      allowFullScreen: true,
      videoPlayerController: videoPlayerController,
      aspectRatio: aspectRatio,
      autoPlay: true,
      autoInitialize: true,
      showControls: true,
    );
  }

  @override
  void initState() {
    playVideoByUrl();
    super.initState();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return chewieController != null
        ? SafeArea(child: Chewie(controller: chewieController!))
        : const Center(
            child: CircularProgressIndicator.adaptive(),
          );
  }
}

class YoutubeVideoPlayer extends StatefulWidget {
  final String youtubeId;
  const YoutubeVideoPlayer({
    Key? key,
    required this.youtubeId,
  }) : super(key: key);

  @override
  State<YoutubeVideoPlayer> createState() => _YoutubeVideoPlayerState();
}

class _YoutubeVideoPlayerState extends State<YoutubeVideoPlayer> {
  late YoutubePlayerController youtubeController;
  late TextEditingController idController;
  late TextEditingController seekToController;

  late PlayerState playerState;
  late YoutubeMetaData videoMetaData;
  double volume = 100;
  bool muted = false;
  bool isPlayerReady = false;

  @override
  void initState() {
    playYoutube();
    super.initState();
  }

  String get id {
    var videoId = widget.youtubeId.split('v=')[1];
    var ampersandPosition = videoId.indexOf('&');
    if (ampersandPosition != -1) {
      videoId = videoId.substring(0, ampersandPosition);
    }
    return videoId;
  }

  Future playYoutube() async {
    youtubeController = YoutubePlayerController(
      initialVideoId: id,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    )..addListener(listener);
    idController = TextEditingController();
    seekToController = TextEditingController();
    videoMetaData = const YoutubeMetaData();
    playerState = PlayerState.unknown;
  }

  void listener() {
    if (isPlayerReady && mounted && !youtubeController.value.isFullScreen) {
      setState(() {
        playerState = youtubeController.value.playerState;
        videoMetaData = youtubeController.metadata;
      });
    }
  }

  Widget _text(String title, String value) {
    return RichText(
      text: TextSpan(
        text: '$title : ',
        style: Theme.of(context).textTheme.headline5,
        children: [
          TextSpan(
            text: value,
            style: Theme.of(context).textTheme.headline6,
          ),
        ],
      ),
    );
  }

  Color _getStateColor(PlayerState state) {
    switch (state) {
      case PlayerState.unknown:
        return Colors.grey[700]!;
      case PlayerState.unStarted:
        return Colors.pink;
      case PlayerState.ended:
        return Colors.red;
      case PlayerState.playing:
        return Colors.blueAccent;
      case PlayerState.paused:
        return Colors.orange;
      case PlayerState.buffering:
        return Colors.yellow;
      case PlayerState.cued:
        return Colors.blue[900]!;
      default:
        return Colors.blue;
    }
  }

  Widget get _space => const SizedBox(height: 10);

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 16.0,
          ),
        ),
        backgroundColor: Colors.blueAccent,
        behavior: SnackBarBehavior.floating,
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
    );
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    youtubeController.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    youtubeController.dispose();
    idController.dispose();
    seekToController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return youtubeController != null
        ? YoutubePlayerBuilder(
            onExitFullScreen: () {
              SystemChrome.setPreferredOrientations(DeviceOrientation.values);
            },
            player: YoutubePlayer(
              controller: youtubeController,
              showVideoProgressIndicator: false,
              progressIndicatorColor: Colors.blueAccent,
              topActions: <Widget>[
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    youtubeController.metadata.title,
                    style: Theme.of(context).textTheme.headline5,
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
                isPlayerReady = true;
              },
            ),
            builder: (context, player) => ListView(
              children: [
                player,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _space,
                      _text('Title', videoMetaData.title),
                      _space,
                      _text('Channel', videoMetaData.author),
                      _space,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            icon: Icon(
                              youtubeController.value.isPlaying
                                  ? Icons.pause
                                  : Icons.play_arrow,
                            ),
                            onPressed: isPlayerReady
                                ? () {
                                    youtubeController.value.isPlaying
                                        ? youtubeController.pause()
                                        : youtubeController.play();
                                    setState(() {});
                                  }
                                : null,
                          ),
                          IconButton(
                            icon: Icon(
                                muted ? Icons.volume_off : Icons.volume_up),
                            onPressed: isPlayerReady
                                ? () {
                                    muted
                                        ? youtubeController.unMute()
                                        : youtubeController.mute();
                                    setState(() {
                                      muted = !muted;
                                    });
                                  }
                                : null,
                          ),
                          FullScreenButton(
                            controller: youtubeController,
                            color: Colors.blueAccent,
                          ),
                        ],
                      ),
                      _space,
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 800),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: _getStateColor(playerState),
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          playerState.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        : const Center(
            child: CircularProgressIndicator.adaptive(),
          );
  }
}
