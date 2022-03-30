import 'dart:convert';
import 'dart:math';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:animator/animator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity/connectivity.dart';
import 'package:cryptomarket/api/apiProvider.dart';
import 'package:cryptomarket/constance/constance.dart';
import 'package:cryptomarket/constance/global.dart';
import 'package:cryptomarket/constance/themes.dart';
import 'package:cryptomarket/graphDetail/QuickPercentChangeBar.dart';
import 'package:cryptomarket/main.dart';
import 'package:cryptomarket/model/listingsModel.dart';
import 'package:cryptomarket/modules/chagePIN/changePassword.dart';
import 'package:cryptomarket/modules/chagePIN/changepin.dart';
import 'package:cryptomarket/modules/drawer/drawer.dart';
import 'package:cryptomarket/modules/news/latestCryptoNews.dart';
import 'package:cryptomarket/modules/underGroundSlider/cryptoCoinDetailSlider.dart';
import 'package:cryptomarket/modules/underGroundSlider/notificationSlider.dart';
import 'package:cryptomarket/modules/userProfile/userProfile.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cryptomarket/constance/global.dart' as globals;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:async';
import 'package:candlesticks/candlesticks.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import '../../constance/routes.dart';
import 'transactionHistory.dart';
import 'package:cryptomarket/models/Transaction.dart';
import 'transactionInfoDummy.dart';
import 'dart:convert';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: AllCoustomTheme.getThemeData().primaryColor,
      child: Column(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(top: 8),
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.1,
                ),
                Row(
                  children: <Widget>[
                    Animator<double>(
                      tween: Tween<double>(begin: 0, end: 1),
                      duration: Duration(milliseconds: 500),
                      cycles: 1,
                      builder: (_, anim, __) => SizeTransition(
                        sizeFactor: anim.animation,
                        axis: Axis.horizontal,
                        axisAlignment: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: Text(
                              'Settings',
                              style: TextStyle(
                                color: AllCoustomTheme.getTextThemeColors(),
                                fontWeight: FontWeight.bold,
                                fontSize: ConstanceData.SIZE_TITLE25,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              'Account',
                              style: TextStyle(
                                color: AllCoustomTheme.getsecoundTextThemeColor(),
                                fontSize: ConstanceData.SIZE_TITLE16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        InkWell(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: () {
                            Navigator.of(context).push(
                              CupertinoPageRoute(
                                builder: (BuildContext context) => UserProfile(),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'User Profile',
                                style: TextStyle(
                                  color: AllCoustomTheme.getTextThemeColors(),
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
                          padding: const EdgeInsets.only(top: 8),
                          child: AnimatedDivider(),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: () async{
                            try {
                              var user = await Amplify.Auth.getCurrentUser();
                              var username = user.username;
                              globals.posts = await Amplify.DataStore.query(
                                Transaction.classType,
                                where: Transaction.USERNAME.eq(username),
                              );
                            } on DataStoreException catch (e) {
                              print('Query failed: $e');
                            }
                            for(var i in posts){
                              print(i.transactionId);
                            }

                            Navigator.of(context).push(
                              CupertinoPageRoute(
                                builder: (BuildContext context) => TransactionHistory(),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Transaction History',
                                style: TextStyle(
                                  color: AllCoustomTheme.getTextThemeColors(),
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
                          padding: const EdgeInsets.only(top: 8),
                          child: AnimatedDivider(),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: () {
                            Navigator.of(context).push(
                              CupertinoPageRoute(
                                builder: (BuildContext context) => ChangePassword(),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Change Password',
                                style: TextStyle(
                                  color: AllCoustomTheme.getTextThemeColors(),
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
                        InkWell(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: () async{
                            try {
                              await Amplify.Auth.signOut();
                              Amplify.DataStore.clear();
                              Navigator.pushNamedAndRemoveUntil(context, Routes.SignIn, (route) => false);
                            } on AuthException catch (e) {
                              print(e.message);
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Log Out',
                                style: TextStyle(
                                  color: AllCoustomTheme.getTextThemeColors(),
                                ),
                              ),
                              AnimatedForwardArrow(
                                isShowingarroeForward: true,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
