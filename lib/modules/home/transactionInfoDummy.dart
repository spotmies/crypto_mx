import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../constance/global.dart';
import '../../models/Transaction.dart';
import '../../models/Withdraw.dart';
class TransactionInfo extends StatefulWidget {
  const TransactionInfo({Key? key}) : super(key: key);

  @override
  State<TransactionInfo> createState() => _TransactionInfoState();
}

class _TransactionInfoState extends State<TransactionInfo> {


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Transaction Info"),
      ),
      backgroundColor: Colors.black12,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Text("Coin Name:",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20
                ),
              ),
              Spacer(),
              Text("Bitcoin",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text("Fund:",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20
                ),
              ),
              Spacer(),
              Text("20",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text("TimeStamp:",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20
                ),
              ),
              Spacer(),
              Text(DateTime.now().toString(),
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text("Total Days:",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20
                ),
              ),
              Spacer(),
              Text("45",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text("Percentage:",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20
                ),
              ),
              Spacer(),
              Text("1",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text("Stake Status:",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20
                ),
              ),
              Spacer(),
              Text("Active",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text("Stake Approval:",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20
                ),
              ),
              Spacer(),
              Text("Approved",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text("Days Left:",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20
                ),
              ),
              Spacer(),
              Text("-1",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20
                ),
              ),
            ],
          ),
          SizedBox(height: 20,),
          SizedBox(
            width: width*0.75,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blueAccent, // background
                onPrimary: Colors.white, // foreground
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0))
                ),
              ),
              onPressed: () async{
                setState(() {
                  final snackBar = SnackBar(
                    content: const Text('Withdrawl requested!'),
                    action: SnackBarAction(
                      label: 'Done',
                      onPressed: () {
                        // Some code to undo the change.
                      },
                    ),
                  );

                  // Find the ScaffoldMessenger in the widget tree
                  // and use it to show a SnackBar.
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                });
                var oldTransact = (await Amplify.DataStore.query(Transaction.classType,
                    where: Transaction.ID.eq(transaction.id)))[0];
                var newTransact = oldTransact.copyWith(id: oldTransact.id,withDrawEarning: true);
                Amplify.DataStore.save(newTransact);
                var earning = transaction.percentage*transaction.amount*daysEarned*0.01;
                var withdraw = new Withdraw(status: false,username: signedInUser,withdraw: earning,address: 'adfuu123');
                Amplify.DataStore.save(withdraw);

              },
              child: const Text('Withdraw Earning'),

            ),
          ),
          SizedBox(height: 20,),
          SizedBox(
            width: width*0.75,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blueAccent, // background
                onPrimary: Colors.white, // foreground
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0))
                ),
              ),
              onPressed: () async{
                setState(() {
                  final snackBar = SnackBar(
                    content: const Text('Withdrawl requested!'),
                    action: SnackBarAction(
                      label: 'Done',
                      onPressed: () {
                        // Some code to undo the change.
                      },
                    ),
                  );

                  // Find the ScaffoldMessenger in the widget tree
                  // and use it to show a SnackBar.
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                });
                var oldTransact = (await Amplify.DataStore.query(Transaction.classType,
                    where: Transaction.ID.eq(transaction.id)))[0];
                var newTransact = oldTransact.copyWith(id: oldTransact.id,withDrawPrinciple: true);
                Amplify.DataStore.save(newTransact);
                var earning = transaction.amount;
                var withdraw = new Withdraw(status: false,username: signedInUser,withdraw: earning,address: 'affg23');
                Amplify.DataStore.save(withdraw);

              },
              child: const Text('Withdraw Principle'),

            ),
          ),

        ],
      ),
    );
  }
}
