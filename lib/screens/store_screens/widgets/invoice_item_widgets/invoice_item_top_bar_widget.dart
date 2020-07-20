import 'package:flutter/material.dart';
import 'package:store_app/utils/styles/user_app_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../main.dart';

class InvoiceItemTopBarWidget extends StatelessWidget {
  final AnimationController animationController;
  final Animation animation;
  final dynamic invoice;
  const InvoiceItemTopBarWidget({Key key, this.animationController, this.animation,this.invoice})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 30 * (1.0 - animation.value), 0.0),
            child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left:5,right:5,top:5,bottom:5),
                    alignment:Alignment.centerLeft,
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left:10,top:10,bottom:5,right:10),
                          child:Text(
                            'invoiceName'.tr(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: UserAppTheme.fontName,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: UserAppTheme.nearlyDarkBlue,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:10,bottom:10,right:10),
                          child:Text(
                            '${invoice['name']}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: UserAppTheme.fontName,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: HexColor('#fe4343'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left:5,right:5,top:5,bottom:5),
                    alignment:Alignment.centerLeft,
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left:10,top:10,bottom:5,right:10),
                          child:Text(
                            'invoiceDesc'.tr(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: UserAppTheme.fontName,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: UserAppTheme.nearlyDarkBlue,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:8,bottom:10,right:2),
                          child:Text(
                            '${invoice['description']}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: UserAppTheme.fontName,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: HexColor('#fe4343'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left:5,right:5,top:5,bottom:5),
                    alignment:Alignment.centerLeft,
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left:10,top:10,bottom:5,right:10),
                          child:Text(
                            'invoicePrice'.tr(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: UserAppTheme.fontName,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: UserAppTheme.nearlyDarkBlue,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:10,bottom:10,right:10),
                          child:Text(
                            '${invoice['price']}₺',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: UserAppTheme.fontName,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: HexColor('#fe4343'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left:5,right:5,top:5,bottom:5),
                    alignment:Alignment.centerLeft,
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left:10,top:10,bottom:5,right:10),
                          child:Text(
                            'invoiceDateUser'.tr(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: UserAppTheme.fontName,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: UserAppTheme.nearlyDarkBlue,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:10,bottom:10,right:10),
                          child:Text(
                            '${invoice['date_of_invoice']}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: UserAppTheme.fontName,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: HexColor('#fe4343'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
            ),
          ),
        );
      },
    );
  }
}
