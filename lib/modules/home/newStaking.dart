// ignore_for_file: unused_field

import 'dart:convert';
import 'dart:math';

import 'package:animator/animator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cryptomarket/constance/constance.dart';
import 'package:cryptomarket/constance/themes.dart';
import 'package:cryptomarket/main.dart';
import 'package:cryptomarket/model/listingsModel.dart';
import 'package:cryptomarket/constance/global.dart' as globals;
import 'package:cryptomarket/modules/drawer/drawer.dart';
import 'package:cryptomarket/modules/underGroundSlider/cryptoCoinDetailSlider.dart';
import 'package:cryptomarket/repo/api_methods.dart';
import 'package:cryptomarket/repo/api_urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class NewStaking extends StatefulWidget {
  const NewStaking({Key? key}) : super(key: key);

  @override
  State<NewStaking> createState() => _NewStakingState();
}

class _NewStakingState extends State<NewStaking> {
  dynamic coinsList;
  var width = 0.0;
  var height = 0.0;
  var appBarheight = 0.0;
  var statusBarHeight = 0.0;
  var graphHeight = 0.0;
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _isSearch = false;
  bool isLoading = false;
  List<CryptoCoinDetail> _serchCoinList = [];

  @override
  void initState() {
    super.initState();
    getCoinsList();

    // getCurrentUser();
  }

  getCoinsList() async {
    var prm = {"api_secret": "oApF8z0hmu"};
    // dynamic loc = await getUserData();
    // print("qwertyuiop" + loc.toString());
    dynamic res = await Server().getMethodParems(API.listCoins, prm);
    if (res.statusCode == 200) {
      setState(() {
        coinsList = jsonDecode(res.body);
      });
      print('$coinsList');
    }
  }

  isLoadingList() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      isLoading = false;
    });
  }

  void filterSearchResults(String query) {
    isLoadingList();
    _serchCoinList.clear();
    if (query != "") {
      marketListData.forEach((coin) {
        if (coin.symbol.toString().contains(query) ||
            coin.symbol.toString().toLowerCase().contains(query) ||
            coin.symbol.toString().toUpperCase().contains(query) ||
            coin.name.toString().contains(query) ||
            coin.name.toString().toLowerCase().contains(query) ||
            coin.name.toString().toUpperCase().contains(query)) {
          _serchCoinList.add(coin);
        }
      });
      setState(() {
        _isSearch = true;
      });
    } else {
      setState(() {
        _isSearch = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // graphHeight = height - appBarheight - 42;
    dynamic hgt = MediaQuery.of(context).size.height;
    dynamic wdt = MediaQuery.of(context).size.width;
    if (coinsList == null) {
      return Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      );
    }

    return Scaffold(
      backgroundColor: AllCoustomTheme.getThemeData().backgroundColor,
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_horiz,
              color: AllCoustomTheme.getsecoundTextThemeColor(),
            ),
          ),
        ],
      ),
      drawer: SizedBox(
        width: MediaQuery.of(context).size.width * 0.75 < 400
            ? MediaQuery.of(context).size.width * 0.75
            : 350,
        child: Drawer(
          
          elevation: 0,
          child: AppDrawer(
            selectItemName: 'Wallet',
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          height: hgt,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              // Padding(
              //   padding: const EdgeInsets.only(right: 16, left: 16),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: <Widget>[
              //       InkWell(
              //         onTap: () async {
              //           _scaffoldKey.currentState?.openDrawer();
              //         },
              //         child: Icon(
              //           Icons.sort,
              //           color: AllCoustomTheme.getsecoundTextThemeColor(),
              //         ),
              //       ),
              //       Icon(
              //         Icons.more_horiz,
              //         color: AllCoustomTheme.getsecoundTextThemeColor(),
              //       ),
              //     ],
              //   ),
              // ),
              SizedBox(
                height: 30,
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
                        child: Text(
                          'Live Stock',
                          style: TextStyle(
                            color: AllCoustomTheme.getTextThemeColors(),
                            fontWeight: FontWeight.bold,
                            fontSize: ConstanceData.SIZE_TITLE25,
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
                padding: const EdgeInsets.only(left: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        height: hgt * 0.039,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: AllCoustomTheme.boxColor(),
                        ),
                        child: TextFormField(
                          style: TextStyle(
                            fontSize: ConstanceData.SIZE_TITLE16,
                            color: AllCoustomTheme.getTextThemeColors(),
                          ),
                          cursorColor: AllCoustomTheme.getTextThemeColors(),
                          onChanged: (value) {
                            // filterSearchResults(value);
                          },
                          decoration: InputDecoration(
                            hintText: 'Search',
                            prefixIcon: Icon(
                              Icons.search,
                              size: 20,
                              color: AllCoustomTheme.getsecoundTextThemeColor(),
                            ),
                            hintStyle: TextStyle(
                              fontSize: wdt * 0.04,
                              color: AllCoustomTheme.getsecoundTextThemeColor(),
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          // _upDownMarketCap();
                        },
                        child: Container(
                          height: hgt * 0.039,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: AllCoustomTheme.boxColor(),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: wdt * 0.015,
                                bottom: wdt * 0.02,
                                left: wdt * 0.02,
                                right: wdt * 0.015),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Market cap',
                                  style: TextStyle(
                                    fontSize: wdt * 0.04,
                                    color: AllCoustomTheme.getTextThemeColors(),
                                  ),
                                ),
                                Animator<double>(
                                  tween: Tween<double>(begin: 0, end: 2 * pi),
                                  duration: Duration(milliseconds: 500),
                                  repeats: 1,
                                  builder: (_, anim, __) => Transform(
                                    transform: Matrix4.skewX(anim.value),
                                    child: InkWell(
                                      onTap: () {},
                                      child: Icon(
                                        // marketCapUpDown == Icons.arrow_upward
                                        //     ? Icons.arrow_upward
                                        // :
                                        Icons.arrow_downward,
                                        size: 18,
                                        color: AllCoustomTheme
                                            .getTextThemeColors(),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 4,
              ),
              isLoading
                  ? Expanded(
                      child: SingleChildScrollView(
                        physics: NeverScrollableScrollPhysics(),
                        child: Shimmer.fromColors(
                          baseColor: globals.buttoncolor1,
                          highlightColor: globals.buttoncolor2,
                          enabled: true,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 26),
                            child: Column(
                              children: [
                                1,
                                1,
                                2,
                                1,
                                1,
                                1,
                                1,
                                1,
                                1,
                                1,
                                1,
                                1,
                                2,
                                1,
                                1,
                                1,
                                1,
                                1,
                                1,
                                1
                              ]
                                  .map(
                                    (_) => Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16, right: 16),
                                      child: Column(
                                        children: <Widget>[
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CircleAvatar(
                                                radius: 14,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: double.infinity,
                                                      height: 8.0,
                                                      color: Colors.white,
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 2.0),
                                                    ),
                                                    Container(
                                                      width: 40.0,
                                                      height: 8.0,
                                                      color: Colors.white,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ),
                      ),
                    )
                  : Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: coinsList["data"].length,
                          // _isSearch
                          //     ? _serchCoinList.length
                          //     : lstCryptoCoinDetail.length,
                          itemBuilder: (BuildContext context, int index) {
                            // var coinData = _isSearch
                            //     ? _serchCoinList[index]
                            //     : lstCryptoCoinDetail[index];
                            // // ignore: unused_local_variable
                            // var coinId = coinData.id.toString();
                            // var coinSymbol = coinData.symbol.toString();
                            // var coinName = coinData.name.toString();
                            // var price = coinData.quote!.uSD!.price.toString();
                            // var percentchange1h =
                            //     coinData.quote!.uSD!.percentChange1h.toString();
                            // var marketCap =
                            //     coinData.quote!.uSD!.marketCap.toString();
                            // var volume = coinData.quote!.uSD!.volume24h.toString();
                            // var availableSupply = coinData.totalSupply.toString();
                            // var changein24HR =
                            //     coinData.quote!.uSD!.percentChange24h.toString();
                            return InkWell(
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              onTap: () {
                                showCupertinoModalPopup<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20),
                                        ),
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            globals.buttoncolor1,
                                            globals.buttoncolor2,
                                          ],
                                        ),
                                      ),
                                      // height: height - appBarheight - 42,
                                      height: hgt * 0.26,
                                      child: Scaffold(
                                        backgroundColor: Colors.transparent,
                                        body: SliderOpen(
                                            coinSymbol: coinsList["data"][index]
                                                ['coin_image'],
                                            coinName: coinsList["data"][index]
                                                ['coin_name'],
                                            coinId: coinsList["data"][index]
                                                    ['coin_id']
                                                .toString(),
                                            price: coinsList["data"][index]
                                                    ["live_price"]
                                                .toString()
                                            // percentchange1h: "percentchange1h",
                                            // marketCap: "marketCap",
                                            // volume: "volume",
                                            // availableSupply: "availableSupply",
                                            // changein24HR: "changein24HR",
                                            ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        height: 30,
                                        width: 30,
                                        child: CachedNetworkImage(
                                          errorWidget: (context, url, error) =>
                                              CircleAvatar(
                                            backgroundColor: AllCoustomTheme
                                                .getsecoundTextThemeColor(),
                                            child: Text(
                                              globals.coinSymbol
                                                  .substring(0, 1),
                                            ),
                                          ),
                                          imageUrl: coinsList["data"][index]
                                              ['coin_image'],
                                          // coinImageURL +
                                          //     coinSymbol.toLowerCase() +
                                          //     "@2x.png",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 16,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            coinsList["data"][index]
                                                ['coin_name'],
                                            style: TextStyle(
                                              color: AllCoustomTheme
                                                  .getTextThemeColors(),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            coinsList["data"][index]
                                                ['coin_ticker'],
                                            style: TextStyle(
                                              color: AllCoustomTheme
                                                  .getsecoundTextThemeColor(),
                                              fontSize:
                                                  ConstanceData.SIZE_TITLE12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Expanded(child: Container()),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Text(
                                            ' \$ ' +
                                                double.parse(coinsList["data"]
                                                                [index]
                                                            ["live_price"]
                                                        .toString())
                                                    .toString(),
                                            style: TextStyle(
                                              color: AllCoustomTheme
                                                  .getTextThemeColors(),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          // Text(
                                          //   percentchange1h.contains('-')
                                          //       ? '' + percentchange1h + '%'
                                          //       : '+' + percentchange1h + '%',
                                          //   style: TextStyle(
                                          //     color: percentchange1h.contains('-')
                                          //         ? Colors.red
                                          //         : Colors.green,
                                          //     fontSize: ConstanceData.SIZE_TITLE12,
                                          //     fontWeight: FontWeight.bold,
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    color: AllCoustomTheme
                                        .getsecoundTextThemeColor(),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
