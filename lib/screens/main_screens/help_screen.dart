import 'file:///E:/PROJECTS/MOBILE/store_app/lib/utils/styles/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:store_app/screens/main_widgets/drawer.dart';
import 'package:url_launcher/url_launcher.dart';
class HelpScreen extends StatefulWidget {
  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
  }
  final String messageText = 'helloIHaveAnProblem'.tr();
  void whatsAppOpen() async {
    var whatsAppUrl ="whatsapp://send?phone=905456134513&text=$messageText";
    await canLaunch(whatsAppUrl)
        ? launch(whatsAppUrl)
        :print("open whatsapp app link or do a snackbar with notification that there is no whatsapp installed");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.nearlyWhite,
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
            title: Text("howWeCanHelpYou".tr(), style: TextStyle(fontSize: 16.0,
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
                    top: MediaQuery.of(context).padding.top,
                    left: 16,
                    right: 16),
                child: Image.asset('assets/images/helpImage.png'),
              ),
              Container(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  'howWeCanHelpYou'.tr(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  'itsLookLikeA'.tr(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Container(
                      width: 140,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4.0)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.6),
                              offset: const Offset(4, 4),
                              blurRadius: 8.0),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () { whatsAppOpen();},
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                'chatWithUs'.tr(),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
