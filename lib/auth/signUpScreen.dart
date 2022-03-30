import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:animator/animator.dart';
import 'package:cryptomarket/auth/signInScreen.dart';
import 'package:cryptomarket/constance/constance.dart';
import 'package:cryptomarket/constance/routes.dart';
import 'package:cryptomarket/constance/themes.dart';
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

  @override
  Widget build(BuildContext context) {
    return Authenticator(
        signUpForm: SignUpForm.custom(fields: [
          SignUpFormField.username(),
          SignUpFormField.email(required: true),
          SignUpFormField.password(),
          SignUpFormField.passwordConfirmation()
        ]),
        child: MaterialApp(
            builder: Authenticator.builder(),
            home: HomeScreen()
        )
    );
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
    Navigator.pushNamedAndRemoveUntil(context, Routes.Home, (Route<dynamic> route) => false);
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
