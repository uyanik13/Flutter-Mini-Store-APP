import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:store_app/providers/invoice_provider.dart';
import 'package:store_app/providers/auth_provider.dart';
import 'package:store_app/screens/main_widgets/drawer.dart';
import 'package:store_app/screens/main_widgets/loading.dart';

import 'package:store_app/utils/styles/user_app_theme.dart';

import '../../../main.dart';

class UserInvoiceItemTabWithFcm extends StatefulWidget {
  const UserInvoiceItemTabWithFcm({Key key, this.id}) : super(key: key);
  final int id;
  @override
  _UserInvoiceItemTabWithFcm createState() => _UserInvoiceItemTabWithFcm();
}

class _UserInvoiceItemTabWithFcm extends State<UserInvoiceItemTabWithFcm> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();



  @override
  void initState() {
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
        future: context.watch<InvoiceProvider>().fetchInvoice(widget?.id,context.watch<AuthProvider>().token),
        builder: (context, snapshot) {
    if (snapshot.hasData) {
          //print('SNAPSHOT ${snapshot.data}');
           var invoice = (snapshot?.data) ?? false;
            return Scaffold(
                key: _scaffoldKey,
                drawer:DroDrawer(),
              appBar: AppBar(
                backgroundColor: Colors.white,
                leading: new IconButton(
                  icon: new Icon(Icons.menu, color: Colors.deepPurple,),
                  onPressed: () => _scaffoldKey.currentState.openDrawer(),
                ),
                title: Text("yourInvoicesDetail".tr(), style: TextStyle(fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.deepPurple),),
              ),
              body: Column(
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
                            '${invoice.name}',
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
                            '${invoice.description}',
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
                            '${invoice.usagePrice}₺',
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
                            '${invoice.dateOfInvoice}',
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
                  GestureDetector(
                      onTap: ()  {
                        Navigator.pop(context);
                      },
                      child:Stack(
                        overflow: Overflow.visible,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 16, bottom: 16),
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
                              child: Stack(
                                alignment: Alignment.topLeft,
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                                    child: SizedBox(
                                      height: 74,
                                      child: AspectRatio(
                                        aspectRatio: 1.714,
                                        child: Image.asset(
                                            "assets/images/app/back.png"),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 140,
                                              right: 16,
                                              top: 24,
                                            ),
                                            child: Text(
                                              "GoBack".tr(),
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontFamily:
                                                UserAppTheme.fontName,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 24,
                                                letterSpacing: 0.0,
                                                color:
                                                UserAppTheme.nearlyDarkBlue.withOpacity(0.8),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: -16,
                            left: 0,
                            child: SizedBox(
                              width: 110,
                              height: 110,
                              child: Image.asset("assets/images/app/runner.png"),
                            ),
                          )
                        ],
                      )),
                ],
              ),
            );
          }
           return Center(child:Loading());
        }
    );
  }

}
