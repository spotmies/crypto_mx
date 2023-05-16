import 'dart:convert';

import 'package:cryptomarket/constance/themes.dart';
import 'package:cryptomarket/repo/api_methods.dart';
import 'package:cryptomarket/repo/api_urls.dart';
import 'package:flutter/material.dart';

class History extends StatefulWidget {
  final dynamic id;
  final dynamic depo;
  const History({Key? key, this.id, this.depo}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  void initState() {
    super.initState();
    getCoinsDetails();

    // getCurrentUser();
  }

  dynamic withdraw;
  getCoinsDetails() async {
    // var user = await getUserData();
    var prm = {
      "api_secret": "oApF8z0hmu",
      // "user_id": user["user"]["id"],
      "user_id": 1.toString(),
      // "staking_id": widget.id
      "staking_id": 1.toString()
    };
    dynamic res = await Server().getMethodParems(API.withdrawList, prm);
    if (res.statusCode == 200) {
      setState(() {
        withdraw = jsonDecode(res.body);
      });
      print('$withdraw');
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // var height = size.height;
    var width = size.width;
    if (withdraw == null) {
      return Scaffold(
        backgroundColor: AllCoustomTheme.getThemeData().backgroundColor,
        body: Center(
          child: Text(
            "No transactions are found",
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Recent transactions"),
      ),
      backgroundColor: AllCoustomTheme.getThemeData().backgroundColor,
      body: ListView.builder(
          itemCount: withdraw["data"].length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {},
                  child: Container(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Image.network(
                          withdraw["data"][index]["coin_image"],
                          // coinImageURL + "eth" + "@2x.png",
                          width: MediaQuery.of(context).size.width * 0.1,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          children: [
                            Text(
                              withdraw["data"][index]["coin_name"],
                              style: TextStyle(
                                  color: Color(0xff515669),
                                  fontSize: width * 0.07),
                            ),
                            Text(
                              withdraw["data"][index]["created_at"],
                              style: TextStyle(
                                  color: Color(0xff515669),
                                  fontSize: width * 0.022),
                            ),
                          ],
                        ),
                        Spacer(),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              withdraw["data"][index]["amount"].toString() +
                                  withdraw["data"][index]["coin_ticker"]
                                      .toString(),
                              style: TextStyle(
                                  color: Color(0xff515669),
                                  fontSize: width * 0.07),
                            ),
                            Text(
                              "Deposit amount:" + widget.depo.toString(),
                              style: TextStyle(
                                  color: Color(0xff515669),
                                  fontSize: width * 0.022),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 10,
                        )
                      ],
                    ),
                  ),
                ),
                Divider(
                  height: 10,
                  thickness: 3,
                  indent: 70,
                  color: color(withdraw["data"][index]["status"]),
                ),
                SizedBox(
                  height: 15,
                )
              ],
            );
          }),
    );
  }
}

color(status) {
  switch (status) {
    case "rejected":
      return Colors.red;
    case "pending":
      return Color(0xff515669);
    case "approved":
      return Colors.green;

    default:
      return Colors.green;
  }
}
