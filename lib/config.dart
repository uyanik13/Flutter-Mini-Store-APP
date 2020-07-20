
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Config {

  /// Define your  API url here
  //static final String apiEndpoint = 'http://10.0.2.2:8000/api';
  //static final String apiEndpoint = 'https://dromarketer.com/api';

  /// Define your default color (light or dark)
  // static final defaultColor = 'dark';
  static final defaultColor = 'light';

  static final alertStyle = AlertStyle(
    animationType: AnimationType.fromTop,
    isCloseButton: false,
    isOverlayTapDismiss: true,
    descStyle: TextStyle(fontWeight: FontWeight.bold),
    animationDuration: Duration(milliseconds: 400),
    alertBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5.0),
      side: BorderSide(
        color: Colors.grey,
      ),
    ),
    titleStyle: TextStyle(
      color: Colors.red,
    ),
  );



  static final version = '1.0.0';

  /// Enable push notifications
  static final pushNotificationsEnabled = true;

  /// AdMob settings
  static final adMobEnabled = false;
  static final adMobIOSAppID = 'ca-app-pub-3731388982814260~3838562377';
  static final adMobAndroidID = 'ca-app-pub-3731388982814260~6572822330';
  //static final adMobAdUnitID = 'ca-app-pub-3731388982814260/5115985028';
  static final adMobPosition = 'center';
}
