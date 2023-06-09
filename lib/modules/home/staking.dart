// // ignore_for_file: unnecessary_null_comparison, unused_field, import_of_legacy_library_into_null_safe
// import 'dart:convert';
// import 'dart:math';
// import 'package:amplify_datastore/amplify_datastore.dart';
// import 'package:animator/animator.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:connectivity/connectivity.dart';
// import 'package:cryptomarket/api/apiProvider.dart';
// import 'package:cryptomarket/constance/constance.dart';
// import 'package:cryptomarket/constance/global.dart';
// import 'package:cryptomarket/constance/themes.dart';
// import 'package:cryptomarket/graphDetail/QuickPercentChangeBar.dart';
// import 'package:cryptomarket/main.dart';
// import 'package:cryptomarket/model/listingsModel.dart';
// import 'package:cryptomarket/modules/chagePIN/changePassword.dart';
// import 'package:cryptomarket/modules/chagePIN/changepin.dart';
// import 'package:cryptomarket/modules/drawer/drawer.dart';
// import 'package:cryptomarket/modules/news/latestCryptoNews.dart';
// import 'package:cryptomarket/modules/underGroundSlider/cryptoCoinDetailSlider.dart';
// import 'package:cryptomarket/modules/underGroundSlider/notificationSlider.dart';
// import 'package:cryptomarket/modules/userProfile/userProfile.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:cryptomarket/constance/global.dart' as globals;
// import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
// import 'package:shimmer/shimmer.dart';
// import 'dart:async';
// import 'package:candlesticks/candlesticks.dart';
// import 'package:web_socket_channel/web_socket_channel.dart';
// import 'package:amplify_flutter/amplify_flutter.dart';
// import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
// import '../../constance/routes.dart';
// import 'transactionHistory.dart';
// import 'package:cryptomarket/models/Transaction.dart';
// import 'transactionInfoDummy.dart';
// import 'dart:convert';

// Map<String, dynamic> parseJwt(String token) {
//   final parts = token.split('.');
//   if (parts.length != 3) {
//     throw Exception('invalid token');
//   }

//   final payload = _decodeBase64(parts[1]);
//   final payloadMap = json.decode(payload);
//   if (payloadMap is! Map<String, dynamic>) {
//     throw Exception('invalid payload');
//   }

//   return payloadMap;
// }

// String _decodeBase64(String str) {
//   String output = str.replaceAll('-', '+').replaceAll('_', '/');

//   switch (output.length % 4) {
//     case 0:
//       break;
//     case 2:
//       output += '==';
//       break;
//     case 3:
//       output += '=';
//       break;
//     default:
//       throw Exception('Illegal base64url string!"');
//   }

//   return utf8.decode(base64Url.decode(output));
// }
// class StakeScreen extends StatefulWidget {
//   @override
//   _StakeScreenState createState() => _StakeScreenState();
// }

// const String testDevice = 'YOUR_DEVICE_ID';

// class _StakeScreenState extends State<StakeScreen> {
//   var _scaffoldKey = new GlobalKey<ScaffoldState>();

//   bool _isInProgress = false;
//   bool isSelect1 = false;
//   bool isSelect2 = false;
//   bool isSelect3 = false;
//   bool _isSearch = false;
//   bool allCoin = false;
//   bool isLoading = false;

//   var width = 0.0;
//   var height = 0.0;
//   var appBarheight = 0.0;
//   var statusBarHeight = 0.0;
//   var graphHeight = 0.0;
//   List<CryptoCoinDetail> _serchCoinList = [];
//   var marketCapUpDown;

//   String historyAmt = "720";
//   String historyType = "minute";
//   String historyTotal = "24h";
//   String historyAgg = "2";
//   String _high = "0";
//   String _low = "0";
//   String _change = "0";
//   String symbol = 'BTC';

//   USD generalStats = new USD();
//   int currentOHLCVWidthSetting = 0;
//   List historyOHLCV = [];

//   var subscription;

//   List<CryptoCoinDetail> lstCryptoCoinDetail = [];
//   void getCurrentUser() async{
//     final authState = await Amplify.Auth.fetchAuthSession(
//         options: CognitoSessionOptions(getAWSCredentials: true))
//     as CognitoAuthSession;
//     if (authState.isSignedIn) {
//       final claims = parseJwt(authState.userPoolTokens!.idToken);
//       final email = claims['email'] as String;
//       signedInUser = email;
//       print(signedInUser);
//     }
//   }
//   @override

//   void initState() {
//     super.initState();
//     binanceFetch("1m");
//     setFirstTab();
//     callItself();
//     getCurrentUser();
//     print(signedInUser);
//     subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
//       print(result.index); // 0=wifi, 1=mobile, 2=none
//       if (result.index != 2) {
//         setFirstTab();
//         callItself();
//         marketCapUpDown = Icons.arrow_upward;
//       } else {
//         connectionError();
//       }
//     });

//   }
//   connectionError() {
//     showInSnackBar(ConstanceData.NoInternet);
//   }
//   Widget investmentCard(coinName,amount,usd,coinSymbol){
//     return Container(
//       width: MediaQuery.of(context).size.width*0.6,
//       decoration: const BoxDecoration(
//         color: Color(0xff1a2030),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Container(
//             width: MediaQuery.of(context).size.width*0.6,
//             height: 5,
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                   begin: Alignment.bottomLeft,
//                   end: Alignment.topRight,
//                   colors: [
//                     Color(0xff16314a),
//                     Color(0xff6043ba)
//                   ]
//               ),
//             ),
//           ),
//           Row(
//             children: [
//               Text(coinName, style: TextStyle(color: Colors.white, fontSize: 25),),
//             ],
//           ),
//           SizedBox(height: 5,),
//           Row(
//             children: [
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.baseline,
//                 textBaseline: TextBaseline.alphabetic,
//                 children: [
//                   Text("\$", style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.w600),),
//                   Text(usd.toInt().toString(), style: TextStyle(color: Colors.white, fontSize: 40,fontWeight: FontWeight.w600),),
//                   Text("."+(usd%1)!=0?(usd%1).toString().substring(2,4):"00", style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.w600),),
//                 ],
//               ),
//               Spacer(),
//               Image.network(globals.coinImageURL+coinSymbol+"@2x.png",width: MediaQuery.of(context).size.width*0.15,)
//             ],
//           ),
//           SizedBox(height: 5,),
//           Row(
//             children: [
//               Text(amount.toString(),style: TextStyle(
//                   color: Color(0xff515669),
//                   fontSize: 20,
//                   fontWeight: FontWeight.w600
//               ),),
//             ],
//           )
//         ],

//       ),
//     );
//   }

//   Future showInSnackBar(String value, {bool isGreeen = false}) async {
//     await Future.delayed(const Duration(milliseconds: 700));
//     // ignore: deprecated_member_use
//     _scaffoldKey.currentState!.showSnackBar(
//       new SnackBar(
//         duration: Duration(seconds: 2),
//         content: new Text(
//           value,
//           style: TextStyle(
//             color: AllCoustomTheme.getReBlackAndWhiteThemeColors(),
//           ),
//         ),
//         backgroundColor: isGreeen ? AllCoustomTheme.getThemeData().primaryColor : Colors.red,
//       ),
//     );
//   }

//   isLoadingList() async {
//     setState(() {
//       isLoading = true;
//     });
//     await Future.delayed(const Duration(seconds: 1));
//     setState(() {
//       isLoading = false;
//     });
//   }

//   Future<Null> getApiAllData(int index) async {
//     List<CryptoCoinDetail> allCoinList = [];
//     allCoinList.clear();
//     List<CryptoCoinDetail> coindata = await getData1(index);
//     coindata = await getData1(index);
//     if (coindata != null) {
//       if (coindata.length != 0) {
//         index += coindata.length;
//         if (index == 1) {
//           setState(() {
//             allCoinList.addAll(coindata);
//           });
//         } else {
//           allCoinList.addAll(coindata);
//           setState(() {
//             allCoinList.removeWhere((length) => length.quote!.uSD!.marketCap == null);
//             if (allCoin == true) {
//               getApiAllData(index);
//             }
//             lstCryptoCoinDetail.clear();
//             lstCryptoCoinDetail.addAll(allCoinList);
//             lstCryptoCoinDetail.sort((a, b) => b.quote!.uSD!.marketCap!.compareTo(a.quote!.uSD!.marketCap ?? 0));
//             print(lstCryptoCoinDetail[0].quote!.uSD);

//             marketListData.clear();
//             marketListData.addAll(allCoinList);
//             marketListData.sort((a, b) => b.quote.uSD.marketCap.compareTo(a.quote.uSD.marketCap));
//           });
//         }
//       }
//     }
//   }

//   callItself() async {
//     await getApiAllData(1);
//     await changeHistory(historyType, historyAmt, historyTotal, historyAgg);
//     await Future.delayed(Duration(hours: 1));
//     callItself();
//   }

//   Future<Null> changeHistory(String type, String amt, String total, String agg) async {
//     setState(() {
//       _high = "0";
//       _low = "0";
//       _change = "0";

//       historyAmt = amt;
//       historyType = type;
//       historyTotal = total;
//       historyAgg = agg;

//       historyOHLCV = [];
//     });
//     _makeGeneralStats();
//     await getHistoryOHLCV();
//     _getHL();
//   }

//   _makeGeneralStats() {
//     for (CryptoCoinDetail coin in marketListData) {
//       if (coin.symbol == symbol) {
//         generalStats = coin.quote!.uSD!;
//         setState(() {});
//         break;
//       }
//     }
//   }

//   _getHL() {
//     num highReturn = -double.infinity;
//     num lowReturn = double.infinity;

//     for (var i in historyOHLCV) {
//       if (i["high"] > highReturn) {
//         highReturn = i["high"].toDouble();
//       }
//       if (i["low"] < lowReturn) {
//         lowReturn = i["low"].toDouble();
//       }
//     }

//     _high = normalizeNumNoCommas(highReturn);
//     _low = normalizeNumNoCommas(lowReturn);

//     var start = historyOHLCV[0]["open"] == 0 ? 1 : historyOHLCV[0]["open"];
//     var end = historyOHLCV.last["close"];
//     var changePercent = (end - start) / start * 100;
//     _change = changePercent.toStringAsFixed(2);
//   }

//   Future<Null> getHistoryOHLCV() async {
//     Map<String, dynamic> head = {
//       "Accept": "application/json",
//     };

//     try {
//       var response = await Dio().get(
//         "https://min-api.cryptocompare.com/data/histo" +
//             ohlcvWidthOptions[historyTotal][currentOHLCVWidthSetting][3] +
//             "?fsym=" +
//             symbol +
//             "&tsym=USD&limit=" +
//             (ohlcvWidthOptions[historyTotal][currentOHLCVWidthSetting][1] - 1).toString() +
//             "&aggregate=" +
//             ohlcvWidthOptions[historyTotal][currentOHLCVWidthSetting][2].toString(),
//         options: Options(
//           headers: head,
//         ),
//       );

//       setState(() {
//         historyOHLCV = response.data["Data"];
//         if (historyOHLCV == null) {
//           historyOHLCV = [];
//         }
//       });
//     } catch (e) {
//       print(e);
//     } finally {
//       setState(() {});
//     }
//   }

//   setFirstTab() {
//     setState(() {
//       isSelect1 = true;
//       isSelect2 = false;
//       isSelect3 = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     AppBar appBar = AppBar();
//     appBarheight = appBar.preferredSize.height;
//     height = MediaQuery.of(context).size.height;
//     width = MediaQuery.of(context).size.width;
//     statusBarHeight = MediaQuery.of(context).padding.top;
//     return Stack(
//       children: <Widget>[
//         Container(
//           foregroundDecoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//               colors: [
//                 HexColor(globals.primaryColorString).withOpacity(0.6),
//                 HexColor(globals.primaryColorString).withOpacity(0.6),
//                 HexColor(globals.primaryColorString).withOpacity(0.6),
//                 HexColor(globals.primaryColorString).withOpacity(0.6),
//               ],
//             ),
//           ),
//         ),
//         SafeArea(
//           bottom: true,
//           child: Scaffold(
//             key: _scaffoldKey,
//             drawer: SizedBox(
//               width: MediaQuery.of(context).size.width * 0.75 < 400 ? MediaQuery.of(context).size.width * 0.75 : 350,
//               child: Drawer(
//                 elevation: 0,
//                 child: AppDrawer(selectItemName: 'staking',),
//               ),
//             ),

//             backgroundColor: Colors.transparent,
//             body: ModalProgressHUD(
//               inAsyncCall: _isInProgress,
//               opacity: 0,
//               progressIndicator: SizedBox(),
//               child: Container(
//                 height: height,
//                 child: Column(
//                   children: <Widget>[
//                     SizedBox(
//                       height: MediaQuery.of(context).padding.top,
//                     ),
//                     Expanded(
//                       child:secondScreen()
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget firstAnimation() {
//     return Container(
//       height: 40,
//       width: width / 3,
//       color: Colors.transparent,
//       child: Icon(
//         Icons.account_balance_wallet,
//         color: isSelect1 ? AllCoustomTheme.getTextThemeColors() : AllCoustomTheme.getsecoundTextThemeColor(),
//       ),
//     );
//   }

//   Widget secondAnimation() {
//     return Container(
//       height: 40,
//       width: width / 3,
//       color: Colors.transparent,
//       child: Icon(
//         Icons.pie_chart,
//         color: isSelect2 ? AllCoustomTheme.getTextThemeColors() : AllCoustomTheme.getsecoundTextThemeColor(),
//       ),
//     );
//   }

//   Widget thirdAnimation() {
//     return Container(
//       height: 40,
//       width: width / 3,
//       color: Colors.transparent,
//       child: Icon(
//         Icons.settings,
//         color: isSelect3 ? AllCoustomTheme.getTextThemeColors() : AllCoustomTheme.getsecoundTextThemeColor(),
//       ),
//     );
//   }

//   List<Candle> candles = [];
//   WebSocketChannel? _channel;

//   String interval = "1m";
//   @override
//   void dispose() {
//     _channel!.sink.close();
//     super.dispose();
//   }

//   Future<void> binanceFetch(String interval) async {
//     await ApiProvider().fetchCandles(symbol: "BTCUSDT", interval: interval).then(
//           (value) => setState(
//             () {
//           this.interval = interval;
//           candles = value;
//         },
//       ),
//     );
//     if (_channel != null) _channel!.sink.close();
//     _channel = WebSocketChannel.connect(
//       Uri.parse('wss://stream.binance.com:9443/ws'),
//     );
//     _channel!.sink.add(
//       jsonEncode(
//         {
//           "method": "SUBSCRIBE",
//           "params": ["btcusdt@kline_" + interval],
//           "id": 1
//         },
//       ),
//     );
//   }

//   Widget firstScreen() {
//     graphHeight = height - appBarheight - 42;
//     return Container(
//       height: graphHeight,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.only(right: 16, left: 16),
//             child: Row(
//               children: <Widget>[
//                 Animator<double>(
//                   duration: Duration(milliseconds: 500),
//                   curve: Curves.decelerate,
//                   cycles: 1,
//                   builder: (_, anim, __) => Transform.scale(
//                     scale: anim.value,
//                     child: Text(
//                       'Wallet',
//                       style: TextStyle(color: Color(0xff515669), fontSize: 25),
//                     ),
//                   ),
//                 ),
//                 Spacer(),
//                 CircleAvatar(
//                   radius: 25,
//                   backgroundColor: Color(0xff1a2030),
//                   child: IconButton(
//                     icon: Icon(
//                         Icons.person
//                     ),
//                     onPressed: (){
//                       Navigator.of(context).push(
//                         CupertinoPageRoute(
//                           builder: (BuildContext context) => UserProfile(),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height:20),
//           SizedBox(
//             height: MediaQuery.of(context).size.height*0.2,
//             width: MediaQuery.of(context).size.width,
//             child: ListView(
//               scrollDirection: Axis.horizontal,
//               shrinkWrap: true,
//               children: [
//                 SizedBox(width: 10,),
//                 InkWell(
//                   onTap: (){
//                     Navigator.of(context).push(
//                       CupertinoPageRoute(
//                         builder: (BuildContext context) => TransactionInfo(),
//                       ),
//                     );
//                   },
//                   child: Container(
//                     width: MediaQuery.of(context).size.width*0.6,
//                     decoration: BoxDecoration(
//                         color: Color(0xff1a2030),
//                         borderRadius: BorderRadius.all(Radius.circular(40))
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Container(
//                           width: MediaQuery.of(context).size.width*0.6,
//                           height: 5,
//                           decoration: BoxDecoration(
//                             gradient: LinearGradient(
//                                 begin: Alignment.bottomLeft,
//                                 end: Alignment.topRight,
//                                 colors: [
//                                   Color(0xff16314a),
//                                   Color(0xff6043ba)
//                                 ]
//                             ),
//                           ),
//                         ),
//                         Row(
//                           children: [
//                             SizedBox(width: 10,),
//                             Text("Bitcoin", style: TextStyle(color: Colors.white, fontSize: 25),),
//                           ],
//                         ),
//                         SizedBox(height: 5,),
//                         Row(
//                           children: [
//                             Row(
//                               crossAxisAlignment: CrossAxisAlignment.baseline,
//                               textBaseline: TextBaseline.alphabetic,
//                               children: [
//                                 SizedBox(width: 10,),
//                                 Text("2", style: TextStyle(color: Colors.white, fontSize: 40,fontWeight: FontWeight.w600),),
//                                 Text(".36", style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.w600),),
//                               ],
//                             ),
//                             Spacer(),
//                             Image.network(coinImageURL+"btc"+"@2x.png",width: MediaQuery.of(context).size.width*0.15,)
//                           ],
//                         ),
//                         SizedBox(height: 5,),
//                         Row(
//                           children: [
//                             SizedBox(width: 10,),
//                             Text("22 Days Left",style: TextStyle(
//                                 color: Color(0xff515669),
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.w600
//                             ),),
//                           ],
//                         )
//                       ],

//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 10,),
//                 Container(
//                   width: MediaQuery.of(context).size.width*0.6,
//                   decoration: BoxDecoration(
//                       color: Color(0xff1a2030),
//                       borderRadius: BorderRadius.all(Radius.circular(40))
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Container(
//                         width: MediaQuery.of(context).size.width*0.6,
//                         height: 5,
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                               begin: Alignment.bottomLeft,
//                               end: Alignment.topRight,
//                               colors: [
//                                 Color(0xff16314a),
//                                 Color(0xff6043ba)
//                               ]
//                           ),
//                         ),
//                       ),
//                       Row(
//                         children: [
//                           SizedBox(width: 10,),
//                           Text("Ethereum", style: TextStyle(color: Colors.white, fontSize: 25),),
//                         ],
//                       ),
//                       SizedBox(height: 5,),
//                       Row(
//                         children: [
//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.baseline,
//                             textBaseline: TextBaseline.alphabetic,
//                             children: [
//                               SizedBox(width: 10,),
//                               Text("3", style: TextStyle(color: Colors.white, fontSize: 40,fontWeight: FontWeight.w600),),
//                               Text(".34", style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.w600),),
//                             ],
//                           ),
//                           Spacer(),
//                           Image.network(coinImageURL+"eth"+"@2x.png",width: MediaQuery.of(context).size.width*0.15,)
//                         ],
//                       ),
//                       SizedBox(height: 5,),
//                       Row(
//                         children: [
//                           SizedBox(width: 10,),
//                           Text("32 Days Left",style: TextStyle(
//                               color: Color(0xff515669),
//                               fontSize: 20,
//                               fontWeight: FontWeight.w600
//                           ),),
//                         ],
//                       )
//                     ],

//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: 20,),
//           Text("Recent transactions",
//             style: TextStyle(
//               fontSize: 30,
//               fontWeight: FontWeight.w600,
//               color: Color(0xff515669),

//             ),
//           ),
//           SizedBox(height: 10,),
//           Container(
//             width: width*0.9,
//             height: MediaQuery.of(context).size.height*0.43,
//             decoration: BoxDecoration(
//                 color: Color(0xff1a2030),
//                 borderRadius: BorderRadius.all(Radius.circular(40))
//             ),
//             child: ListView(
//               shrinkWrap: true,
//               children: [
//                 SizedBox(height: 20,),
//                 InkWell(
//                   highlightColor: Colors.transparent,
//                   splashColor: Colors.transparent,
//                   onTap: (){},
//                   child: Container(
//                     child: Row(
//                       children: [
//                         SizedBox(width: 10,),
//                         Image.network(coinImageURL+"eth"+"@2x.png",width: MediaQuery.of(context).size.width*0.1,),
//                         SizedBox(width: 20,),
//                         Text("Ethereum", style: TextStyle(color: Color(0xff515669), fontSize: 25),),
//                         Spacer(),
//                         Text("-0.3", style: TextStyle(color: Color(0xff515669), fontSize: 25),),
//                         SizedBox(width: 10,)
//                       ],
//                     ),
//                   ),
//                 ),
//                 Divider(height: 10,
//                   thickness: 3,
//                   indent: 70,
//                   color: Color(0xff515669),
//                 ),
//                 SizedBox(height: 15,),
//                 InkWell(
//                   highlightColor: Colors.transparent,
//                   splashColor: Colors.transparent,
//                   onTap: (){},
//                   child: Container(
//                     child: Row(
//                       children: [
//                         SizedBox(width: 10,),
//                         Image.network(coinImageURL+"eth"+"@2x.png",width: MediaQuery.of(context).size.width*0.1,),
//                         SizedBox(width: 20,),
//                         Text("Ethereum", style: TextStyle(color: Color(0xff515669), fontSize: 25),),
//                         Spacer(),
//                         Text("-0.3", style: TextStyle(color: Color(0xff515669), fontSize: 25),),
//                         SizedBox(width: 10,)
//                       ],
//                     ),
//                   ),
//                 ),
//                 Divider(height: 10,
//                   thickness: 3,
//                   indent: 70,
//                   color: Color(0xff515669),
//                 ),
//                 SizedBox(height: 15,),
//                 InkWell(
//                   highlightColor: Colors.transparent,
//                   splashColor: Colors.transparent,
//                   onTap: (){},
//                   child: Container(
//                     child: Row(
//                       children: [
//                         SizedBox(width: 10,),
//                         Image.network(coinImageURL+"eth"+"@2x.png",width: MediaQuery.of(context).size.width*0.1,),
//                         SizedBox(width: 20,),
//                         Text("Ethereum", style: TextStyle(color: Color(0xff515669), fontSize: 25),),
//                         Spacer(),
//                         Text("-0.3", style: TextStyle(color: Color(0xff515669), fontSize: 25),),
//                         SizedBox(width: 10,)
//                       ],
//                     ),
//                   ),
//                 ),
//                 Divider(height: 10,
//                   thickness: 3,
//                   indent: 70,
//                   color: Color(0xff515669),
//                 ),
//                 SizedBox(height: 15,),
//                 InkWell(
//                   highlightColor: Colors.transparent,
//                   splashColor: Colors.transparent,
//                   onTap: (){},
//                   child: Container(
//                     child: Row(
//                       children: [
//                         SizedBox(width: 10,),
//                         Image.network(coinImageURL+"eth"+"@2x.png",width: MediaQuery.of(context).size.width*0.1,),
//                         SizedBox(width: 20,),
//                         Text("Ethereum", style: TextStyle(color: Color(0xff515669), fontSize: 25),),
//                         Spacer(),
//                         Text("-0.3", style: TextStyle(color: Color(0xff515669), fontSize: 25),),
//                         SizedBox(width: 10,)
//                       ],
//                     ),
//                   ),
//                 ),
//                 Divider(height: 10,
//                   thickness: 3,
//                   indent: 70,
//                   color: Color(0xff515669),
//                 ),
//                 SizedBox(height: 15,),
//                 InkWell(
//                   highlightColor: Colors.transparent,
//                   splashColor: Colors.transparent,
//                   onTap: (){},
//                   child: Container(
//                     child: Row(
//                       children: [
//                         SizedBox(width: 10,),
//                         Image.network(coinImageURL+"eth"+"@2x.png",width: MediaQuery.of(context).size.width*0.1,),
//                         SizedBox(width: 20,),
//                         Text("Ethereum", style: TextStyle(color: Color(0xff515669), fontSize: 25),),
//                         Spacer(),
//                         Text("-0.3", style: TextStyle(color: Color(0xff515669), fontSize: 25),),
//                         SizedBox(width: 10,)
//                       ],
//                     ),
//                   ),
//                 ),
//                 Divider(height: 10,
//                   thickness: 3,
//                   indent: 70,
//                   color: Color(0xff515669),
//                 ),
//                 SizedBox(height: 15,),
//                 InkWell(
//                   highlightColor: Colors.transparent,
//                   splashColor: Colors.transparent,
//                   onTap: (){},
//                   child: Container(
//                     child: Row(
//                       children: [
//                         SizedBox(width: 10,),
//                         Image.network(coinImageURL+"eth"+"@2x.png",width: MediaQuery.of(context).size.width*0.1,),
//                         SizedBox(width: 20,),
//                         Text("Ethereum", style: TextStyle(color: Color(0xff515669), fontSize: 25),),
//                         Spacer(),
//                         Text("-0.3", style: TextStyle(color: Color(0xff515669), fontSize: 25),),
//                         SizedBox(width: 10,)
//                       ],
//                     ),
//                   ),
//                 ),
//                 Divider(height: 10,
//                   thickness: 3,
//                   indent: 70,
//                   color: Color(0xff515669),
//                 ),
//                 SizedBox(height: 15,),
//                 InkWell(
//                   highlightColor: Colors.transparent,
//                   splashColor: Colors.transparent,
//                   onTap: (){},
//                   child: Container(
//                     child: Row(
//                       children: [
//                         SizedBox(width: 10,),
//                         Image.network(coinImageURL+"eth"+"@2x.png",width: MediaQuery.of(context).size.width*0.1,),
//                         SizedBox(width: 20,),
//                         Text("Ethereum", style: TextStyle(color: Color(0xff515669), fontSize: 25),),
//                         Spacer(),
//                         Text("-0.3", style: TextStyle(color: Color(0xff515669), fontSize: 25),),
//                         SizedBox(width: 10,)
//                       ],
//                     ),
//                   ),
//                 ),
//                 Divider(height: 10,
//                   thickness: 3,
//                   indent: 70,
//                   color: Color(0xff515669),
//                 ),
//                 SizedBox(height: 15,),
//                 InkWell(
//                   highlightColor: Colors.transparent,
//                   splashColor: Colors.transparent,
//                   onTap: (){},
//                   child: Container(
//                     child: Row(
//                       children: [
//                         SizedBox(width: 10,),
//                         Image.network(coinImageURL+"eth"+"@2x.png",width: MediaQuery.of(context).size.width*0.1,),
//                         SizedBox(width: 20,),
//                         Text("Ethereum", style: TextStyle(color: Color(0xff515669), fontSize: 25),),
//                         Spacer(),
//                         Text("-0.3", style: TextStyle(color: Color(0xff515669), fontSize: 25),),
//                         SizedBox(width: 10,)
//                       ],
//                     ),
//                   ),
//                 ),
//                 Divider(height: 10,
//                   thickness: 3,
//                   indent: 70,
//                   color: Color(0xff515669),
//                 ),
//                 SizedBox(height: 15,),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget secondScreen() {
//     print(lstCryptoCoinDetail[0]);
//     graphHeight = height - appBarheight - 42;
//     return Container(
//       height: graphHeight,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.only(right: 16, left: 16),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 GestureDetector(
//                   onTap: () {
//                     _scaffoldKey.currentState!.openDrawer();
//                   },
//                   child: Icon(
//                     Icons.sort,
//                     color: AllCoustomTheme.getsecoundTextThemeColor(),
//                   ),
//                 ),
//                 Icon(
//                   Icons.more_horiz,
//                   color: AllCoustomTheme.getsecoundTextThemeColor(),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(
//             height: 30,
//           ),
//           Row(
//             children: <Widget>[
//               Animator<double>(
//                 tween: Tween<double>(begin: 0, end: 1),
//                 duration: Duration(milliseconds: 500),
//                 cycles: 1,
//                 builder: (_, anim, __) => SizeTransition(
//                   sizeFactor: anim.animation,
//                   axis: Axis.horizontal,
//                   axisAlignment: 1,
//                   child: Padding(
//                     padding: const EdgeInsets.only(left: 16),
//                     child: Text(
//                       'Live Stock',
//                       style: TextStyle(
//                         color: AllCoustomTheme.getTextThemeColors(),
//                         fontWeight: FontWeight.bold,
//                         fontSize: ConstanceData.SIZE_TITLE25,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 16),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 Expanded(
//                   child: Container(
//                     height: 30,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.all(Radius.circular(10)),
//                       color: AllCoustomTheme.boxColor(),
//                     ),
//                     child: TextFormField(
//                       style: TextStyle(
//                         fontSize: ConstanceData.SIZE_TITLE16,
//                         color: AllCoustomTheme.getTextThemeColors(),
//                       ),
//                       cursorColor: AllCoustomTheme.getTextThemeColors(),
//                       onChanged: (value) {
//                         filterSearchResults(value);
//                       },
//                       decoration: InputDecoration(
//                         hintText: 'Search',
//                         prefixIcon: Icon(
//                           Icons.search,
//                           size: 20,
//                           color: AllCoustomTheme.getsecoundTextThemeColor(),
//                         ),
//                         hintStyle: TextStyle(
//                           fontSize: ConstanceData.SIZE_TITLE16,
//                           color: AllCoustomTheme.getsecoundTextThemeColor(),
//                         ),
//                         border: InputBorder.none,
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   width: 4,
//                 ),
//                 Expanded(
//                   child: GestureDetector(
//                     onTap: () {
//                       _upDownMarketCap();
//                     },
//                     child: Container(
//                       height: 30,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.all(Radius.circular(10)),
//                         color: AllCoustomTheme.boxColor(),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.only(top: 6, bottom: 8, left: 8, right: 8),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: <Widget>[
//                             Text(
//                               'Market cap',
//                               style: TextStyle(
//                                 color: AllCoustomTheme.getTextThemeColors(),
//                               ),
//                             ),
//                             Animator<double>(
//                               tween: Tween<double>(begin: 0, end: 2 * pi),
//                               duration: Duration(milliseconds: 500),
//                               repeats: 1,
//                               builder: (_, anim, __) => Transform(
//                                 transform: Matrix4.skewX(anim.value),
//                                 child: InkWell(
//                                   onTap: () {},
//                                   child: Icon(
//                                     marketCapUpDown == Icons.arrow_upward ? Icons.arrow_upward : Icons.arrow_downward,
//                                     size: 18,
//                                     color: AllCoustomTheme.getTextThemeColors(),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(
//             height: 4,
//           ),
//           isLoading
//               ? Expanded(
//             child: SingleChildScrollView(
//               physics: NeverScrollableScrollPhysics(),
//               child: Shimmer.fromColors(
//                 baseColor: globals.buttoncolor1,
//                 highlightColor: globals.buttoncolor2,
//                 enabled: true,
//                 child: Padding(
//                   padding: const EdgeInsets.only(top: 26),
//                   child: Column(
//                     children: [1, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1]
//                         .map(
//                           (_) => Padding(
//                         padding: const EdgeInsets.only(left: 16, right: 16),
//                         child: Column(
//                           children: <Widget>[
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 CircleAvatar(
//                                   radius: 14,
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(horizontal: 8),
//                                 ),
//                                 Expanded(
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Container(
//                                         width: double.infinity,
//                                         height: 8.0,
//                                         color: Colors.white,
//                                       ),
//                                       Padding(
//                                         padding: const EdgeInsets.symmetric(vertical: 2.0),
//                                       ),
//                                       Container(
//                                         width: 40.0,
//                                         height: 8.0,
//                                         color: Colors.white,
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                           ],
//                         ),
//                       ),
//                     )
//                         .toList(),
//                   ),
//                 ),
//               ),
//             ),
//           )
//               : Expanded(
//             child: Padding(
//               padding: const EdgeInsets.only(left: 16, right: 16),
//               child: ListView.builder(
//                 physics: BouncingScrollPhysics(),
//                 itemCount: _isSearch ? _serchCoinList.length : lstCryptoCoinDetail.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   var coinData = _isSearch ? _serchCoinList[index] : lstCryptoCoinDetail[index];
//                   // ignore: unused_local_variable
//                   var coinId = coinData.id.toString();
//                   var coinSymbol = coinData.symbol.toString();
//                   var coinName = coinData.name.toString();
//                   var price = coinData.quote!.uSD!.price.toString();
//                   var percentchange1h = coinData.quote!.uSD!.percentChange1h.toString();
//                   var marketCap = coinData.quote!.uSD!.marketCap.toString();
//                   var volume = coinData.quote!.uSD!.volume24h.toString();
//                   var availableSupply = coinData.totalSupply.toString();
//                   var changein24HR = coinData.quote!.uSD!.percentChange24h.toString();
//                   return InkWell(
//                     highlightColor: Colors.transparent,
//                     splashColor: Colors.transparent,
//                     onTap: () {
//                       showCupertinoModalPopup<void>(
//                         context: context,
//                         builder: (BuildContext context) {
//                           return Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.only(
//                                 topLeft: Radius.circular(20),
//                                 topRight: Radius.circular(20),
//                               ),
//                               gradient: LinearGradient(
//                                 begin: Alignment.topLeft,
//                                 end: Alignment.bottomRight,
//                                 colors: [
//                                   globals.buttoncolor1,
//                                   globals.buttoncolor2,
//                                 ],
//                               ),
//                             ),
//                             height: height - appBarheight - 42,
//                             child: Scaffold(
//                               backgroundColor: Colors.transparent,
//                               body: SliderOpen(
//                                 coinSymbol: coinSymbol,
//                                 coinName: coinName,
//                                 coinId: "",
//                                 // price: price,
//                                 // percentchange1h: percentchange1h,
//                                 // marketCap: marketCap,
//                                 // volume: volume,
//                                 // availableSupply: availableSupply,
//                                 // changein24HR: changein24HR,
//                               ),
//                             ),
//                           );
//                         },
//                       );
//                     },
//                     child: Column(
//                       children: <Widget>[
//                         Row(
//                           children: <Widget>[
//                             Container(
//                               height: 30,
//                               width: 30,
//                               child: CachedNetworkImage(
//                                 errorWidget: (context, url, error) => CircleAvatar(
//                                   backgroundColor: AllCoustomTheme.getsecoundTextThemeColor(),
//                                   child: Text(
//                                     coinSymbol.substring(0, 1),
//                                   ),
//                                 ),
//                                 imageUrl: coinImageURL + coinSymbol.toLowerCase() + "@2x.png",
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                             SizedBox(
//                               width: 16,
//                             ),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: <Widget>[
//                                 Text(
//                                   coinName,
//                                   style: TextStyle(
//                                     color: AllCoustomTheme.getTextThemeColors(),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: 4,
//                                 ),
//                                 Text(
//                                   coinSymbol,
//                                   style: TextStyle(
//                                     color: AllCoustomTheme.getsecoundTextThemeColor(),
//                                     fontSize: ConstanceData.SIZE_TITLE12,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Expanded(child: Container()),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.end,
//                               children: <Widget>[
//                                 Text(
//                                   ' \$ ' + double.parse(price).toStringAsFixed(2),
//                                   style: TextStyle(
//                                     color: AllCoustomTheme.getTextThemeColors(),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: 4,
//                                 ),
//                                 Text(
//                                   percentchange1h.contains('-') ? '' + percentchange1h + '%' : '+' + percentchange1h + '%',
//                                   style: TextStyle(
//                                     color: percentchange1h.contains('-') ? Colors.red : Colors.green,
//                                     fontSize: ConstanceData.SIZE_TITLE12,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                         Divider(
//                           color: AllCoustomTheme.getsecoundTextThemeColor(),
//                         )
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   Widget thirdScreen() {
//     return Column(
//       children: [
//         SingleChildScrollView(
//           padding: EdgeInsets.only(top: 8),
//           physics: BouncingScrollPhysics(),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: <Widget>[
//               SizedBox(
//                 height: 10,
//               ),
//               Row(
//                 children: <Widget>[
//                   Animator<double>(
//                     tween: Tween<double>(begin: 0, end: 1),
//                     duration: Duration(milliseconds: 500),
//                     cycles: 1,
//                     builder: (_, anim, __) => SizeTransition(
//                       sizeFactor: anim.animation,
//                       axis: Axis.horizontal,
//                       axisAlignment: 1,
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 16),
//                         child: Padding(
//                           padding: const EdgeInsets.only(left: 16),
//                           child: Text(
//                             'Settings',
//                             style: TextStyle(
//                               color: AllCoustomTheme.getTextThemeColors(),
//                               fontWeight: FontWeight.bold,
//                               fontSize: ConstanceData.SIZE_TITLE25,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 16, right: 16),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: <Widget>[
//                       Row(
//                         children: <Widget>[
//                           Text(
//                             'Account',
//                             style: TextStyle(
//                               color: AllCoustomTheme.getsecoundTextThemeColor(),
//                               fontSize: ConstanceData.SIZE_TITLE16,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 16,
//                       ),
//                       InkWell(
//                         highlightColor: Colors.transparent,
//                         splashColor: Colors.transparent,
//                         onTap: () {
//                           Navigator.of(context).push(
//                             CupertinoPageRoute(
//                               builder: (BuildContext context) => UserProfile(),
//                             ),
//                           );
//                         },
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: <Widget>[
//                             Text(
//                               'User Profile',
//                               style: TextStyle(
//                                 color: AllCoustomTheme.getTextThemeColors(),
//                               ),
//                             ),
//                             AnimatedForwardArrow(
//                               isShowingarroeForward: true,
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(
//                         height: 8,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 8),
//                         child: AnimatedDivider(),
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       InkWell(
//                         highlightColor: Colors.transparent,
//                         splashColor: Colors.transparent,
//                         onTap: () async{
//                           try {
//                             var user = await Amplify.Auth.getCurrentUser();
//                             var username = user.username;
//                             globals.posts = await Amplify.DataStore.query(
//                               Transaction.classType,
//                               where: Transaction.USERNAME.eq(username),
//                             );
//                           } on DataStoreException catch (e) {
//                             print('Query failed: $e');
//                           }
//                           for(var i in posts){
//                             print(i.transactionId);
//                           }

//                           Navigator.of(context).push(
//                             CupertinoPageRoute(
//                               builder: (BuildContext context) => TransactionHistory(),
//                             ),
//                           );
//                         },
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: <Widget>[
//                             Text(
//                               'Transaction History',
//                               style: TextStyle(
//                                 color: AllCoustomTheme.getTextThemeColors(),
//                               ),
//                             ),
//                             AnimatedForwardArrow(
//                               isShowingarroeForward: true,
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(
//                         height: 8,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 8),
//                         child: AnimatedDivider(),
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       InkWell(
//                         highlightColor: Colors.transparent,
//                         splashColor: Colors.transparent,
//                         onTap: () {
//                           Navigator.of(context).push(
//                             CupertinoPageRoute(
//                               builder: (BuildContext context) => ChangePassword(),
//                             ),
//                           );
//                         },
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: <Widget>[
//                             Text(
//                               'Change Password',
//                               style: TextStyle(
//                                 color: AllCoustomTheme.getTextThemeColors(),
//                               ),
//                             ),
//                             AnimatedForwardArrow(
//                               isShowingarroeForward: true,
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(
//                         height: 8,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 4),
//                         child: AnimatedDivider(),
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       InkWell(
//                         highlightColor: Colors.transparent,
//                         splashColor: Colors.transparent,
//                         onTap: () async{
//                           try {
//                             await Amplify.Auth.signOut();
//                             Amplify.DataStore.clear();
//                             Navigator.pushNamedAndRemoveUntil(context, Routes.SignIn, (route) => false);
//                           } on AuthException catch (e) {
//                             print(e.message);
//                           }
//                         },
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: <Widget>[
//                             Text(
//                               'Log Out',
//                               style: TextStyle(
//                                 color: AllCoustomTheme.getTextThemeColors(),
//                               ),
//                             ),
//                             AnimatedForwardArrow(
//                               isShowingarroeForward: true,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   _upDownMarketCap() {
//     isLoadingList();
//     if (marketCapUpDown == Icons.arrow_upward) {
//       setState(() {
//         marketCapUpDown = Icons.arrow_downward;
//         marketListData.sort((a, b) => a.quote.uSD.marketCap.compareTo(b.quote.uSD.marketCap));
//       });
//     } else {
//       setState(() {
//         marketCapUpDown = Icons.arrow_upward;
//         marketListData.sort((a, b) => b.quote.uSD.marketCap.compareTo(a.quote.uSD.marketCap));
//       });
//     }
//   }

//   void filterSearchResults(String query) {
//     isLoadingList();
//     _serchCoinList.clear();
//     if (query != "") {
//       marketListData.forEach((coin) {
//         if (coin.symbol.toString().contains(query) ||
//             coin.symbol.toString().toLowerCase().contains(query) ||
//             coin.symbol.toString().toUpperCase().contains(query) ||
//             coin.name.toString().contains(query) ||
//             coin.name.toString().toLowerCase().contains(query) ||
//             coin.name.toString().toUpperCase().contains(query)) {
//           _serchCoinList.add(coin);
//         }
//       });
//       setState(() {
//         _isSearch = true;
//       });
//     } else {
//       setState(() {
//         _isSearch = false;
//       });
//     }
//   }

//   selectFirst() async {
//     if (!isSelect1) {
//       var connectivityResult = await (Connectivity().checkConnectivity());
//       if (connectivityResult != ConnectivityResult.none) {
//         setFirstTab();
//         callItself();
//       }
//       setState(() {
//         isSelect1 = true;
//         isSelect2 = false;
//         isSelect3 = false;
//       });
//     }
//   }

//   selectSecond() async {
//     if (!isSelect2) {
//       setState(() {
//         isSelect1 = false;
//         isSelect2 = true;
//         isSelect3 = false;
//       });
//       var connectivityResult = await (Connectivity().checkConnectivity());
//       if (connectivityResult != ConnectivityResult.none) {
//         isLoadingList();
//       }
//     }
//   }

//   selectThird() {
//     if (!isSelect3) {
//       setState(() {
//         isSelect1 = false;
//         isSelect2 = false;
//         isSelect3 = true;
//       });
//     }
//   }

//   List sampleData = [
//     {"open": 50.0, "high": 100.0, "low": 40.0, "close": 80, "volumeto": 5000.0},
//     {"open": 80.0, "high": 90.0, "low": 55.0, "close": 65, "volumeto": 4000.0},
//     {"open": 65.0, "high": 120.0, "low": 60.0, "close": 90, "volumeto": 7000.0},
//     {"open": 90.0, "high": 95.0, "low": 85.0, "close": 80, "volumeto": 2000.0},
//     {"open": 80.0, "high": 85.0, "low": 40.0, "close": 50, "volumeto": 3000.0},
//   ];
// }
