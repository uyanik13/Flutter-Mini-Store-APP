import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../config.dart';
import 'package:easy_localization/easy_localization.dart';

class HelperClass {


  /// Show Success Alert
  void showSuccessAlert(BuildContext context,String multiLanguageText,Function page) {
    Alert(context:context,
        style: Config.alertStyle,
        type: AlertType.success,
        title: 'success'.tr(),
        desc:'$multiLanguageText'.tr(),
        buttons: [
          DialogButton(
            onPressed: (){
              Route route = MaterialPageRoute(builder: (context) => page());
              Navigator.push(context, route);
            },
            child: Text('ok',
              style: TextStyle(color: Colors.white, fontSize: 20),).tr(),
          )]
    ).show();
  }

  /// Show Error Alert
  void showErrorAlert(BuildContext context,String multiLanguageText) {
    Alert(context:context,
        style: Config.alertStyle,
        type: AlertType.warning,
        title: 'warning'.tr(),
      desc:'$multiLanguageText'.tr(),
        buttons: [
          DialogButton(
            onPressed: () => Navigator.pop(context),
            child: Text('ok',
              style: TextStyle(color: Colors.white, fontSize: 20),).tr(),
          )]
    ).show();
  }


  /// Show Info Alert
  void showInfoAlert(BuildContext context,String multiLanguageText) {
    Alert(context:context,
      style: Config.alertStyle,
      type: AlertType.warning,
      title: 'info'.tr(),
      desc:'$multiLanguageText'.tr(),
        buttons: [
          DialogButton(
            onPressed: () => Navigator.pop(context),
            child: Text('ok',
              style: TextStyle(color: Colors.white, fontSize: 20),).tr(),
          )]
    ).show();
  }
}

