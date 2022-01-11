import 'package:flutter/material.dart';
import 'package:test_app/features/camera/presentation/guest/widgets/camera_form_landscape.dart';
import 'package:test_app/features/camera/presentation/guest/widgets/camera_form_portrait.dart';

class CameraPage extends StatelessWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if (MediaQuery.of(context).orientation == Orientation.landscape) {
              return const CameraFormLandscape();
            }
            else {
              return const CameraFormPortrait();
            }
          },
        ),
      ),
    );
  }
}
