import 'package:animator/animator.dart';
import 'package:cryptomarket/auth/forgotPasswordScreen.dart';
import 'package:cryptomarket/constance/constance.dart';
import 'package:cryptomarket/constance/routes.dart';
import 'package:cryptomarket/constance/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cryptomarket/constance/global.dart' as globals;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import '../modules/home/homeScreen.dart';
import 'signUpScreen.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Authenticator(
        initialStep: AuthenticatorStep.signIn,
      child: MaterialApp(
        darkTheme: customDarkTheme,
        themeMode:ThemeMode.dark ,
        builder: Authenticator.builder(),
        home: HomeScreen()
      )
    );


}
  ThemeData customDarkTheme = ThemeData(
    colorScheme: ColorScheme.fromSwatch(
      brightness: Brightness.dark,
      primarySwatch: Colors.indigo,
    ),
    indicatorColor: Colors.indigo,
    textTheme: const TextTheme(
      headline6: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 24,
        color: Colors.white,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(16),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.grey[700],
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(16)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    ),
  );

}

// Navigator.of(context, rootNavigator: true)
// .push(
// CupertinoPageRoute<void>(
// builder: (BuildContext context) => ForgotPasswordScreen(),
// ),
// )
// .then((onValue) {
// setState(() {
// _isClickonForgotPassword = false;
// });
// })