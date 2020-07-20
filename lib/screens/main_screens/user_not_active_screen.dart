import 'file:///E:/PROJECTS/MOBILE/store_app/lib/utils/styles/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:store_app/main.dart';
import 'package:store_app/utils/styles/user_app_theme.dart';
import 'package:url_launcher/url_launcher.dart';
class UserNotActiveScreen extends StatefulWidget {
  @override
  _UserNotActiveScreen createState() => _UserNotActiveScreen();
}

class _UserNotActiveScreen extends State<UserNotActiveScreen> {
  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                    top: 50,
                    left: 16,
                    right: 16),
                child: Image.asset('assets/images/paket-yukselt.png'),
              ),
              Container(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  'Kullanım Süreniz Sona Ermiştir.',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 15),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Center(
                    child: Container(
                      width: 140,
                      height: 40,
                      decoration: BoxDecoration(
                        color: UserAppTheme.nearlyDarkBlue,
                        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                        gradient: LinearGradient(
                            colors: [
                              UserAppTheme.nearlyDarkBlue,
                              HexColor('#6A88E5'),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                        shape: BoxShape.rectangle,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: UserAppTheme.nearlyDarkBlue
                                  .withOpacity(0.4),
                              offset: const Offset(8.0, 16.0),
                              blurRadius: 16.0),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () { launch('https://www.dromarkete.com/dashboard');},
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                'Satın Al',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
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
              ),

            ],
          ),
        ),
      ),
    );
  }
}
