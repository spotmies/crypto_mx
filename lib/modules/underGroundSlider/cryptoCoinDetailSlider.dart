// ignore_for_file: deprecated_member_use, unused_element

import 'dart:convert';
import 'dart:developer';

import 'package:animator/animator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cryptomarket/constance/constance.dart';
import 'package:cryptomarket/constance/global.dart';
import 'package:cryptomarket/constance/themes.dart';
import 'package:cryptomarket/repo/api_methods.dart';
import 'package:cryptomarket/repo/api_urls.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cryptomarket/constance/global.dart' as globals;
import '../home/transaction.dart';
import '../../constance/routes.dart';

class SliderOpen extends StatefulWidget {
  final String coinSymbol;
  final String coinName;
  final String coinId;
  // final String percentchange1h;
  // final String marketCap;
  // final String volume;
  // final String availableSupply;
  // final String changein24HR;
  const SliderOpen({
    key,
    required this.coinSymbol,
    required this.coinName,
    required this.coinId,
    // required this.percentchange1h,
    // required this.marketCap,
    // required this.volume,
    // required this.availableSupply,
    // required this.changein24HR
  }) : super(key: key);
  @override
  _SliderOpenState createState() => _SliderOpenState();
}

class _SliderOpenState extends State<SliderOpen> {
  bool isLoadingSliderDetail = false;

  @override
  void initState() {
    super.initState();
    loadingSliderDetail();
  }

  loadingSliderDetail() async {
    setState(() {
      isLoadingSliderDetail = true;
    });
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      isLoadingSliderDetail = false;
    });
  }

  var isStaked = false;
  @override
  Widget build(BuildContext context) {
    return isStaked
        ? DialogBox()
        : SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Animator<Offset>(
                        tween: Tween<Offset>(
                          begin: Offset(0, -0.2),
                          end: Offset(0, 0),
                        ),
                        duration: Duration(milliseconds: 500),
                        cycles: 0,
                        builder: (_, anim, __) => FractionalTranslation(
                          translation: anim.value,
                          child: InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              FontAwesomeIcons.angleDown,
                              color: AllCoustomTheme.getTextThemeColors(),
                              size: 35,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: <Widget>[
                      Animator<double>(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.decelerate,
                        cycles: 1,
                        builder: (_, anim, __) => Transform.scale(
                          scale: anim.value,
                          child: Container(
                            height: 50,
                            width: 50,
                            child: CachedNetworkImage(
                              errorWidget: (context, url, error) =>
                                  CircleAvatar(
                                backgroundColor:
                                    AllCoustomTheme.getsecoundTextThemeColor(),
                                child: Text(
                                  widget.coinSymbol.substring(0, 1),
                                ),
                              ),
                              imageUrl: widget.coinSymbol,
                              // coinImageURL +
                              //     widget.coinSymbol.toLowerCase() +
                              //     "@2x.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
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
                          child: Text(
                            widget.coinName,
                            style: TextStyle(
                              color: AllCoustomTheme.getTextThemeColors(),
                              fontSize: ConstanceData.SIZE_TITLE25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2,
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
                          child: Text(
                            '\$' + "3.254",
                            // double.parse(widget.price).toStringAsFixed(2),
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: ConstanceData.SIZE_TITLE16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                          child: Animator<double>(
                        duration: Duration(milliseconds: 500),
                        tween: Tween<double>(begin: 0.5, end: 1),
                        curve: Curves.fastOutSlowIn,
                        cycles: 0,
                        builder: (_, anim, __) => Transform.scale(
                          scale: anim.value,
                          child: FlatButton(
                            padding: EdgeInsets.all(0),
                            child: new Container(
                              height: 40.0,
                              alignment: FractionalOffset.center,
                              decoration: BoxDecoration(
                                borderRadius: new BorderRadius.circular(30),
                                color: Colors.green,
                              ),
                              child: Text(
                                'Stake',
                                style: TextStyle(
                                  fontFamily: 'Ubuntu',
                                  color: AllCoustomTheme.getTextThemeColors(),
                                ),
                              ),
                            ),
                            onPressed: () async {
                              var prm = {"api_secret": "oApF8z0hmu"};
                              dynamic plans = await Server()
                                  .getMethodParems(API.plansList, prm);
                              dynamic plItems = jsonDecode(plans.body);
                              log(plItems["data"].toString());
                              // if (plans.statusCode == 200) {
                              //   log(plans.body.toString());
                              //   return jsonDecode(plans.body);
                              // }

                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(40)),
                                    elevation: 16,
                                    child: Container(
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: plItems["data"].length,
                                        itemBuilder: (context, index) {
                                          return _buildRow(
                                              int.parse(
                                                plItems["data"][index]
                                                        ["min_days"]
                                                    .toString(),
                                              ),
                                              double.parse(plItems["data"]
                                                      [index]["daily_returns"]
                                                  .toString()),
                                              widget.coinId,
                                              plItems["data"][index]);
                                        },
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      )),
                      SizedBox(
                        width: 120,
                      ),
                      Expanded(
                        child: FlatButton(
                          padding: EdgeInsets.all(0),
                          child: new Container(
                            height: 40.0,
                            alignment: FractionalOffset.center,
                            decoration: BoxDecoration(
                              borderRadius: new BorderRadius.circular(30),
                              color: Colors.green,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Animator<Offset>(
                                  tween: Tween<Offset>(
                                    begin: Offset(0, -0.2),
                                    end: Offset(0, 0),
                                  ),
                                  duration: Duration(milliseconds: 500),
                                  cycles: 0,
                                  builder: (_, anim, __) =>
                                      FractionalTranslation(
                                    translation: anim.value,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 2),
                                      child:
                                          // widget.percentchange1h.contains('-')
                                          //     ? Icon(
                                          //         Icons.arrow_downward,
                                          //         color: AllCoustomTheme
                                          //             .getTextThemeColors(),
                                          //         size: 18,
                                          //       )
                                          //     :
                                          Icon(
                                        Icons.arrow_upward,
                                        color: AllCoustomTheme
                                            .getTextThemeColors(),
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  // double.parse(widget.percentchange1h)
                                  //         .toStringAsFixed(2) +
                                  //     '%',
                                  "1.5 %",
                                  style: TextStyle(
                                    fontFamily: 'Ubuntu',
                                    color: AllCoustomTheme.getTextThemeColors(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Today',
                        style: TextStyle(
                          fontFamily: 'Ubuntu',
                          color: AllCoustomTheme.getTextThemeColors(),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '1W',
                        style: TextStyle(
                          fontFamily: 'Ubuntu',
                          color: AllCoustomTheme.getTextThemeColors(),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        height: 25.0,
                        width: 40,
                        alignment: FractionalOffset.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: AllCoustomTheme.getsecoundTextThemeColor(),
                        ),
                        child: Text(
                          '1M',
                          style: TextStyle(
                            fontFamily: 'Ubuntu',
                            color: AllCoustomTheme.getTextThemeColors(),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        '2M',
                        style: TextStyle(
                          fontFamily: 'Ubuntu',
                          color: AllCoustomTheme.getTextThemeColors(),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '6M',
                        style: TextStyle(
                          fontFamily: 'Ubuntu',
                          color: AllCoustomTheme.getTextThemeColors(),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '1Y',
                        style: TextStyle(
                          fontFamily: 'Ubuntu',
                          color: AllCoustomTheme.getTextThemeColors(),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'ALL',
                        style: TextStyle(
                          fontFamily: 'Ubuntu',
                          color: AllCoustomTheme.getTextThemeColors(),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  isLoadingSliderDetail
                      ? Shimmer.fromColors(
                          baseColor: globals.buttoncolor1,
                          highlightColor: globals.buttoncolor2,
                          enabled: true,
                          child: Column(
                            children: [1, 1, 1, 1]
                                .map(
                                  (_) => Padding(
                                    padding: const EdgeInsets.only(
                                        left: 4, right: 4),
                                    child: Column(
                                      children: <Widget>[
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
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
                                          height: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        )
                      : Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Market Cap',
                                  style: TextStyle(
                                    color: AllCoustomTheme.getTextThemeColors(),
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Ubuntu',
                                  ),
                                ),
                                Text(
                                  '\$' + "90",
                                  // double.parse(widget.marketCap)
                                  //     .toStringAsFixed(2),
                                  style: TextStyle(
                                    fontFamily: 'Ubuntu',
                                    color: AllCoustomTheme.getTextThemeColors(),
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Divider(
                              color: AllCoustomTheme.getTextThemeColors(),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Volume 24hr',
                                  style: TextStyle(
                                    fontFamily: 'Ubuntu',
                                    color: AllCoustomTheme.getTextThemeColors(),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '\$' + "90",
                                  // double.parse(widget.volume).toStringAsFixed(2),
                                  style: TextStyle(
                                    fontFamily: 'Ubuntu',
                                    color: AllCoustomTheme.getTextThemeColors(),
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Divider(
                              color: AllCoustomTheme.getTextThemeColors(),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Available Supply',
                                  style: TextStyle(
                                    fontFamily: 'Ubuntu',
                                    color: AllCoustomTheme.getTextThemeColors(),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '\$' + "90",
                                  // double.parse(widget.availableSupply)
                                  //     .toStringAsFixed(2),
                                  style: TextStyle(
                                    fontFamily: 'Ubuntu',
                                    color: AllCoustomTheme.getTextThemeColors(),
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Divider(
                              color: AllCoustomTheme.getTextThemeColors(),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  '% Change 24hr',
                                  style: TextStyle(
                                    fontFamily: 'Ubuntu',
                                    color: AllCoustomTheme.getTextThemeColors(),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                // Text(
                                //   widget.changein24HR.contains('-')
                                //       ? '' +
                                //           double.parse(widget.changein24HR)
                                //               .toStringAsFixed(2) +
                                //           '%'
                                //       : '+' +
                                //           double.parse(widget.changein24HR)
                                //               .toStringAsFixed(2) +
                                //           '%',
                                //   style: TextStyle(
                                //     fontFamily: 'Ubuntu',
                                //     color: widget.changein24HR.contains('-')
                                //         ? Colors.red
                                //         : Colors.green,
                                //     fontWeight: FontWeight.bold,
                                //   ),
                                // ),
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Divider(
                              color: AllCoustomTheme.getsecoundTextThemeColor(),
                            ),
                          ],
                        ),
                ],
              ),
            ),
          );
  }

  Widget _buildRow(int name, double score, String coinId, plItem) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 12),
            Container(height: 2, color: Colors.blueAccent),
            SizedBox(height: 12),
            TextButton(
              onPressed: () {
                coinName = widget.coinName;
                percentage = score;
                daysToHold = name;
                coinSymbol = widget.coinSymbol;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TransactionPage(
                            coinId: coinId, planDetails: plItem)));
              },
              child: Row(
                children: <Widget>[
                  Text(name == 365 ? '1 Year' : name.toString() + " Days"),
                  Spacer(),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.blue[900],
                        borderRadius: BorderRadius.circular(20)),
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    child: Text(
                      '$score%',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

class DialogBox extends StatefulWidget {
  const DialogBox({Key? key}) : super(key: key);

  @override
  _DialogBoxState createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
                elevation: 16,
                child: Container(
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      SizedBox(height: 20),
                      Center(child: Text('Leaderboard')),
                      SizedBox(height: 20),
                      _buildRow('45 Days', 1),
                      _buildRow('60 Days', 1.5),
                      _buildRow('90 Days', 2),
                      _buildRow('1 Year', 3),
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: Text('Show dialog'),
      ),
    );
  }

  Widget _buildRow(String name, double score) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 12),
            Container(height: 2, color: Colors.blueAccent),
            SizedBox(height: 12),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.Transact);
              },
              child: Row(
                children: <Widget>[
                  Text(name),
                  Spacer(),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.blue[900],
                        borderRadius: BorderRadius.circular(20)),
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    child: Text('$score%'),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

class transact extends StatelessWidget {
  const transact({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/transact.png')),
      ),
    );
  }
}
