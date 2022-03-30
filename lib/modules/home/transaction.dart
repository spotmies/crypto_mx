import 'package:flutter/material.dart';
import '../../constance/global.dart';
import '../../constance/themes.dart';
import '../../design/appBar.dart';
import 'package:flutter/services.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import '../../models/ModelProvider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({Key? key}) : super(key: key);

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
    await Clipboard.setData(ClipboardData(text: this.tId));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Copied to clipboard'),
    ));
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Scaffold(
      appBar: MainAppBar(title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CachedNetworkImage(
            errorWidget: (context, url, error) => CircleAvatar(
              backgroundColor:
              AllCoustomTheme.getsecoundTextThemeColor(),
              child: Text(
                coinSymbol.substring(0, 1),
              ),
            ),
            imageUrl: coinImageURL +
                coinSymbol.toLowerCase() +
                "@2x.png",
            fit: BoxFit.cover,
          ),
          SizedBox(width: width*0.05,),
          Text(coinName,
          style: TextStyle(
            fontSize: width*0.09,
            fontWeight: FontWeight.w600
          ),
          )
        ],

      ),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Image.network('https://www.cilips.org.uk/wp-content/uploads/2021/09/qr-code-7.png',
              scale: width*0.02,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(this.tId.substring(0,10)+'...'),
                IconButton(onPressed: ()async{
                  await this._copyToClipboard();
                },
                icon: Icon(Icons.content_copy))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Days: '+daysToHold.toString(),
                style: TextStyle(
                  fontSize: width*0.05,
                  fontWeight: FontWeight.w600,
                ),
                ),
                SizedBox(width: width*0.1,),
                Text('Percentage: '+percentage.toString(),
                  style: TextStyle(
                    fontSize: width*0.05,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height*0.02,
            ),
            SizedBox(
              width: width*0.9,
              child: TextField(
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly
                ],
                controller: AmountController,
                decoration: InputDecoration(
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: 'Enter the amount',
                  fillColor: Colors.white,
                  filled: false,
                  hoverColor: Colors.white,
                  labelText: 'amount',
                  focusColor: Colors.white,
                  alignLabelWithHint: true,
                  contentPadding:
                  EdgeInsets.symmetric(vertical: height*0.01, horizontal: width*0.1),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                    errorText: "Please kindly enter the fund"
                ),
                onChanged: (value){
                  amount = int.parse(value);
                },
              ),
            ),
            SizedBox(
              height: height*0.02,
            ),
            SizedBox(
              width: width*0.9,
              child: TextField(
                controller: TransactionController,
                decoration: InputDecoration(
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: 'Enter the transaction id',
                  fillColor: Colors.white,
                  filled: false,
                  hoverColor: Colors.white,
                  labelText: 'transaction id',
                  focusColor: Colors.white,
                  alignLabelWithHint: true,
                  contentPadding:
                  EdgeInsets.symmetric(vertical: height*0.01, horizontal: width*0.1),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  errorText: "Please kindly enter the transaction id"
                ),
                onChanged: (value){
                  transact_id = value;
                },
              ),
            ),
            SizedBox(
              height: height*0.02,
            ),
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
                  var user = await Amplify.Auth.getCurrentUser();
                  var username = user.username;
                  signedInUser = username;
                  var transact = new Transaction(amount: this.amount.toDouble(), transactionId: this.transact_id,username:username,approve: false,daysToHold: daysToHold.toInt(),percentage: percentage.toDouble(),timeStamp: DateTime.now().toIso8601String(),transactionStatus: true,withDrawPrinciple: false,withdrawTimeLocal: DateTime.parse('2000-07-28 05:47:04Z').toIso8601String(),coinName: coinName,withDrawEarning: false,coinSymbol: coinSymbol);
                  await Amplify.DataStore.save(transact);
                  setState(() {
                    String msg = "";
                    AmountController.text.isEmpty || TransactionController.text.isEmpty? msg="please check the details and submit again":msg="submitted successfully";
                    AmountController.clear();
                    TransactionController.clear();
                    final snackBar = SnackBar(
                      content: Text(msg),
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
                  });;
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
