import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/features/auth/presentation/bloc/user_cubit.dart';
import 'package:test_app/features/auth/presentation/widgets/login_form.dart';

import '../../../../injection.dart';
import '../bloc/user_cubit.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocProvider<UserCubit>(
      create: (_) => sl<UserCubit>(),
      child: Scaffold(
        body: SafeArea(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              if (constraints.maxWidth > 500 && MediaQuery.of(context).orientation == Orientation.portrait) {
                return Padding(
                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.2, right: MediaQuery.of(context).size.width * 0.2),
                    child: const LoginForm()
                );
              }
              else if (constraints.maxWidth < 500 && MediaQuery.of(context).orientation == Orientation.portrait){
                return Padding(
                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1, right: MediaQuery.of(context).size.width * 0.1),
                    child: const LoginForm()
                );
              }
              else {
                return Padding(
                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.35, right: MediaQuery.of(context).size.width * 0.35),
                    child: const LoginForm()
                );
              }
            },
          ),
        ),
      )
    );
  }
}
