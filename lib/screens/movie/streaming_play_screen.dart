import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    // _videoPlayerController = VideoPlayerController.network(
    //     'https://omn-video-input.s3.ap-northeast-2.amazonaws.com/10_2021/29/Video_60efd7629bfb7532d4a12646_1635491819.mp4');
    _videoPlayerController =
        VideoPlayerController.asset('assets/videos/sample-video.mp4');
    await _videoPlayerController.initialize();
    setState(() {});
    await setLandscape();
    setState(() {});
    _chewieController = ChewieController(
      allowFullScreen: true,
      videoPlayerController: _videoPlayerController,
      aspectRatio: _aspectRatio,
      autoPlay: true,
      showControls: true,
    );
    setState(() {});
  }

  Future setLandscape() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  Future setAllOrientations() async {}

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
