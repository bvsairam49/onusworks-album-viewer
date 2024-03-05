import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onusworks_albums_app/core/app_color.dart';
import 'package:onusworks_albums_app/router/app_router.gr.dart';

import 'package:onusworks_albums_app/src/splash_screen/cubit/splash_cubit.dart';
import 'package:onusworks_albums_app/src/splash_screen/state/splash_state.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<SplashCubit>(context).isLoggedIn();
    BlocProvider.of<SplashCubit>(context).isOnboarded();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBackgroundColor,
      body: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashLoggedInLoaded && state.isLoggedIn) {
            context.router.replace(const HomeRoute());
          } else if (state is SplashOnboardedLoaded && state.isOnboarded) {
            context.router.replace(const LoginRoute());
          } else {
            context.router.replace(const OnboardRoute());
          }
        },
        child: Center(
          child: CircularProgressIndicator(
            color: AppColor.appBarColor,
          ),
        ),
      ),
    );
  }
}
