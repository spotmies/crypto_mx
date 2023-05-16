import 'dart:convert';
import 'dart:developer';

import 'package:cryptomarket/constance/routes.dart';
import 'package:cryptomarket/repo/api_methods.dart';
import 'package:cryptomarket/repo/api_urls.dart';
import 'package:cryptomarket/utils/shared_preferences.dart';
import 'package:flutter/material.dart';

import '../../constance/themes.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);
  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  var oldPassword;
  var newPassword;
  var confirmPassword;
  var oldPasswordController;
  var newPasswordController;
  var confirmPasswordController;
  var check = null;
  final changePwdKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    return Scaffold(
      backgroundColor: AllCoustomTheme.getThemeData().primaryColor,
      appBar: AppBar(
        backgroundColor: AllCoustomTheme.getThemeData().primaryColor,
        title: Text(
          "Change Password",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Form(
        key: changePwdKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                SizedBox(
                  width: width * 0.1,
                ),
                Text(
                  "Old Password",
                  style: TextStyle(color: Colors.white, fontSize: width * 0.04),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: width * 0.9,
                  child: TextFormField(
                    validator: (value) =>
                        value!.isEmpty ? 'Enter Old Password' : null,
                    controller: oldPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.grey),
                      hintText: 'Enter Old Password',
                      fillColor: Colors.white,
                      filled: true,
                      hoverColor: Colors.white,
                      focusColor: Colors.white,
                      alignLabelWithHint: true,
                      labelStyle: TextStyle(color: Colors.white),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: height * 0.01, horizontal: width * 0.1),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        borderSide:
                            const BorderSide(color: Colors.white, width: 2.0),
                      ),
                    ),
                    onChanged: (value) {
                      oldPassword = value;
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SizedBox(
                  width: width * 0.1,
                ),
                Text(
                  "New Password",
                  style: TextStyle(color: Colors.white, fontSize: width * 0.04),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: width * 0.9,
                  child: TextFormField(
                    validator: (value) =>
                        value!.isEmpty ? 'Enter New Password' : null,
                    controller: newPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.grey),
                      hintText: 'Enter New Password',
                      fillColor: Colors.white,
                      filled: true,
                      hoverColor: Colors.white,
                      focusColor: Colors.white,
                      alignLabelWithHint: true,
                      labelStyle: TextStyle(color: Colors.white),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: height * 0.01, horizontal: width * 0.1),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        borderSide:
                            const BorderSide(color: Colors.white, width: 2.0),
                      ),
                    ),
                    onChanged: (value) {
                      newPassword = value;
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SizedBox(
                  width: width * 0.1,
                ),
                Text(
                  "Confirm Password",
                  style: TextStyle(color: Colors.white, fontSize: width * 0.04),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: width * 0.9,
                  child: TextFormField(
                    controller: confirmPasswordController,
                    obscureText: true,
                    validator: (value) =>
                        value!.isEmpty ? 'Confirm Password' : null,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.grey),
                      hintText: 'Confirm Password',
                      fillColor: Colors.white,
                      filled: true,
                      hoverColor: Colors.white,
                      focusColor: Colors.white,
                      alignLabelWithHint: true,
                      errorText: check,
                      labelStyle: TextStyle(color: Colors.white),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: height * 0.01, horizontal: width * 0.1),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        borderSide:
                            const BorderSide(color: Colors.white, width: 2.0),
                      ),
                    ),
                    onChanged: (value) {
                      confirmPassword = value;
                      setState(() {
                        confirmPassword == newPassword
                            ? check = null
                            : check = "Password not matching";
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: width * 0.75,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blueAccent, // background
                      onPrimary: Colors.white, // foreground
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(32.0))),
                    ),
                    onPressed: () async {
                      var user = await getUserData();
                      var prm = {
                        "api_secret": "oApF8z0hmu",
                        "old_password": oldPassword.toString(),
                        "new_password": newPassword.toString(),
                        "user_id": user["user"]["id"].toString()
                      };

                      if (changePwdKey.currentState!.validate()) {
                        dynamic response = await Server()
                            .getMethodParems(API.changePassword, prm);
                        log(response.body.toString());
                        if (response.statusCode == 200) {
                          dynamic user = jsonDecode(response.body);

                          if (user["response"] == "success") {
                            final snackBar = SnackBar(
                              content:
                                  const Text('password updated successfully'),
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
                            Navigator.pushNamedAndRemoveUntil(
                                    context, Routes.Home, (route) => false)
                                .then((onValue) {});
                          } else {
                            final snackBar = SnackBar(
                              content: const Text('Invalid OTP'),
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
                      // if (newPassword != confirmPassword) {
                      //   confirmPasswordController.clear();
                      //   newPasswordController.clear();
                      // } else {
                      //   try {
                      //     await Amplify.Auth.updatePassword(
                      //         newPassword: "mynewpassword",
                      //         oldPassword: "myoldpassword");
                      //   } on AmplifyException catch (e) {
                      //     print(e);
                      //     if (!confirmPasswordController.text.isEmpty)
                      //       confirmPasswordController.clear();
                      //     if (!newPasswordController.text.isEmpty)
                      //       newPasswordController.clear();
                      //   }
                      // }

                      // setState(() {
                      //   String msg = "";
                      //   oldPasswordController.text.isEmpty ||
                      //           newPasswordController.text.isEmpty ||
                      //           confirmPasswordController.text.isEmpty
                      //       ? msg = "please check the details and submit again"
                      //       : msg = "Password Changed Sucessfully";
                      //   if (!oldPasswordController.text.isEmpty)
                      //     oldPasswordController.clear();
                      //   if (!newPasswordController.text.isEmpty)
                      //     newPasswordController.clear();
                      //   if (!confirmPasswordController.text.isEmpty)
                      //     confirmPasswordController.clear();
                      //   final snackBar = SnackBar(
                      //     content: Text(msg),
                      //     action: SnackBarAction(
                      //       label: 'Go Back',
                      //       onPressed: () {
                      //         // Some code to undo the change.
                      //         Navigator.pop(context);
                      //       },
                      //     ),
                      //   );

                      //   // Find the ScaffoldMessenger in the widget tree
                      //   // and use it to show a SnackBar.
                      //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      // });
                      // ;
                    },
                    child: const Text('Submit'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
