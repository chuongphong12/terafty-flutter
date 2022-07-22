import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class StreamingPlay extends StatefulWidget {
  static const String routeName = '/play';

  static Route route() {
    return MaterialPageRoute(
      builder: (context) => const StreamingPlay(),
      settings: const RouteSettings(name: routeName),
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
  ChewieController? _chewieController;
  final double _aspectRatio = 16 / 9;

  @override
  void initState() {
    playVideoByUrl();
    super.initState();
  }

  void playVideoByUrl() async {
    _videoPlayerController = VideoPlayerController.network(
        'https://omn-video-input.s3.ap-northeast-2.amazonaws.com/10_2021/29/Video_60efd7629bfb7532d4a12646_1635491819.mp4');
    _chewieController = ChewieController(
      allowedScreenSleep: false,
      allowFullScreen: true,
      videoPlayerController: _videoPlayerController,
      aspectRatio: _aspectRatio,
      autoInitialize: true,
      autoPlay: true,
      showControls: true,
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
