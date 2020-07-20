import 'package:store_app/screens/user_screens/tabs/user_invoice_item_tab.dart';
import 'package:store_app/utils/styles/user_app_theme.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';


class StoreInvoiceListView extends StatelessWidget {
  const StoreInvoiceListView(
      {Key key,
      this.invoice,
      this.animationController,
      this.animation,
      this.callback})
      : super(key: key);

  final VoidCallback callback;
  final dynamic invoice;
  final AnimationController animationController;
  final Animation<dynamic> animation;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child:AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 0, bottom: 16),
              child: InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              UserInvoiceItemTab(animationController: animationController,invoice:invoice)
                      ));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: UserAppTheme.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8.0),
                        bottomRight: Radius.circular(8.0),
                        topRight: Radius.circular(8.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: UserAppTheme.grey.withOpacity(0.4),
                          offset: Offset(1.1, 1.1),
                          blurRadius: 10.0),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    child: Stack(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Container(
                              color: UserAppTheme.buildLightTheme()
                                  .backgroundColor,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 16, top: 8, bottom: 8),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              invoice['name'].toString().length >= 28 ? invoice['name'].toString().substring(0,28) : invoice['name'],
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontFamily:
                                                UserAppTheme.fontName,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15,
                                                letterSpacing: 0.0,
                                                color:UserAppTheme.nearlyDarkBlue.withOpacity(0.8),
                                              ),
                                            ),

                                            Padding(
                                              padding:
                                              const EdgeInsets.only(top: 4),
                                              child:  Row(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    invoice['description'].toString().length >= 35 ? invoice['description'].toString().toString().substring(0,35) : invoice['description'],
                                                    style: TextStyle(
                                                        fontSize: 11,
                                                        color: Colors.grey
                                                            .withOpacity(0.8)
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 16, top: 16),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Text(
                                          '${invoice['price']}₺',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontFamily:
                                            UserAppTheme.fontName,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            letterSpacing: 0.0,
                                            color:HexColor('#ef2a2a'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    ));
  }
}
