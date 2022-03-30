import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:cryptomarket/models/Transaction.dart';
import 'package:cryptomarket/modules/home/transactionInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import '../../constance/global.dart';

class TransactionHistory extends StatefulWidget {
  const TransactionHistory({Key? key}) : super(key: key);

  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  // Stream<SubscriptionEvent<Transaction>> transactStream() {
  //   Stream<SubscriptionEvent<Transaction>> stream =
  //   Amplify.DataStore.observe(Transaction.classType, where: Transaction.USERNAME.eq(signedInUser) );
  //   return stream;
  // }

  Widget transactionTab(var post){
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: (){
        transaction = post;
        if(transaction.transactionStatus){
          transactionStatus = "Alive";
          vis1 = true;
          if(transaction.approve){
            vis2 = true;
            approval = "Transaction Approved";
            var t = transaction.timeStamp;
            var temp = DateTime.parse(t);
            var now = DateTime.now();
            var diff = now.difference(temp);
            daysDone = diff.inDays;
            daysLeft = transaction.daysToHold - daysDone;
            var t2 = transaction.withdrawTimeLocal;
            var temp2 = DateTime.parse(t2);
            var diff2 = now.difference(temp2);
            if (daysDone>daysDone2){
              daysEarned = daysDone2;
            }
            else{
              daysEarned = daysDone;
            }
            if (daysEarned==0){
              vis4 = false;
            }
            if(daysLeft<=0){
              daysLeft = 0;
              vis3 = true;
            }
          }
          else{
            approval = "Transaction not approved";
          }
        }
        else{
          transactionStatus = "Dead";
        }
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (BuildContext context) => TransactionInfo(),
          ),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(post.coinName,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600
          ),
          ),
          Spacer(),
          Text(post.amount.toString(),
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600
            ),
          ),
          Spacer(),
          Text(post.timeStamp.substring(2,10),
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600
            ),
          ),
          Spacer(),
          Text(post.timeStamp.substring(11,16),
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600
            ),
          ),

          Spacer(),
          Text(post.transactionStatus?"active":"failed",
            style: TextStyle(
                color: post.transactionStatus? Colors.green:Colors.red,
                fontSize: 20,
                fontWeight: FontWeight.w600
            ),
          ),
        ],
      ),
    );
  }
  List<Widget> tabs = [];
  Widget tabsWidget(){

    tabs.add(Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Currency",
          style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600
          ),
        ),
        Spacer(),
        Text("Fund",
          style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600
          ),
        ),
        Spacer(),
        Text("Date",
          style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600
          ),
        ),
        Spacer(),
        Text("Time",
          style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600
          ),
        ),

        Spacer(),
        Text("Status",
          style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600
          ),
        ),
      ],
    ),);
    tabs.add(SizedBox(height: 20,));
    for(var i in posts){
      if(!tabs.contains(i))
      tabs.add(transactionTab(i));
      tabs.add(SizedBox(height: 10,));
    }
    return Column(
      children: [

        SizedBox(height: 20,),
        ListView(

          children: tabs,
          shrinkWrap: true,
        ),
      ],
    );
  }
  Stream<QuerySnapshot<Transaction>> stream = Amplify.DataStore.observeQuery(
    Transaction.classType,
    where: Transaction.USERNAME.eq(signedInUser) ,
    sortBy: [Transaction.TIMESTAMP.descending()],
  );
  Stream<SubscriptionEvent<Transaction>> stream2 =
  Amplify.DataStore.observe(Transaction.classType,where: Transaction.USERNAME.eq(signedInUser),
  );
  List<Widget> transactions = [];
  
  void streaming(){
    var streams = Amplify.DataStore.observe(Transaction.classType);
    streams.listen((_)=>Amplify.DataStore.query(Transaction.classType, where: Transaction.USERNAME.eq(signedInUser) ));
    print(streams);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction History'),
      ),
      backgroundColor: Colors.black12,
      body: SafeArea(

        // child: StreamBuilder<SubscriptionEvent<Transaction>>(
        //   stream: stream2,
        //   builder: (context,snapshot){
        //     if(snapshot.hasData){
        //       var transact = snapshot.data!.item;
        //       var t;
        //       t = InkWell(
        //         highlightColor: Colors.transparent,
        //         splashColor: Colors.transparent,
        //         child: Row(
        //           children: [
        //             Text(transact.coinName,
        //             style: TextStyle(
        //               color: Colors.white,
        //               fontWeight: FontWeight.w600,
        //               fontSize: 20,
        //             ),
        //             ),
        //             Spacer(),
        //             Text(transact.amount.toString(),
        //               style: TextStyle(
        //                 color: Colors.white,
        //                 fontWeight: FontWeight.w600,
        //                 fontSize: 20,
        //               ),
        //             ),
        //             Spacer(),
        //             Text(transact.timeStamp.substring(2,10)+" "+transact.timeStamp.substring(11,16),
        //               style: TextStyle(
        //                 color: Colors.white,
        //                 fontWeight: FontWeight.w600,
        //                 fontSize: 20,
        //               ),
        //             ),
        //             Spacer(),
        //             Text(transact.transactionStatus?"active":"failed",
        //               style: TextStyle(
        //                 color: transact.transactionStatus?Colors.green:Colors.red,
        //                 fontWeight: FontWeight.w600,
        //                 fontSize: 20,
        //               ),
        //             ),
        //           ],
        //         ),
        //         onTap: (){},
        //       );
        //       // var transacts = snapshot.data!.items;
        //       // var t;
        //       // for(var i in transacts){
        //       //   t = InkWell(
        //       //     highlightColor: Colors.transparent,
        //       //     splashColor: Colors.transparent,
        //       //     child: Text(i.toString().substring(10),
        //       //       style: TextStyle(color: Colors.white),
        //       //
        //       //     ),
        //       //     onTap: (){},
        //       //   );
        //       // }
        //       if(!transactions.contains(t))
        //       transactions.add(t);
        //       return ListView(
        //         shrinkWrap: true,
        //         children: transactions,
        //       );
        //
        //     }
        //     else if(!snapshot.hasData){
        //       return Center(child: Text("You haven't made any transactions"));
        //     }
        //     else{
        //       return Center(child: Text("An unknown error has occurred"));
        //     }
        //   },
        // ),
        child: tabsWidget(),
      ),
    );
  }
}
