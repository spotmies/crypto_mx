import 'dart:convert';
import 'dart:developer';

import 'package:cryptomarket/modules/home/transactionHist.dart';
import 'package:cryptomarket/repo/api_methods.dart';
import 'package:cryptomarket/repo/api_urls.dart';
import 'package:cryptomarket/utils/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TransactionInfo extends StatefulWidget {
  final dynamic id;
  const TransactionInfo({Key? key, this.id}) : super(key: key);

  @override
  State<TransactionInfo> createState() => _TransactionInfoState();
}

class _TransactionInfoState extends State<TransactionInfo> {
  var walletAddressController;
  var wAdd;
  dynamic coinsDetails;

  @override
  void initState() {
    super.initState();
    getCoinDetails();
  }

  getCoinDetails() async {
    var user = await getUserData();
    var prm = {
      "api_secret": "oApF8z0hmu",
      "user_id": user["user"]["id"].toString(),
      "staking_id": widget.id.toString()
    };
    dynamic res = await Server().getMethodParems(API.userSingleSteak, prm);
    if (res.statusCode == 200) {
      setState(() {
        coinsDetails = jsonDecode(res.body);
      });
      print('$coinsDetails');
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    if (coinsDetails == null) {
      return Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      );
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Transaction Info"),
      ),
      backgroundColor: Colors.black12,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 2.0),
                  height: height * 0.035,
                  width: width * 0.35,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(5)),
                  child: Text(
                    "Coin Name:",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: width * 0.045),
                  ),
                ),
                Spacer(),
                Container(
                  padding: const EdgeInsets.only(right: 2.0),
                  height: height * 0.035,
                  width: width * 0.58,
                  alignment: Alignment.centerRight,
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(5)),
                  child: Text(
                    coinsDetails["coin_name"],
                    style: TextStyle(
                        color: Colors.grey[900],
                        fontWeight: FontWeight.w600,
                        fontSize: width * 0.045),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 2.0),
                  height: height * 0.035,
                  width: width * 0.35,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(5)),
                  child: Text(
                    "Fund:",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: width * 0.045),
                  ),
                ),
                Spacer(),
                Container(
                  padding: const EdgeInsets.only(right: 2.0),
                  height: height * 0.035,
                  width: width * 0.58,
                  alignment: Alignment.centerRight,
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(5)),
                  child: Text(
                    coinsDetails["amount"].toString(),
                    style: TextStyle(
                        color: Colors.grey[900],
                        fontWeight: FontWeight.w600,
                        fontSize: width * 0.045),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 2.0),
                  height: height * 0.035,
                  width: width * 0.35,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(5)),
                  child: Text(
                    "TimeStamp:",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: width * 0.045),
                  ),
                ),
                Spacer(),
                Container(
                  padding: const EdgeInsets.only(right: 2.0),
                  height: height * 0.035,
                  width: width * 0.58,
                  alignment: Alignment.centerRight,
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(5)),
                  child: Text(
                    coinsDetails["updated_at"],
                    style: TextStyle(
                        color: Colors.grey[900],
                        fontWeight: FontWeight.w600,
                        fontSize: width * 0.045),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 2.0),
                  height: height * 0.035,
                  width: width * 0.35,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(5)),
                  child: Text(
                    "Total Days:",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: width * 0.045),
                  ),
                ),
                Spacer(),
                Container(
                  padding: const EdgeInsets.only(right: 2.0),
                  height: height * 0.035,
                  width: width * 0.58,
                  alignment: Alignment.centerRight,
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(5)),
                  child: Text(
                    "45",
                    style: TextStyle(
                        color: Colors.grey[900],
                        fontWeight: FontWeight.w600,
                        fontSize: width * 0.045),
                  ),
                ),
              ],
            ),
            // Row(
            //   children: [
            //     Text(
            //       "Percentage:",
            //       style: TextStyle(
            //           color: Colors.white,
            //           fontWeight: FontWeight.w600,
            //           fontSize: width * 0.055),
            //     ),
            //     Spacer(),
            //     Text(
            //       "1",
            //       style: TextStyle(
            //           color: Colors.white,
            //           fontWeight: FontWeight.w600,
            //           fontSize: width * 0.055),
            //     ),
            //   ],
            // ),
            SizedBox(
              height: height * 0.01,
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 2.0),
                  height: height * 0.035,
                  width: width * 0.35,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(5)),
                  child: Text(
                    "Stake Status:",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: width * 0.045),
                  ),
                ),
                Spacer(),
                Container(
                  padding: const EdgeInsets.only(right: 2.0),
                  height: height * 0.035,
                  width: width * 0.58,
                  alignment: Alignment.centerRight,
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(5)),
                  child: Text(
                    coinsDetails["status"] != 0 ? "Active" : "Inactive",
                    style: TextStyle(
                        color: Colors.grey[900],
                        fontWeight: FontWeight.w600,
                        fontSize: width * 0.045),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 2.0),
                  height: height * 0.035,
                  width: width * 0.35,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(5)),
                  child: Text(
                    "Stake Approval:",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: width * 0.045),
                  ),
                ),
                Spacer(),
                Container(
                  padding: const EdgeInsets.only(right: 2.0),
                  height: height * 0.035,
                  width: width * 0.58,
                  alignment: Alignment.centerRight,
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(5)),
                  child: Text(
                    coinsDetails["status"] == 0
                        ? "Pending"
                        : coinsDetails["status"] == 1
                            ? "Approved"
                            : "Rejected",
                    style: TextStyle(
                        color: Colors.grey[900],
                        fontWeight: FontWeight.w600,
                        fontSize: width * 0.045),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 2.0),
                  height: height * 0.035,
                  width: width * 0.35,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(5)),
                  child: Text(
                    "Days Left:",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: width * 0.045),
                  ),
                ),
                Spacer(),
                Container(
                  padding: const EdgeInsets.only(right: 2.0),
                  height: height * 0.035,
                  width: width * 0.58,
                  alignment: Alignment.centerRight,
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(5)),
                  child: Text(
                    coinsDetails["days_left"].toString(),
                    style: TextStyle(
                        color: Colors.grey[900],
                        fontWeight: FontWeight.w600,
                        fontSize: width * 0.045),
                  ),
                ),
              ],
            ),

            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Wallet Adress",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: width * 0.07),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: width * 0.9,
                  child: TextField(
                    controller: walletAddressController,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.grey),
                      hintText: 'Enter Wallet Adddress',
                      fillColor: Colors.white,
                      filled: true,
                      hoverColor: Colors.white,
                      focusColor: Colors.white,
                      alignLabelWithHint: true,
                      errorText: null,
                      labelStyle: TextStyle(color: Colors.white),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: height * 0.01, horizontal: width * 0.1),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        borderSide:
                            const BorderSide(color: Colors.white, width: 2.0),
                      ),
                    ),
                    onChanged: (value) {
                      wAdd = value;
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
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
                  if (wAdd != null) {
                    var user = await getUserData();
                    var prm = {
                      "api_secret": "oApF8z0hmu",
                      "user_id": user["user"]["id"].toString(),
                      "staking_id": widget.id.toString(),
                      "amount": coinsDetails["amount"].toString(),
                      "withdraw_address": wAdd.toString(),
                      "coin_id": coinsDetails["coin_id"].toString()
                    };

                    var res = await Server()
                        .getMethodParems(API.withdrawEarning, prm);
                    log(res.statusCode.toString());
                    if (res.statusCode == 200) {
                      final snackBar = SnackBar(
                        content: const Text('Withdrawl Earning!'),
                      );

                      // Find the ScaffoldMessenger in the widget tree
                      // and use it to show a SnackBar.
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  } else {
                    final snackBar = SnackBar(
                      content: const Text('Enter Wallet Address!'),
                    );

                    // Find the ScaffoldMessenger in the widget tree
                    // and use it to show a SnackBar.
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                child: const Text('Withdraw Earning'),
              ),
            ),
            SizedBox(
              height: 20,
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
                  var user = await getUserData();
                  var prm = {
                    "api_secret": "oApF8z0hmu",
                    "user_id": user["user"]["id"].toString(),
                    "staking_id": widget.id.toString(),
                    "amount": coinsDetails["amount"].toString(),
                    "withdraw_address": wAdd.toString(),
                    "coin_id": coinsDetails["coin_id"].toString()
                  };

                  var res =
                      await Server().getMethodParems(API.withdrawEarning, prm);
                  log(res.statusCode.toString());
                  if (res.statusCode == 200) {
                    final snackBar = SnackBar(
                      content: const Text('Withdrawl Principle!'),
                    );

                    // Find the ScaffoldMessenger in the widget tree
                    // and use it to show a SnackBar.
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                  // setState(() {
                  //   final snackBar = SnackBar(
                  //     content: const Text('Withdrawl requested!'),
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
                  // var oldTransact = (await Amplify.DataStore.query(
                  //     Transaction.classType,
                  //     where: Transaction.ID.eq(transaction.id)))[0];
                  // var newTransact = oldTransact.copyWith(
                  //     id: oldTransact.id, withDrawPrinciple: true);
                  // Amplify.DataStore.save(newTransact);
                  // var earning = transaction.amount;
                  // var withdraw = new Withdraw(
                  //     status: false,
                  //     username: signedInUser,
                  //     withdraw: earning,
                  //     address: wAdd);
                  // Amplify.DataStore.save(withdraw);
                },
                child: const Text('Withdraw Principle'),
              ),
            ),
            SizedBox(
              height: 20,
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
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (BuildContext context) =>
                          History(id: widget.id, depo: coinsDetails["amount"]),
                    ),
                  );
                },
                child: const Text('Transactions'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}







// InkWell(
//                     highlightColor: Colors.transparent,
//                     splashColor: Colors.transparent,
//                     onTap: () {},
//                     child: Container(
//                       child: Row(
//                         children: [
//                           SizedBox(
//                             width: 10,
//                           ),
//                           Image.network(
//                             coinImageURL + "eth" + "@2x.png",
//                             width: MediaQuery.of(context).size.width * 0.1,
//                           ),
//                           SizedBox(
//                             width: 20,
//                           ),
//                           Text(
//                             "Ethereum",
//                             style: TextStyle(
//                                 color: Color(0xff515669), fontSize: 25),
//                           ),
//                           Spacer(),
//                           Text(
//                             "-0.3",
//                             style: TextStyle(
//                                 color: Color(0xff515669), fontSize: 25),
//                           ),
//                           SizedBox(
//                             width: 10,
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                   Divider(
//                     height: 10,
//                     thickness: 3,
//                     indent: 70,
//                     color: Color(0xff515669),
//                   ),
//                   SizedBox(
//                     height: 15,