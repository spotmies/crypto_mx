import 'dart:convert';
import 'dart:developer';

import 'package:animator/animator.dart';
import 'package:cryptomarket/auth/forgotPasswordScreen.dart';
import 'package:cryptomarket/constance/constance.dart';
import 'package:cryptomarket/constance/routes.dart';
import 'package:cryptomarket/constance/themes.dart';
import 'package:cryptomarket/repo/api_methods.dart';
import 'package:cryptomarket/repo/api_urls.dart';
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

final loginFormKey = new GlobalKey<FormState>();
TextEditingController password = TextEditingController();
TextEditingController email = TextEditingController();

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SignUp"),
      ),
      body: Form(
          key: loginFormKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                      controller: email,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) =>
                          value!.isEmpty ? 'name cannot be blank' : null,
                      decoration: InputDecoration(hintText: "Name")),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                      controller: password,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) =>
                          value!.isEmpty ? 'Email cannot be blank' : null,
                      decoration: InputDecoration(hintText: "Email")),
                ),
                SizedBox(
                  height: 100,
                ),
                ElevatedButton.icon(
                    onPressed: () async {
                      var prm = {
                        "member_id": email.text.toString(),
                        "password": password.text.toString(),
                        "api_secret": "oApF8z0hmu",
                      };

                      if (loginFormKey.currentState!.validate()) {
                        dynamic response =
                            await Server().postMethodParems(API.userLogin, prm);
                        if (response.statusCode == 200) {
                          dynamic user = jsonDecode(response.body);
                          log(user["response"].toString());
                          if (user["response"] == "success") {
                            Navigator.pushNamedAndRemoveUntil(
                                    context, Routes.Home, (route) => false)
                                .then((onValue) {});
                          }
                        }
                      }
                    },
                    icon: Icon(Icons.arrow_forward),
                    label: Text("Submit"))
              ],
            ),
          )),
    );
    // return Authenticator(
    //     initialStep: AuthenticatorStep.signIn,
    //   child: MaterialApp(
    //     darkTheme: customDarkTheme,
    //     themeMode:ThemeMode.dark ,
    //     builder: Authenticator.builder(),
    //     home: HomeScreen()
    //   )
    // );
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
        padding:
            MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(16)),
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