import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Color primaryColor = const Color(0xFFfc521e);
Color backgroundColor = const Color(0xFF161928);
Color darkBackgroundColor = const Color(0xFF0d1019);

// void main(List<String> args) {
//   runApp(const StockzApp());
// }

// class StockzApp extends StatefulWidget {
//   const StockzApp({Key? key}) : super(key: key);

//   @override
//   State<StockzApp> createState() => _StockzAppState();
// }

// class _StockzAppState extends State<StockzApp> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: Theme.of(context).copyWith(
//         unselectedWidgetColor: primaryColor,
//         scaffoldBackgroundColor: Color(0xFF161928),
//         tabBarTheme: TabBarTheme(
//           labelColor: primaryColor,
//           labelStyle: Theme.of(context)
//               .tabBarTheme
//               .labelStyle
//               ?.copyWith(fontFamily: "Product Sans"),
//           unselectedLabelColor: Colors.grey,
//           indicator: UnderlineTabIndicator(
//             borderSide: BorderSide(color: primaryColor, width: 3),
//           ),
//         ),
//         colorScheme: ColorScheme.light(
//             primary: primaryColor, background: backgroundColor),
//       ),
//       home: Stockz(),
//     );
//   }
// }

class Stockz extends StatefulWidget {
  const Stockz({Key? key}) : super(key: key);

  @override
  State<Stockz> createState() => _StockzState();
}

class _StockzState extends State<Stockz> {
  var hideSmallBalances = true;
  @override
  Widget build(BuildContext context) {
    var jsonData = {
      "currentPortfolio": "382539.07",
      "stocks": [
        {
          "image":
              "https://s2.coinmarketcap.com/static/img/coins/200x200/2469.png",
          "title": "Zilliqa",
          "currency": "ZIL",
          "quantity": "3547.60",
          "asset_value": "33986.01"
        },
        {
          "image": "https://getcrypto.info/images/logos/gala.png",
          "title": "Gala",
          "currency": "GALA",
          "quantity": "3547.60",
          "asset_value": "33986.01"
        },
        {
          "image": "https://cryptologos.cc/logos/fantom-ftm-logo.png",
          "title": "Fantom",
          "currency": "FTM",
          "quantity": "627.60",
          "asset_value": "59755.00"
        },
        {
          "image":
              "https://img.api.cryptorank.io/coins/litentry1611830398127.png",
          "title": "Litentry",
          "currency": "LIT",
          "quantity": "3547.60",
          "asset_value": "33986.01"
        },
        {
          "image":
              "https://styles.redditmedia.com/t5_3ph1a/styles/communityIcon_4f01xg923uh81.png",
          "title": "Loopring",
          "currency": "LRC",
          "quantity": "3547.60",
          "asset_value": "33986.01"
        },
        {
          "image":
              "https://icodrops.com/wp-content/uploads/2020/08/The_Sandbox_logo.png",
          "title": "The Sandbox",
          "currency": "SAND",
          "quantity": "3547.60",
          "asset_value": "33986.01"
        },
        {
          "image":
              "https://s2.coinmarketcap.com/static/img/coins/200x200/7186.png",
          "title": "PancakeSwap",
          "currency": "CAKE",
          "quantity": "3547.60",
          "asset_value": "33986.01"
        }
      ]
    };
    SizeConfig().init(context);
    return SafeArea(
      child: DefaultTabController(
        initialIndex: 0,
        length: 1,
        child: Scaffold(
          backgroundColor: Color(0xFF161928),
          appBar: const TabBar(
            labelStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontFamily: "Product Sans",
            ),
            tabs: [
              Tab(
                text: "Portfolio",
              ),
              // Tab(
              //   text: "INR Wallet",
              // ),
              // Tab(
              //   text: "History",
              // ),
            ],
            indicatorSize: TabBarIndicatorSize.label,
            isScrollable: true,
          ),
          body: TabBarView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: darkBackgroundColor,
                    height: 8,
                  ),
                  Padding(
                    padding: EdgeInsets.all(getHeight(32)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const TextWidget(
                                  "Current Portfolio Value",
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                SizedBox(
                                  width: getWidth(200),
                                  child: OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                          side: BorderSide(color: Colors.grey),
                                          primary: Colors.grey),
                                      onPressed: () {},
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Icon(
                                            Icons.visibility_off_rounded,
                                            color: Colors.grey,
                                            size: getWidth(30),
                                          ),
                                          TextWidget(
                                            "Hide",
                                            color: Colors.grey,
                                          ),
                                        ],
                                      )),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                TextWidget(
                                  NumberFormat.currency(
                                          locale: "en_IN", symbol: "₹")
                                      .format(
                                    double.tryParse(
                                        (jsonData["currentPortfolio"]
                                                as String?) ??
                                            "0"),
                                  ),
                                  fontSize: getHeight(42),
                                )
                              ],
                            ),
                            SizedBox(
                              width: getWidth(200),
                              child: DropdownButtonFormField(
                                value: 0,
                                isDense: true,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 16),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                ),
                                iconEnabledColor: Colors.white,
                                items: [
                                  DropdownMenuItem(
                                    child: TextWidget("₹ INR"),
                                    value: 0,
                                  ),
                                  DropdownMenuItem(
                                    child: TextWidget("\$ USD"),
                                    value: 1,
                                  )
                                ],
                                onChanged: (dynamic value) {},
                                dropdownColor: darkBackgroundColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: getHeight(20),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                      side: BorderSide(color: primaryColor),
                                      primary: primaryColor),
                                  onPressed: () {},
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: getHeight(16)),
                                    child: TextWidget(
                                      "Deposit",
                                      color: primaryColor,
                                    ),
                                  )),
                            ),
                            SizedBox(
                              width: 24,
                            ),
                            Expanded(
                              child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                      side: BorderSide(color: primaryColor),
                                      primary: primaryColor),
                                  onPressed: () {},
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: getHeight(16)),
                                    child: TextWidget(
                                      "Withdraw",
                                      color: primaryColor,
                                    ),
                                  )),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: getHeight(20),
                        ),
                        CheckboxListTile(
                          activeColor: primaryColor,
                          value: hideSmallBalances,
                          onChanged: (val) {
                            setState(() {
                              hideSmallBalances = val ?? !hideSmallBalances;
                            });
                          },
                          title: TextWidget(
                            "Hide Small Balances",
                            color: Colors.grey,
                          ),
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.zero,
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: darkBackgroundColor,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ListTile(
                            tileColor: Color(0xFF161928),
                            leading: ClipOval(
                              child: Image.network(
                                (jsonData["stocks"] as List)[index]["image"],
                                height: 28,
                              ),
                            ),
                            title: TextWidget(
                                (jsonData["stocks"] as List)[index]["title"]),
                            subtitle: TextWidget(
                              (jsonData["stocks"] as List)[index]["currency"],
                              color: Colors.grey,
                            ),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                TextWidget(
                                  "${(jsonData["stocks"] as List)[index]["quantity"]} ${(jsonData["stocks"] as List)[index]["currency"]}",
                                  color: Colors.grey.shade200,
                                ),
                                TextWidget(
                                  "Asset Value: ₹ ${(jsonData["stocks"] as List)[index]["asset_value"]}",
                                  color: Colors.grey,
                                )
                              ],
                            ),
                          );
                        },
                        itemCount: (jsonData["stocks"] as List?)?.length,
                      ),
                    ),
                  )
                ],
              ),
              // TextWidget("Page 2"),
              // TextWidget("Page 3")
            ],
          ),
        ),
      ),
    );
  }
}

class TextWidget extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  const TextWidget(this.text,
      {Key? key,
      this.fontSize = 14,
      this.fontWeight = FontWeight.normal,
      this.color = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontFamily: "Product Sans",
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color),
    );
  }
}

class SizeConfig {
  static late double heightRatio;
  static late double widthRatio;
  init(BuildContext context) {
    heightRatio = MediaQuery.of(context).size.height / 1257;
    widthRatio = MediaQuery.of(context).size.width / 738;
  }
}

double getHeight(double height) {
  return height * SizeConfig.heightRatio;
}

double getWidth(double width) {
  return width * SizeConfig.widthRatio;
}
