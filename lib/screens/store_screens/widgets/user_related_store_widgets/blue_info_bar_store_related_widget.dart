
import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/providers/auth_provider.dart';
import 'package:store_app/screens/main_screens/check_status_screen.dart';
import 'package:store_app/utils/helpers/helpers.dart';
import 'package:store_app/utils/styles/user_app_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../main.dart';


class BlueInfoBarStoreRelatedView extends StatelessWidget {
  final AnimationController animationController;
  final Animation animation;
  final String refNumber;

  const BlueInfoBarStoreRelatedView({Key key, this.animationController, this.animation,this.refNumber})
      : super(key: key);



  @override
  Widget build(BuildContext context) {
    HelperClass _helperClass = new HelperClass();
    return Provider(
        create: (context) => new AuthProvider(),
        child: AnimatedBuilder(
          animation: animationController,
          builder: (BuildContext context, Widget child) {
            return FadeTransition(
              opacity: animation,
              child: new Transform(
                transform: new Matrix4.translationValues(
                    0.0, 30 * (1.0 - animation.value), 0.0),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 24, right: 24, top: 16, bottom: 18),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        HexColor("#5d39fe"),
                        HexColor("#fe4343")
                      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          bottomLeft: Radius.circular(8.0),
                          bottomRight: Radius.circular(8.0),
                          topRight: Radius.circular(68.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: UserAppTheme.grey.withOpacity(0.6),
                            offset: Offset(1.1, 1.1),
                            blurRadius: 10.0),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'shareRefNumber'.tr(),
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: UserAppTheme.fontName,
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                              letterSpacing: 0.0,
                              color: UserAppTheme.white,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              'shareRefNumberAndThenStore'.tr(),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontFamily: UserAppTheme.fontName,
                                fontWeight: FontWeight.normal,
                                fontSize: 20,
                                letterSpacing: 0.0,
                                color: UserAppTheme.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(child:Padding(
                                padding: const EdgeInsets.only(right: 4),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(left: 4.0),
                                      child: Text(
                                        'refNumber'.tr(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: UserAppTheme.fontName,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          letterSpacing: 0.0,
                                          color: UserAppTheme.white,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: SizedBox(),
                                    ),
                                  ],
                                ),
                              )),
                              Expanded(child:Padding(
                                padding: const EdgeInsets.only(left: 0),
                                child:
                                GestureDetector(
                                  onTap: (){
                                    ClipboardManager.copyToClipBoard( '$refNumber').then((result) {
                                      _helperClass.showSuccessAlert(context,'successfullyCopied',() => CheckStatusScreen());
                                    });
                                  },
                                  child: new Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(left: 4.0),
                                        child: Text(
                                          '$refNumber',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: UserAppTheme.fontName,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            letterSpacing: 0.0,
                                            color: UserAppTheme.white,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 4),
                                        child: Icon(
                                          Icons.content_copy,
                                          color: UserAppTheme.white,
                                          size: 16,
                                        ),
                                      ),
                                      Expanded(
                                        child: SizedBox(width: 250),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        )
    );
  }
}
