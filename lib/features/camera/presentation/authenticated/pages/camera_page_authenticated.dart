import 'dart:async';

import 'package:flutter/material.dart';
import 'package:test_app/core/default/colors.dart';
import 'package:test_app/core/default/text_style.dart';
import 'package:test_app/features/auth/domain/entities/user.dart';
import 'package:test_app/features/auth/presentation/bloc/user_cubit.dart';
import 'package:test_app/features/auth/presentation/pages/login_page.dart';
import 'package:test_app/features/camera/presentation/authenticated/widgets/camera_form_landscape.dart';
import 'package:test_app/features/camera/presentation/authenticated/widgets/camera_form_portrait.dart';
import 'package:test_app/features/filters/presentation/bloc/filter_cublit.dart';
import 'package:test_app/features/filters/presentation/widgets/filters_component.dart';
import 'package:video_player/video_player.dart';

import '../../../../../injection.dart';

class CameraPageAuthenticated extends StatefulWidget {
  const CameraPageAuthenticated({Key? key}) : super(key: key);

  @override
  State<CameraPageAuthenticated> createState() =>
      _CameraPageAuthenticatedState();
}

class _CameraPageAuthenticatedState extends State<CameraPageAuthenticated> {
  String dropdownValue = 'No filter';
  var userName = sl<UserCubit>().check();
  var data = sl<FilterCubit>().getLastUpdateTime();
  Timer? timer;

  late VideoPlayerController _cameraFront;
  late VideoPlayerController _cameraBack;

  @override
  void initState() {
    _cameraFront = VideoPlayerController.network(
        'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true))
      ..initialize().then((_) {
        setState(() {});
      });
    _cameraFront.play();

    _cameraBack = VideoPlayerController.network(
        'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true))
      ..initialize().then((_) {
        setState(() {});
      });
    _cameraBack.play();
    timer = Timer.periodic(Duration(seconds: 12), (Timer t) => updateTime());
    super.initState();
  }

  void updateTime() {
    setState(() {
      data = sl<FilterCubit>().getLastUpdateTime();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Theme(
          data: Theme.of(context)
              .copyWith(canvasColor: videoPlayerBackground.withOpacity(0.7)),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.2,
            child: DropdownButton<String>(
              alignment: Alignment.center,
              underline: SizedBox.shrink(),
              value: dropdownValue,
              elevation: 16,
              style: const TextStyle(color: Colors.black),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              items: <String>['No filter', 'Available', 'Hidden', 'Disabled']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  alignment: Alignment.center,
                  value: value,
                  child: Container(
                      child: Text(
                    value,
                    style: dropTextStyle,
                  )),
                );
              }).toList(),
            ),
          ),
        ),
        backgroundColor: appBarColor,
        bottomOpacity: 0.0,
        elevation: 0.0,
        actions: [
          Container(
            width: MediaQuery.of(context).size.width * 0.2,
            color: Colors.blue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FutureBuilder<User>(
                    future: userName,
                    builder:
                        (BuildContext context, AsyncSnapshot<User> snapshot) {
                      if (snapshot.hasData) {
                        return Text('Hello, ' + snapshot.data!.login!);
                      } else if (snapshot.hasError) {
                        return const Icon(Icons.error_outline);
                      } else {
                        return const CircularProgressIndicator();
                      }
                    }),
                Flexible(
                  child: InkWell(
                    onTap: () => {
                      sl<UserCubit>().logOut(),
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                      ),
                    },
                    child: const Text(
                      'Log out',
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if (MediaQuery.of(context).orientation == Orientation.landscape) {
              return Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width * 0.22,
                        child: FilterComponent(
                          filterName: dropdownValue,
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: CameraFormLandscape(camera: _cameraFront),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: CameraFormLandscape(camera: _cameraBack),
                          ),
                        ],
                      )
                    ],
                  ),
                  Positioned(
                      right: 10,
                      bottom: 5,
                      child:
                          Text('Data from API updated at ' + data.toString()))
                ],
              );
            } else {
              return Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width * 0.22,
                        child: FilterComponent(
                          filterName: dropdownValue,
                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: CameraFormPortrait(camera: _cameraFront),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: CameraFormPortrait(camera: _cameraBack),
                          ),
                        ],
                      )
                    ],
                  ),
                  Positioned(
                      right: 10,
                      bottom: 5,
                      child: Text('Data from API updated at ' +
                          data.toString()))
                ],
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _cameraBack.dispose();
    _cameraFront.dispose();
    super.dispose();
  }
}
