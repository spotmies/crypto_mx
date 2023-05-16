import 'dart:convert';
import 'package:cryptomarket/constance/routes.dart';
import 'package:cryptomarket/repo/api_methods.dart';
import 'package:cryptomarket/repo/api_urls.dart';
import 'package:cryptomarket/utils/shared_preferences.dart';
import 'package:flutter/material.dart';

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
        title: Text("SignIn"),
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
                          value!.isEmpty ? 'Email cannot be blank' : null,
                      decoration: InputDecoration(hintText: "Email")),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                      controller: password,
                      obscureText: true,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) =>
                          value!.isEmpty ? 'Password cannot be blank' : null,
                      decoration: InputDecoration(hintText: "Password")),
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

                          if (user["response"] == "success") {
                            await setUserData(user);
                            Navigator.pushNamedAndRemoveUntil(
                                    context, Routes.Home, (route) => false)
                                .then((onValue) {});
                          } else {
                            final snackBar = SnackBar(
                              content: const Text('Invalid Creditials'),
                              action: SnackBarAction(
                                label: 'Close',
                                onPressed: () {
                                  // Some code to undo the change.
                                },
                              ),
                            );

                            // Find the ScaffoldMessenger in the widget tree
                            // and use it to show a SnackBar.
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
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