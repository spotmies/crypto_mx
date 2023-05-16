import 'dart:convert';
import 'dart:developer';

import 'package:animator/animator.dart';
import 'package:cryptomarket/constance/constance.dart';
import 'package:cryptomarket/constance/global.dart';
import 'package:cryptomarket/constance/themes.dart';
import 'package:cryptomarket/modules/chagePIN/changePassword.dart';
import 'package:cryptomarket/repo/api_methods.dart';
import 'package:cryptomarket/repo/api_urls.dart';
import 'package:cryptomarket/utils/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cryptomarket/constance/global.dart' as globals;
import 'dart:async';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  bool _isInProgress = false;

  @override
  void initState() {
    super.initState();
    loadUserDetails();
    getUser();
  }

  dynamic uDetails;

  getUser() async {
    dynamic user = await getUserData();
    var prm = {
      "api_secret": "oApF8z0hmu",
      "user_id": user["user"]["id"].toString(),
    };
    // print("qwertyuiop" + loc.toString());
    dynamic res = await Server().getMethodParems(API.userDetails, prm);
    log(res.body.toString());
    if (res.statusCode == 200) {
      setState(() {
        uDetails = jsonDecode(res.body);
      });
      print('$uDetails');
    }
  }

  loadUserDetails() async {
    setState(() {
      _isInProgress = true;
    });
    await Future.delayed(const Duration(milliseconds: 700));
    setState(() {
      _isInProgress = false;
    });
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar();
    double appBarheight = appBar.preferredSize.height;
    if (uDetails == null) {
      return Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      );
    }
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
          backgroundColor: AllCoustomTheme.getThemeData().primaryColor,
          body: ModalProgressHUD(
            inAsyncCall: _isInProgress,
            opacity: 0,
            progressIndicator: CupertinoActivityIndicator(
              radius: 12,
            ),
            child: !_isInProgress
                ? Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 16, left: 16),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: appBarheight,
                            ),
                            Row(
                              children: <Widget>[
                                InkWell(
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Animator<Offset>(
                                    tween: Tween<Offset>(
                                        begin: Offset(0, 0),
                                        end: Offset(0.2, 0)),
                                    duration: Duration(milliseconds: 500),
                                    cycles: 0,
                                    builder: (_, anim, __) =>
                                        FractionalTranslation(
                                      translation: anim.value,
                                      child: InkWell(
                                        highlightColor: Colors.transparent,
                                        splashColor: Colors.transparent,
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Icon(
                                          Icons.arrow_back_ios,
                                          color: AllCoustomTheme
                                              .getTextThemeColors(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Animator<double>(
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.decelerate,
                                    cycles: 1,
                                    builder: (_, anim, __) => Transform.scale(
                                      scale: anim.value,
                                      child: Text(
                                        'User Profile',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: AllCoustomTheme
                                              .getTextThemeColors(),
                                          fontWeight: FontWeight.bold,
                                          fontSize: ConstanceData.SIZE_TITLE20,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  uDetails["mobile"],
                                  style: TextStyle(
                                    color: AllCoustomTheme
                                        .getsecoundTextThemeColor(),
                                    fontSize: ConstanceData.SIZE_TITLE16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  signedInUser,
                                  style: TextStyle(
                                    color: AllCoustomTheme.getTextThemeColors(),
                                  ),
                                ),
                                AnimatedForwardArrow(
                                  isShowingarroeForward: false,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: AnimatedDivider(),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  CupertinoPageRoute(
                                    builder: (BuildContext context) =>
                                        ChangePassword(),
                                  ),
                                );
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Change Password',
                                    style: TextStyle(
                                      color:
                                          AllCoustomTheme.getTextThemeColors(),
                                    ),
                                  ),
                                  AnimatedForwardArrow(
                                    isShowingarroeForward: true,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: AnimatedDivider(),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        child: Align(
                          alignment: Alignment(0, 1.0),
                          child: _currentAd,
                        ),
                        fit: FlexFit.tight,
                        flex: 3,
                      )
                    ],
                  )
                : SizedBox(),
          ),
        ),
      ],
    );
  }

  Widget _currentAd = SizedBox(
    width: 0.0,
    height: 0.0,
  );
}
