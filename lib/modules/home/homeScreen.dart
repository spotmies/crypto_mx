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

Map<String, dynamic> parseJwt(String token) {
  final parts = token.split('.');
  if (parts.length != 3) {
    throw Exception('invalid token');
  }

  final payload = _decodeBase64(parts[1]);
  final payloadMap = json.decode(payload);
  if (payloadMap is! Map<String, dynamic>) {
    throw Exception('invalid payload');
  }

  return payloadMap;
}

String _decodeBase64(String str) {
  String output = str.replaceAll('-', '+').replaceAll('_', '/');

  switch (output.length % 4) {
    case 0:
      break;
    case 2:
      output += '==';
      break;
    case 3:
      output += '=';
      break;
    default:
      throw Exception('Illegal base64url string!"');
  }

  return utf8.decode(base64Url.decode(output));
}
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isInProgress = false;
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isSelect1 = false;
  bool isSelect2 = false;
  bool isSelect3 = false;
  bool _isSearch = false;
  bool allCoin = false;
  bool isLoading = false;

  var width = 0.0;
  var height = 0.0;
  var appBarheight = 0.0;
  var statusBarHeight = 0.0;
  var graphHeight = 0.0;
  List<CryptoCoinDetail> _serchCoinList = [];
  var marketCapUpDown;

  String historyAmt = "720";
  String historyType = "minute";
  String historyTotal = "24h";
  String historyAgg = "2";
  String _high = "0";
  String _low = "0";
  String _change = "0";
  String symbol = 'BTC';
  void getCurrentUser() async{
    final authState = await Amplify.Auth.fetchAuthSession(
        options: CognitoSessionOptions(getAWSCredentials: true))
    as CognitoAuthSession;
    if (authState.isSignedIn) {
      final claims = parseJwt(authState.userPoolTokens!.idToken);
      final email = claims['email'] as String;
      signedInUser = email;
      print(signedInUser);
    }
  }
  @override
  void initState(){
    super.initState();
    getCurrentUser();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Scaffold(
      backgroundColor: AllCoustomTheme.getThemeData().backgroundColor,
      key: _scaffoldKey,
      drawer: SizedBox(
        width: MediaQuery.of(context).size.width * 0.75 < 400 ? MediaQuery.of(context).size.width * 0.75 : 350,
        child: Drawer(
          elevation: 0,
          child: AppDrawer(
            selectItemName: 'wallet',
          ),
        ),
      ),
      body: Container(
        height: height,
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            SizedBox(height: height*0.1,),
            Padding(
              padding: const EdgeInsets.only(right: 16, left: 16),
              child: Row(
                children: <Widget>[
                  IconButton(
                      onPressed: (){
                        _scaffoldKey.currentState!.openDrawer();
                  },
                      icon: Icon(Icons.sort,color: Color(0xff515669),)),
                  Animator<double>(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.decelerate,
                    cycles: 1,
                    builder: (_, anim, __) => Transform.scale(
                      scale: anim.value,
                      child: Text(
                        'Wallet',
                        style: TextStyle(color: Color(0xff515669), fontSize: 25),
                      ),
                    ),
                  ),
                  Spacer(),
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Color(0xff1a2030),
                    child: IconButton(
                      icon: Icon(
                          Icons.person
                      ),
                      onPressed: (){
                        Navigator.of(context).push(
                          CupertinoPageRoute(
                            builder: (BuildContext context) => UserProfile(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height:20),
            SizedBox(
              height: MediaQuery.of(context).size.height*0.2,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: [
                  SizedBox(width: 10,),
                  InkWell(
                    onTap: (){
                      Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (BuildContext context) => TransactionInfo(),
                        ),
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width*0.6,
                      decoration: BoxDecoration(
                          color: Color(0xff1a2030),
                          borderRadius: BorderRadius.all(Radius.circular(40))
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width*0.6,
                            height: 5,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight,
                                  colors: [
                                    Color(0xff16314a),
                                    Color(0xff6043ba)
                                  ]
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              SizedBox(width: 10,),
                              Text("Bitcoin", style: TextStyle(color: Colors.white, fontSize: 25),),
                            ],
                          ),
                          SizedBox(height: 5,),
                          Row(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  SizedBox(width: 10,),
                                  Text("2", style: TextStyle(color: Colors.white, fontSize: 40,fontWeight: FontWeight.w600),),
                                  Text(".36", style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.w600),),
                                ],
                              ),
                              Spacer(),
                              Image.network(coinImageURL+"btc"+"@2x.png",width: MediaQuery.of(context).size.width*0.15,)
                            ],
                          ),
                          SizedBox(height: 5,),
                          Row(
                            children: [
                              SizedBox(width: 10,),
                              Text("22 Days Left",style: TextStyle(
                                  color: Color(0xff515669),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600
                              ),),
                            ],
                          )
                        ],

                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Container(
                    width: MediaQuery.of(context).size.width*0.6,
                    decoration: BoxDecoration(
                        color: Color(0xff1a2030),
                        borderRadius: BorderRadius.all(Radius.circular(40))
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width*0.6,
                          height: 5,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                                colors: [
                                  Color(0xff16314a),
                                  Color(0xff6043ba)
                                ]
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(width: 10,),
                            Text("Ethereum", style: TextStyle(color: Colors.white, fontSize: 25),),
                          ],
                        ),
                        SizedBox(height: 5,),
                        Row(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                SizedBox(width: 10,),
                                Text("3", style: TextStyle(color: Colors.white, fontSize: 40,fontWeight: FontWeight.w600),),
                                Text(".34", style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.w600),),
                              ],
                            ),
                            Spacer(),
                            Image.network(coinImageURL+"eth"+"@2x.png",width: MediaQuery.of(context).size.width*0.15,)
                          ],
                        ),
                        SizedBox(height: 5,),
                        Row(
                          children: [
                            SizedBox(width: 10,),
                            Text("32 Days Left",style: TextStyle(
                                color: Color(0xff515669),
                                fontSize: 20,
                                fontWeight: FontWeight.w600
                            ),),
                          ],
                        )
                      ],

                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),
            Text("Recent transactions",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w600,
                color: Color(0xff515669),

              ),
            ),
            SizedBox(height: 10,),
            Container(
              width: width*0.9,
              height: MediaQuery.of(context).size.height*0.55,
              decoration: BoxDecoration(
                  color: Color(0xff1a2030),
                  borderRadius: BorderRadius.all(Radius.circular(40))
              ),
              child: ListView(
                shrinkWrap: true,
                children: [
                  SizedBox(height: 20,),
                  InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: (){},
                    child: Container(
                      child: Row(
                        children: [
                          SizedBox(width: 10,),
                          Image.network(coinImageURL+"eth"+"@2x.png",width: MediaQuery.of(context).size.width*0.1,),
                          SizedBox(width: 20,),
                          Text("Ethereum", style: TextStyle(color: Color(0xff515669), fontSize: 25),),
                          Spacer(),
                          Text("-0.3", style: TextStyle(color: Color(0xff515669), fontSize: 25),),
                          SizedBox(width: 10,)
                        ],
                      ),
                    ),
                  ),
                  Divider(height: 10,
                    thickness: 3,
                    indent: 70,
                    color: Color(0xff515669),
                  ),
                  SizedBox(height: 15,),
                  InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: (){},
                    child: Container(
                      child: Row(
                        children: [
                          SizedBox(width: 10,),
                          Image.network(coinImageURL+"eth"+"@2x.png",width: MediaQuery.of(context).size.width*0.1,),
                          SizedBox(width: 20,),
                          Text("Ethereum", style: TextStyle(color: Color(0xff515669), fontSize: 25),),
                          Spacer(),
                          Text("-0.3", style: TextStyle(color: Color(0xff515669), fontSize: 25),),
                          SizedBox(width: 10,)
                        ],
                      ),
                    ),
                  ),
                  Divider(height: 10,
                    thickness: 3,
                    indent: 70,
                    color: Color(0xff515669),
                  ),
                  SizedBox(height: 15,),
                  InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: (){},
                    child: Container(
                      child: Row(
                        children: [
                          SizedBox(width: 10,),
                          Image.network(coinImageURL+"eth"+"@2x.png",width: MediaQuery.of(context).size.width*0.1,),
                          SizedBox(width: 20,),
                          Text("Ethereum", style: TextStyle(color: Color(0xff515669), fontSize: 25),),
                          Spacer(),
                          Text("-0.3", style: TextStyle(color: Color(0xff515669), fontSize: 25),),
                          SizedBox(width: 10,)
                        ],
                      ),
                    ),
                  ),
                  Divider(height: 10,
                    thickness: 3,
                    indent: 70,
                    color: Color(0xff515669),
                  ),
                  SizedBox(height: 15,),
                  InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: (){},
                    child: Container(
                      child: Row(
                        children: [
                          SizedBox(width: 10,),
                          Image.network(coinImageURL+"eth"+"@2x.png",width: MediaQuery.of(context).size.width*0.1,),
                          SizedBox(width: 20,),
                          Text("Ethereum", style: TextStyle(color: Color(0xff515669), fontSize: 25),),
                          Spacer(),
                          Text("-0.3", style: TextStyle(color: Color(0xff515669), fontSize: 25),),
                          SizedBox(width: 10,)
                        ],
                      ),
                    ),
                  ),
                  Divider(height: 10,
                    thickness: 3,
                    indent: 70,
                    color: Color(0xff515669),
                  ),
                  SizedBox(height: 15,),
                  InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: (){},
                    child: Container(
                      child: Row(
                        children: [
                          SizedBox(width: 10,),
                          Image.network(coinImageURL+"eth"+"@2x.png",width: MediaQuery.of(context).size.width*0.1,),
                          SizedBox(width: 20,),
                          Text("Ethereum", style: TextStyle(color: Color(0xff515669), fontSize: 25),),
                          Spacer(),
                          Text("-0.3", style: TextStyle(color: Color(0xff515669), fontSize: 25),),
                          SizedBox(width: 10,)
                        ],
                      ),
                    ),
                  ),
                  Divider(height: 10,
                    thickness: 3,
                    indent: 70,
                    color: Color(0xff515669),
                  ),
                  SizedBox(height: 15,),
                  InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: (){},
                    child: Container(
                      child: Row(
                        children: [
                          SizedBox(width: 10,),
                          Image.network(coinImageURL+"eth"+"@2x.png",width: MediaQuery.of(context).size.width*0.1,),
                          SizedBox(width: 20,),
                          Text("Ethereum", style: TextStyle(color: Color(0xff515669), fontSize: 25),),
                          Spacer(),
                          Text("-0.3", style: TextStyle(color: Color(0xff515669), fontSize: 25),),
                          SizedBox(width: 10,)
                        ],
                      ),
                    ),
                  ),
                  Divider(height: 10,
                    thickness: 3,
                    indent: 70,
                    color: Color(0xff515669),
                  ),
                  SizedBox(height: 15,),
                  InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: (){},
                    child: Container(
                      child: Row(
                        children: [
                          SizedBox(width: 10,),
                          Image.network(coinImageURL+"eth"+"@2x.png",width: MediaQuery.of(context).size.width*0.1,),
                          SizedBox(width: 20,),
                          Text("Ethereum", style: TextStyle(color: Color(0xff515669), fontSize: 25),),
                          Spacer(),
                          Text("-0.3", style: TextStyle(color: Color(0xff515669), fontSize: 25),),
                          SizedBox(width: 10,)
                        ],
                      ),
                    ),
                  ),
                  Divider(height: 10,
                    thickness: 3,
                    indent: 70,
                    color: Color(0xff515669),
                  ),
                  SizedBox(height: 15,),
                  InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: (){},
                    child: Container(
                      child: Row(
                        children: [
                          SizedBox(width: 10,),
                          Image.network(coinImageURL+"eth"+"@2x.png",width: MediaQuery.of(context).size.width*0.1,),
                          SizedBox(width: 20,),
                          Text("Ethereum", style: TextStyle(color: Color(0xff515669), fontSize: 25),),
                          Spacer(),
                          Text("-0.3", style: TextStyle(color: Color(0xff515669), fontSize: 25),),
                          SizedBox(width: 10,)
                        ],
                      ),
                    ),
                  ),
                  Divider(height: 10,
                    thickness: 3,
                    indent: 70,
                    color: Color(0xff515669),
                  ),
                  SizedBox(height: 15,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

