import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

/* -------------------------------------------------------------------------- */
/*                       SAVE DATA TO SHARED PREFERENCE                       */
/* -------------------------------------------------------------------------- */

setUserData(dynamic data) {
  setStringToSF(id: "user", value: data);
}


/* -------------------------------------------------------------------------- */
/*                       GET DATA FROM SHARED PREFERENCE                      */
/* -------------------------------------------------------------------------- */
getUserData() async {
  dynamic user = await getStringValuesSF("user");
  return user;
}



/* -------------------------------------------------------------------------- */
/*                                   Functions                                */
/* -------------------------------------------------------------------------- */

setStringToSF({String? id, value}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(id!, jsonEncode(value));
}

getStringValuesSF(String? id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return String
  if (!prefs.containsKey(id!)) return null;
  String stringValue = prefs.getString(id)!;
  dynamic returnedValue = jsonDecode(stringValue);
  return returnedValue;
}
