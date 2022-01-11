import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app/core/default/colors.dart';
import 'package:test_app/core/default/text_style.dart';
import 'package:video_player/video_player.dart';

class CameraFormLandscape extends StatefulWidget {
  const CameraFormLandscape({Key? key}) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraFormLandscape> {
  late VideoPlayerController _cameraFront;
  late VideoPlayerController _backFront;

  @override
  void initState() {
    _cameraFront = VideoPlayerController.network(
        'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4', videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true))
      ..initialize().then((_) {
        setState(() {});
      });
    _cameraFront.play();

    _backFront = VideoPlayerController.network(
        'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4', videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true))
      ..initialize().then((_) {
        setState(() {});
      });
    _backFront.play();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        bottomOpacity: 0.0,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.02,
              right: MediaQuery.of(context).size.width * 0.02),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    color: appBarVideoPlayer,
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.02,
                          right: MediaQuery.of(context).size.width * 0.02),
                      child: Row(
                        children: [
                          const Text('Front filters', style: cameraTextStyle),
                          const Spacer(),
                          const Icon(
                            Icons.mic_none,
                            color: Colors.white,
                            size: 30,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.01,
                          ),
                          const Icon(
                            Icons.fullscreen_exit,
                            color: Colors.white,
                            size: 35,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    color: videoPlayerBackground,
                    height: MediaQuery.of(context).size.height * 0.45,
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: _cameraFront.value.isInitialized
                        ? InkWell(
                            onTap: () => _cameraFront.value.isPlaying
                                ? _cameraFront.pause()
                                : _cameraFront.play(),
                            child: AspectRatio(
                              aspectRatio: _cameraFront.value.aspectRatio,
                              child: VideoPlayer(_cameraFront),
                            ),
                          )
                        : const Center(child: CircularProgressIndicator()),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    color: appBarVideoPlayer,
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.02,
                          right: MediaQuery.of(context).size.width * 0.02),
                      child: Row(
                        children: [
                          const Text('Back filters', style: cameraTextStyle),
                          const Spacer(),
                          const Icon(
                            Icons.mic_none,
                            color: Colors.white,
                            size: 30,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.01,
                          ),
                          const Icon(
                            Icons.fullscreen_exit,
                            color: Colors.white,
                            size: 35,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    color: videoPlayerBackground,
                    height: MediaQuery.of(context).size.height * 0.45,
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: _backFront.value.isInitialized
                        ? InkWell(
                            onTap: () => _backFront.value.isPlaying
                                ? _backFront.pause()
                                : _backFront.play(),
                            child: AspectRatio(
                              aspectRatio: _backFront.value.aspectRatio,
                              child: VideoPlayer(_backFront),
                            ),
                          )
                        : const Center(child: CircularProgressIndicator()),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _backFront.dispose();
    _cameraFront.dispose();
    super.dispose();
  }
}
