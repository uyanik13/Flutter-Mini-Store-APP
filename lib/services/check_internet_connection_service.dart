import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:store_app/constants/strings.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../config.dart';

Future<bool> checkNetworkConnection(BuildContext context) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Alert(context:context,
          style: Config.alertStyle,
          type: AlertType.info,
          title: Strings.warning,
          desc:Strings.youHaveNotInternetConnection).show();
      return false;
    }
    print("Internet Connection is okay");
    return true;
  }


/* void _showSnackBar(BuildContext context){
       var snackBar = new SnackBar(
          duration: Duration(hours: 1),
          content: GestureDetector(
            onTap: () {
              //_scaffoldKey.currentState.hideCurrentSnackBar();
              Scaffold.of(context).hideCurrentSnackBar();
              // _checkLoggedIn();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("check internet connection"),
                Icon(Icons.perm_scan_wifi),
              ],
            ),
          ));
      // _scaffoldKey.currentState.showSnackBar(snackBar);
      Scaffold.of(context).showSnackBar(snackBar);
 }*/
  