import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:store_app/screens/main_widgets/drawer.dart';
import 'package:store_app/utils/styles/user_app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../config.dart';
class AboutScreen extends StatefulWidget {
  @override
  _AboutScreen createState() => _AboutScreen();
}

class _AboutScreen extends State<AboutScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      color: UserAppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.white,
          drawer:DroDrawer(),
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: new IconButton(
              icon: new Icon(Icons.menu, color: Colors.deepPurple,),
              onPressed: () => _scaffoldKey.currentState.openDrawer(),
            ),
            title: Text("aboutScreen".tr(), style: TextStyle(fontSize: 16.0,
                fontWeight: FontWeight.w500,
                color: Colors.deepPurple),),
            /* actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search, color: Colors.red), onPressed: () {},),
            IconButton(icon: Icon(Icons.notifications, color: Colors.red),
              onPressed: () {},)
          ],*/
          ),
          body: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                    top: 90,
                    left: 16,
                    right: 16),
                child: Image.asset('assets/images/dro-logo.png'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom:20),
                child: Text(
                  'DRO Marketing',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Center(
                child: Text(
                  'aboutText'.tr(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  'appVersion'.tr() + Config.version,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color:Colors.deepPurple,
                    fontSize: 16,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 25),
                child: Center(
                  child: Container(
                    width: 140,
                    height: 40,
                    decoration:  BoxDecoration(
                      color: UserAppTheme.nearlyDarkBlue,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(38.0),
                      ),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            offset: const Offset(0, 2),
                            blurRadius: 8.0),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () { launch('https://www.dijitalreklam.org');},
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              'goWebsite'.tr(),
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
