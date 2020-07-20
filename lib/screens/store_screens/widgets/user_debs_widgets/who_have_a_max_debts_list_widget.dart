import 'package:flutter/material.dart';
import 'package:store_app/screens/main_widgets/loading.dart';
import 'package:store_app/screens/store_screens/tabs/user_invoice_list_tab.dart';
import 'package:store_app/utils/styles/user_app_theme.dart';
import '../../../../main.dart';
import 'dart:async';
import 'dart:ui';
import 'package:provider/provider.dart';
import 'package:store_app/providers/store_provider.dart';



class WhoHaveMaxDebtsListWidget extends StatefulWidget {
  final AnimationController animationController;
  final Animation animation;

  const WhoHaveMaxDebtsListWidget({Key key, this.animationController, this.animation})
      : super(key: key);
  @override
  _WhoHaveMaxDebtsListWidget createState() => _WhoHaveMaxDebtsListWidget();
}

class _WhoHaveMaxDebtsListWidget extends State<WhoHaveMaxDebtsListWidget> with TickerProviderStateMixin {
  AnimationController animationController;
  final ScrollController _scrollController = ScrollController();
  StreamController _userStreamController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _userStreamController = new StreamController();
    loadInvoices(context);
  }


  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  loadInvoices(BuildContext context) async {
    context.read<StoreProvider>().getMaxDebtsUsers().then((res) async {
      //print('USERS ${res}');
      _userStreamController.add(res);
      return res;
    });
  }



  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _userStreamController?.stream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        //print('CONNECTION STATE ===  ${snapshot.connectionState}');
        if (snapshot.connectionState == ConnectionState.waiting || snapshot.connectionState == ConnectionState.none ) { return Center(child:Loading()); }
        if (snapshot.hasError) { return Text(snapshot.error); }
        if (snapshot.hasData) {
          return Container(
            color:Colors.transparent,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data.length,
              padding: const EdgeInsets.only(top: 8),
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                final int count = snapshot.data.length > 5 ? 5 : snapshot.data?.length;
                final Animation<double> animation =
                Tween<double>(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                        parent: animationController,
                        curve: Interval(
                            (1 / count) * index, 1.0,
                            curve: Curves.fastOutSlowIn)));
                animationController.forward();
                return WhoHaveMaxDebtsListBarWidget(
                  callback: () => {},
                  user: snapshot.data[index],
                  animation: animation,
                  animationController: animationController,
                );
              },
            ),
          );
        } return Center(child:Loading());
      },
    );
  }



}



class WhoHaveMaxDebtsListBarWidget extends StatelessWidget {
  const WhoHaveMaxDebtsListBarWidget(
      {Key key,
        this.user,
        this.animationController,
        this.animation,
        this.callback})
      : super(key: key);

  final VoidCallback callback;
  final dynamic user;
  final AnimationController animationController;
  final Animation<dynamic> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 25, right: 25, top: 0, bottom: 15),
              child: InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              UserInvoiceListTab(animationController: animationController,id:user['id'])
                      )
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
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
                                              user['name'],
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

                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 16, top: 8),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Text(
                                          '${user['user_total_debt']}₺',
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
    );
  }
}

