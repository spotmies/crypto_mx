import 'dart:convert';
import 'dart:developer';

import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:animator/animator.dart';
import 'package:cryptomarket/auth/signInScreen.dart';
import 'package:cryptomarket/constance/constance.dart';
import 'package:cryptomarket/constance/routes.dart';
import 'package:cryptomarket/constance/themes.dart';
import 'package:cryptomarket/repo/api_methods.dart';
import 'package:cryptomarket/repo/api_urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cryptomarket/constance/global.dart' as globals;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../modules/home/homeScreen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isInProgress = false;
  bool _isClickonSignIn = false;
  bool _visible = false;

  animation() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _visible = true;
    });
  }

  @override
  void initState() {
    super.initState();
    animation();
  }

  final _formKey = new GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController num = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SignUp"),
      ),
      body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                      controller: name,
                      keyboardType: TextInputType.name,
                      validator: (value) =>
                          value!.isEmpty ? 'name cannot be blank' : null,
                      decoration: InputDecoration(hintText: "Name")),
                ),
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
                      controller: num,
                      keyboardType: TextInputType.number,
                      validator: (value) => value!.isEmpty
                          ? 'Mobile number cannot be blank'
                          : null,
                      decoration: InputDecoration(hintText: "Mobile number")),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                      controller: password,
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
                        "name": name.text.toString(),
                        "email": email.text.toString(),
                        "mobile": num.text.toString(),
                        "password": password.text.toString(),
                        "api_secret": "oApF8z0hmu",
                      };

                      if (_formKey.currentState!.validate()) {
                        dynamic response =
                            await Server().postMethodParems(API.newUser, prm);
                        if (response.statusCode == 200) {
                          dynamic user = jsonDecode(response.body);
                          log(user.toString());
                          if (user["response"] == "success") {
                            Navigator.pushNamedAndRemoveUntil(
                                    context, Routes.SignIn, (route) => false)
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
    //     signUpForm: SignUpForm.custom(fields: [
    //       SignUpFormField.username(),
    //       SignUpFormField.email(required: true),
    //       SignUpFormField.password(),
    //       SignUpFormField.passwordConfirmation()
    //     ]),
    //     child: MaterialApp(
    //         builder: Authenticator.builder(),
    //         home: HomeScreen()
    //     )
    // );
  }

  var myScreenFocusNode = FocusNode();

  _submit() async {
    setState(() {
      _isInProgress = true;
    });
    await Future.delayed(const Duration(milliseconds: 700));

    FocusScope.of(context).requestFocus(myScreenFocusNode);
    if (_formKey.currentState!.validate() == false) {
      setState(() {
        _isInProgress = false;
      });
      return;
    }
    _formKey.currentState!.save();
    Navigator.pushNamedAndRemoveUntil(
        context, Routes.Home, (Route<dynamic> route) => false);
  }

  String _validateName(value) {
    if (value.isEmpty) {
      return "Email cannot be empty";
    }
    return "";
  }

  String _validateEmail(value) {
    if (value.isEmpty) {
      return "Email cannot be empty";
    }
    return "";
  }

  String _validatePassword(value) {
    if (value.isEmpty) {
      return "Password cannot be empty";
    } else if (value.length < 5) {
      return 'Password must contains ${5} characters';
    } else {
      return "";
    }
  }
}
