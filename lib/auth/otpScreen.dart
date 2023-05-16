import 'dart:convert';
import 'dart:developer';

import 'package:cryptomarket/constance/routes.dart';
import 'package:cryptomarket/repo/api_methods.dart';
import 'package:cryptomarket/repo/api_urls.dart';
import 'package:flutter/material.dart';

class OTP extends StatefulWidget {
  final dynamic uid;
  const OTP({Key? key, this.uid}) : super(key: key);

  @override
  State<OTP> createState() => _OTPState();
}

TextEditingController otp = TextEditingController();
final _formOTPKey = new GlobalKey<FormState>();

class _OTPState extends State<OTP> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Verify OTP")),
      body: Form(
        key: _formOTPKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 8.0, right: 8.0, top: 30.0, bottom: 30.0),
                child: TextFormField(
                    controller: otp,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) =>
                        value!.isEmpty ? 'Email cannot be blank' : null,
                    decoration: InputDecoration(hintText: "Enter OTP")),
              ),
              ElevatedButton.icon(
                  onPressed: () async {
                    var prm = {
                      "user_id": widget.uid.toString(),
                      "otp": otp.text.toString(),
                      "api_secret": "oApF8z0hmu",
                    };

                    if (_formOTPKey.currentState!.validate()) {
                      dynamic response =
                          await Server().getMethodParems(API.otpVerify, prm);
                      log(response.statusCode.toString());
                      if (response.statusCode == 200) {
                        dynamic user = jsonDecode(response.body);

                        if (user["response"] == "success") {
                          final snackBar = SnackBar(
                            content: const Text('Varified'),
                            action: SnackBarAction(
                              label: 'Close',
                              onPressed: () {
                                // Some code to undo the change.
                              },
                            ),
                          );

                          // Find the ScaffoldMessenger in the widget tree
                          // and use it to show a SnackBar.
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          if (response["is_verified"] == 1) {
                            Navigator.pushNamedAndRemoveUntil(
                                    context, Routes.SignIn, (route) => false)
                                .then((onValue) {});
                          }
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
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      }
                    }
                  },
                  icon: Icon(Icons.arrow_forward),
                  label: Text("Verify")),
              Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () async {
                        var prm = {
                          "user_id": widget.uid.toString(),
                          "api_secret": "oApF8z0hmu",
                        };

                        if (_formOTPKey.currentState!.validate()) {
                          dynamic response = await Server()
                              .getMethodParems(API.resendOTP, prm);
                          log(response.statusCode.toString());
                          if (response.statusCode == 200) {
                            dynamic user = jsonDecode(response.body);

                            if (user["response"] == "success") {
                              final snackBar = SnackBar(
                                content: const Text('OTP sent'),
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
                            } else {
                              final snackBar = SnackBar(
                                content: const Text('Something went Wrong'),
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
                      child: Text("Resend OTP?")))
            ],
          ),
        ),
      ),
    );
  }
}
