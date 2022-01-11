import 'package:flutter/material.dart';
import 'package:test_app/core/default/colors.dart';
import 'package:test_app/core/default/text_style.dart';
import 'package:test_app/features/auth/presentation/bloc/user_cubit.dart';
import 'package:test_app/features/camera/presentation/authenticated/pages/camera_page_authenticated.dart';
import 'package:test_app/features/camera/presentation/guest/pages/camera_page.dart';

import '../../../../injection.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final loginController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 40),
              child: Text(
                'WELCOME!',
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: authBlueColor),
              ),
            ),
            TextField(
              controller: loginController,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.home,
                  color: authBlueColor,
                  size: 30,
                ),
                hintText: 'Username',
                hintStyle: textFieldHintStyle,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: authBlueColor),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: authBlueColor),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.print,
                  color: authBlueColor,
                  size: 30,
                ),
                hintText: 'Password',
                hintStyle: textFieldHintStyle,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: authBlueColor),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: authBlueColor),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: authBlueColor, // background
                  onPrimary: Colors.white, // foreground
                ),
                onPressed: () {

                  if(loginController.text.isNotEmpty && passwordController.text.isNotEmpty) {
                    sl<UserCubit>()
                        .addUser(loginController.text, passwordController.text);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CameraPageAuthenticated()),
                    );
                  }
                  else{
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Fields empty!'),
                    ));
                  }
                },
                child: const Text('SIGN IN'),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(5.0),
              child: SizedBox(
                child: Text('or',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: authBlueColor)),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: videoPlayerBackground, // background
                  onPrimary: Colors.white, // foreground
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CameraPage()),
                  );
                },
                child: const Text('LIVE VIDEO'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
