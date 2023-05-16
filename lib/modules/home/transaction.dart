import 'dart:convert';
import 'dart:developer';

import 'package:cryptomarket/modules/home/homeScreen.dart';
import 'package:cryptomarket/repo/api_methods.dart';
import 'package:cryptomarket/repo/api_urls.dart';
import 'package:cryptomarket/utils/shared_preferences.dart';
import 'package:flutter/material.dart';
import '../../constance/global.dart';
import '../../constance/themes.dart';
import '../../design/appBar.dart';
import 'package:flutter/services.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TransactionPage extends StatefulWidget {
  final String? coinId;
  final dynamic planDetails;
  const TransactionPage({Key? key, this.coinId, this.planDetails})
      : super(key: key);

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  String tId = 'THnKdPNj7WzeUJqHcbAM6sEd2tAkFF6akZ';
  var AmountController = TextEditingController();
  var TransactionController = TextEditingController();
  var amount;
  var transact_id;
  Future<void> _copyToClipboard() async {
    await Clipboard.setData(
        ClipboardData(text: coinDetails["deposit_address"]));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Copied to clipboard'),
    ));
  }

  @override
  void initState() {
    super.initState();
    getCoinsDetails();

    // getCurrentUser();
  }

  dynamic coinDetails;
  getCoinsDetails() async {
    var prm = {"api_secret": "oApF8z0hmu", "coin_id": widget.coinId.toString()};
    dynamic res = await Server().getMethodParems(API.coinDetails, prm);
    if (res.statusCode == 200) {
      setState(() {
        coinDetails = jsonDecode(res.body);
      });
      print('$coinDetails');
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    if (coinDetails == null) {
      return Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      );
    }
    return Scaffold(
      backgroundColor: AllCoustomTheme.getThemeData().backgroundColor,
      appBar: MainAppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CachedNetworkImage(
              errorWidget: (context, url, error) => CircleAvatar(
                backgroundColor: AllCoustomTheme.getsecoundTextThemeColor(),
                child: Text(
                  coinSymbol.substring(0, 1),
                ),
              ),
              imageUrl: coinDetails["coin_image"],
              // coinImageURL + coinSymbol.toLowerCase() + "@2x.png",
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: width * 0.05,
            ),
            Text(
              coinName,
              style: TextStyle(
                  fontSize: width * 0.09, fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Image.network(
                coinDetails["qr_code"],
                scale: width * 0.003,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  coinDetails["deposit_address"].substring(0, 10) + '...',
                  style: TextStyle(color: Colors.white),
                ),
                IconButton(
                    onPressed: () async {
                      await this._copyToClipboard();
                    },
                    icon: Icon(Icons.content_copy, color: Colors.white))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Days: ' + widget.planDetails["min_days"].toString(),
                  style: TextStyle(
                      fontSize: width * 0.05,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                SizedBox(
                  width: width * 0.1,
                ),
                Text(
                  'Percentage: ' +
                      double.parse(
                              widget.planDetails["daily_returns"].toString())
                          .toString(),
                  style: TextStyle(
                      fontSize: width * 0.05,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.02,
            ),
            SizedBox(
              width: width * 0.9,
              child: TextField(
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                controller: AmountController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.white),
                    hintText: 'Enter the amount',
                    fillColor: Colors.white,
                    labelStyle: TextStyle(color: Colors.grey[500]),
                    filled: false,
                    hoverColor: Colors.white,
                    labelText: 'amount',
                    focusColor: Colors.white,
                    alignLabelWithHint: true,
                    contentPadding: EdgeInsets.symmetric(
                        vertical: height * 0.01, horizontal: width * 0.1),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    errorText: "Please kindly enter the fund"),
                onChanged: (value) {
                  amount = int.parse(value);
                },
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            SizedBox(
              width: width * 0.9,
              child: TextField(
                controller: TransactionController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.white),
                    hintText: 'Enter the transaction id',
                    fillColor: Colors.white,
                    labelStyle: TextStyle(color: Colors.grey[500]),
                    filled: false,
                    hoverColor: Colors.white,
                    labelText: 'transaction id',
                    focusColor: Colors.white,
                    alignLabelWithHint: true,
                    contentPadding: EdgeInsets.symmetric(
                        vertical: height * 0.01, horizontal: width * 0.1),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    errorText: "Please kindly enter the transaction id"),
                onChanged: (value) {
                  transact_id = value;
                },
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            SizedBox(
              width: width * 0.75,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blueAccent, // background
                  onPrimary: Colors.white, // foreground
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32.0))),
                ),
                onPressed: () async {
                  if (amount != null && transact_id != null) {
                    dynamic uid = await getUserData();

                    var prm = {
                      "user_id": uid["user"]["id"].toString(),
                      "plan_id": widget.planDetails["plan_id"].toString(),
                      "coin_id": widget.coinId.toString(),
                      "amount": amount.toString(),
                      "transaction_hash": transact_id.toString(),
                      "api_secret": "oApF8z0hmu"
                    };

                    dynamic plans = await Server()
                        .getMethodParems(API.newStackingRequest, prm);
                    dynamic plItems = jsonDecode(plans.body);
                    log(plItems.toString());
                    if (plItems["response"] == "success") {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40)),
                            elevation: 16,
                            child: Container(
                                height: 200,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text("Transaction submitted successfully"),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary:
                                            Colors.blueAccent, // background
                                        onPrimary: Colors.white, // foreground
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(32.0))),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HomeScreen()));
                                      },
                                      child: Text("Go to Home"),
                                    )
                                  ],
                                )),
                          );
                        },
                      );
                    }
                  }
                  {
                    final snackBar = SnackBar(
                      content: const Text('Textfield can not be empty!'),
                    );

                    // Find the ScaffoldMessenger in the widget tree
                    // and use it to show a SnackBar.
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                  // var transact = new Transaction(
                  //     amount: this.amount.toDouble(),
                  //     transactionId: this.transact_id,
                  //     username: signedInUser,
                  //     approve: false,
                  //     daysToHold: daysToHold.toInt(),
                  //     percentage: percentage.toDouble(),
                  //     timeStamp: DateTime.now().toIso8601String(),
                  //     transactionStatus: true,
                  //     withDrawPrinciple: false,
                  //     withdrawTimeLocal: DateTime.parse('2000-07-28 05:47:04Z')
                  //         .toIso8601String(),
                  //     coinName: coinName,
                  //     withDrawEarning: false);
                  // await Amplify.DataStore.save(transact);
                  // setState(() {
                  //   String msg = "";
                  //   AmountController.text.isEmpty ||
                  //           TransactionController.text.isEmpty
                  //       ? msg = "please check the details and submit again"
                  //       : msg = "submitted successfully";
                  //   AmountController.clear();
                  //   TransactionController.clear();
                  //   final snackBar = SnackBar(
                  //     content: Text(msg),
                  //     action: SnackBarAction(
                  //       label: 'Done',
                  //       onPressed: () {
                  //         // Some code to undo the change.
                  //       },
                  //     ),
                  //   );

                  //   // Find the ScaffoldMessenger in the widget tree
                  //   // and use it to show a SnackBar.
                  //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  // });
                  ;
                },
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
