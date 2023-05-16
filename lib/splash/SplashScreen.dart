import 'package:cryptomarket/constance/constance.dart';
import 'package:cryptomarket/constance/routes.dart';
import 'package:cryptomarket/constance/themes.dart';
import 'package:cryptomarket/utils/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cryptomarket/constance/global.dart' as globals;
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  bool isShowIndicator = false;
  @override
  void initState() {
    super.initState();
    _loadNextScreen();
    animationController =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = Tween<double>(begin: 0, end: 150).animate(animationController)
      ..addListener(() {
        setState(() {});
      });
    animationController.forward();

    animation.addStatusListener((AnimationStatus status) async {
      if (status == AnimationStatus.completed) {
        isShowIndicator = true;
      }
    });
  }

  _loadNextScreen() async {
    await Future.delayed(const Duration(seconds: 6));
    dynamic user = await getUserData();

    print(globals.isSignedIn);
    user != null
        ? Navigator.pushReplacementNamed(context, Routes.Home)
        : Navigator.pushReplacementNamed(context, Routes.Auth);
  }

  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          foregroundDecoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                HexColor(globals.primaryColorString).withOpacity(0.6),
                HexColor(globals.primaryColorString).withOpacity(0.6),
                HexColor(globals.primaryColorString).withOpacity(0.6),
                HexColor(globals.primaryColorString).withOpacity(0.6),
              ],
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: animation.value * 3,
                  height: animation.value * 3,
                  child: Lottie.asset(ConstanceData.splash),
                ),
                SizedBox(
                  height: 150,
                ),
                SizedBox(
                  height: 16,
                  child: isShowIndicator
                      ? CupertinoActivityIndicator(
                          radius: 12,
                        )
                      : SizedBox(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
