import 'dart:convert';
import 'dart:io';
import 'package:cryptomarket/model/listingsModel.dart';
import 'package:cryptomarket/splash/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'auth/authenticationScreen.dart';
import 'constance/global.dart';
import 'constance/routes.dart';
import 'constance/themes.dart';
import 'modules/home/homeScreen.dart';
import 'modules/introduction/introductionScreen.dart';
import 'modules/introduction/swipeIndtroduction.dart';
import 'amplifyconfiguration.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'models/ModelProvider.dart';
import 'package:amplify_api/amplify_api.dart';
import 'auth/signInScreen.dart';
import 'auth/signUpScreen.dart';
import 'modules/introduction/introductionScreen.dart';
import 'modules/introduction/swipeIndtroduction.dart';
import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';

var portfolioMap;
List marketListData = [];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Map portfolioMap;
  await getApplicationDocumentsDirectory().then((Directory directory) async {
    File jsonFile = new File(directory.path + "/portfolio.json");
    if (jsonFile.existsSync()) {
      portfolioMap = json.decode(jsonFile.readAsStringSync());
    } else {
      jsonFile.createSync();
      jsonFile.writeAsStringSync("{}");
      portfolioMap = {};
    }
    // ignore: unnecessary_null_comparison
    if (portfolioMap == null) {
      portfolioMap = {};
    }
    jsonFile = new File(directory.path + "/marketData.json");
    if (jsonFile.existsSync()) {
      marketListData = json.decode(jsonFile.readAsStringSync());
    } else {
      jsonFile.createSync();
      jsonFile.writeAsStringSync("[]");
      marketListData = [];
    }
  });

  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  ).then(
        (_) => runApp(
      MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool allCoin = false;
  @override
  void initState() {
    super.initState();
    getApiAllData(1);
    testFunction();
  }
  Future<void> _configureAmplify() async {
    AmplifyDataStore datastorePlugin =
    AmplifyDataStore(modelProvider: ModelProvider.instance);
    try {
      Amplify.addPlugin(datastorePlugin);
      // Add the following line to add Auth plugin to your app.
      await Amplify.addPlugin(AmplifyAPI());
      await Amplify.addPlugin(AmplifyAuthCognito());
      // call Amplify.configure to use the initialized categories in your app
      await Amplify.configure(amplifyconfig);
    } on Exception catch (e) {
      print('An error occurred configuring Amplify: $e');
    }
  }

  Future<Null> getApiAllData(int index) async {
    List<CryptoCoinDetail> allCoinList = [];
    var coindata = await getData1(index);
    // ignore: unnecessary_null_comparison
    if (coindata != null) {
      if (coindata.length != 0) {
        index += coindata.length;
        if (index == 1) {
          setState(() {
            allCoinList.addAll(coindata);
          });
        } else {
          allCoinList.addAll(coindata);
          setState(() {
            allCoinList.removeWhere((length) => length.quote!.uSD!.marketCap == null);
            if (allCoin == true) {
              getApiAllData(index);
            }
            marketListData.addAll(allCoinList);
          });
        }
      }
    }
  }
  void testFunction()async{
    await _configureAmplify();
    final result = await Amplify.Auth.fetchAuthSession();
    if(result.isSignedIn){
    final user = await Amplify.Auth.getCurrentUser();
    //print(user.username);
    signedInUser = user.username;
    }
    isSignedIn = result.isSignedIn;

  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarDividerColor: Colors.transparent,
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: AllCoustomTheme.getThemeData().primaryColor,
      systemNavigationBarIconBrightness: Brightness.light,
    ));
    return Container(
      color: AllCoustomTheme.getThemeData().primaryColor,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Crypto Trade',
        routes: routes,
        home:SplashScreen(),
        theme: AllCoustomTheme.getThemeData(),
      ),
    );
  }

  var routes = <String, WidgetBuilder>{
    Routes.SPLASH: (BuildContext context) => SplashScreen(),
    Routes.Introdution: (BuildContext context) => IntroductionScreen(),
    Routes.SwipeIntrodution: (BuildContext context) => SwipeIntroductionScreen(),
    Routes.Auth: (BuildContext context) => AuthenticationScreen(),
    Routes.Home: (BuildContext context) => HomeScreen(),
    Routes.SignIn: (BuildContext context) => SignInScreen(),
    Routes.SignUp: (BuildContext context) => SignUpScreen(),
    Routes.Introduction: (BuildContext context) => IntroductionScreen(),
    Routes.SwipeIntroduction: (BuildContext context) => SwipeIntroductionScreen(),
  };

}
