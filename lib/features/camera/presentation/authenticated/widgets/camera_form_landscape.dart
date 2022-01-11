import 'package:flutter/material.dart';
import 'package:test_app/core/default/colors.dart';
import 'package:test_app/core/default/text_style.dart';
import 'package:video_player/video_player.dart';

class CameraFormLandscape extends StatefulWidget {
  CameraFormLandscape({Key? key, required this.camera}) : super(key: key);

  VideoPlayerController camera;

  @override
  State<CameraFormLandscape> createState() => _CameraFormState();
}

class _CameraFormState extends State<CameraFormLandscape> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: appBarVideoPlayer,
          height: MediaQuery.of(context).size.height * 0.08,
          width: MediaQuery.of(context).size.width * 0.37,
          child: Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.02,
                right: MediaQuery.of(context).size.width * 0.02),
            child: Row(
              children: [
                const Text('Front camera', style: cameraTextStyle),
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
          height: MediaQuery.of(context).size.height * 0.37,
          width: MediaQuery.of(context).size.width * 0.37,
          child: widget.camera.value.isInitialized
              ? InkWell(
                  onTap: () => widget.camera.value.isPlaying
                      ? widget.camera.pause()
                      : widget.camera.play(),
                  child: AspectRatio(
                    aspectRatio: widget.camera.value.aspectRatio,
                    child: VideoPlayer(widget.camera),
                  ),
                )
              : const Center(child: CircularProgressIndicator()),
        )
      ],
    );
  }
}
