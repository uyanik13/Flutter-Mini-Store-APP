import 'dart:async';
import 'dart:ui';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:store_app/providers/auth_provider.dart';
import 'package:store_app/providers/invoice_provider.dart';
import 'package:store_app/screens/main_widgets/loading.dart';
import 'package:store_app/screens/user_screens/views/invoice_list_view.dart';
import 'package:store_app/utils/styles/user_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../main.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key key, this.animationController}) : super(key: key);
  final AnimationController animationController;
  @override
  _HomeTab createState() => _HomeTab();
}

class _HomeTab extends State<HomeTab> with TickerProviderStateMixin {
  TextEditingController _searchTextController = TextEditingController();
  AnimationController animationController;
  final RefreshController _refreshController = RefreshController();
  final ScrollController _scrollController = ScrollController();
  StreamController _invoiceStreamController;
  Timer _debounce;

  @override
  void initState() {
    super.initState();
      animationController = AnimationController(
          duration: const Duration(milliseconds: 1000), vsync: this);
      _invoiceStreamController = new StreamController();
      loadInvoices(context);
  }


  @override
  void dispose() {
    _scrollController.dispose();
    _refreshController.dispose();
    _searchTextController.dispose();
    super.dispose();
  }

  loadInvoices(BuildContext context) async {
    context.read<InvoiceProvider>().getInvoiceList(context.read<AuthProvider>().token).then((res) async {
      //print('INVOICES ${res['data']}');
      _invoiceStreamController.add(res['data']);
      return res;
    });
  }

  _search(BuildContext context) async {
    final  _invoiceProvider =  context.read<InvoiceProvider>();
    if (_searchTextController.text.toString() == null || _searchTextController.text.toString().length == 0) {
      loadInvoices(context);
    }
    _invoiceProvider.fetchInvoicesByOptions( _searchTextController.text.trim(),context.read<AuthProvider>().token).then((res) async {
      _invoiceStreamController.add(res['data']);
      return true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: UserAppTheme.buildLightTheme(),
      child: Container(
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: NestedScrollView(
                        controller: _scrollController,
                        headerSliverBuilder:
                            (BuildContext context, bool innerBoxIsScrolled) {
                          return <Widget>[
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                      (BuildContext context, int index) {
                                    return Column(
                                      children: <Widget>[
                                        getSearchBarUI(),
                                      ],
                                    );
                                  }, childCount: 1),
                            ),
                          ];
                        },
                        body:  SmartRefresher(
                          controller: _refreshController,
                          enablePullDown: true,
                          onRefresh: () async {
                            await Future.delayed(Duration(seconds: 1));
                            print("Refreshing...");
                            setState(() {
                              _refreshController.refreshCompleted();
                            });
                          },
                          child:StreamBuilder(
                          stream: _invoiceStreamController?.stream,
                          builder: (BuildContext context, AsyncSnapshot snapshot) {
                            //print('CONNECTION STATE ===  ${snapshot.connectionState}');
                            if (snapshot.connectionState == ConnectionState.waiting || snapshot.connectionState == ConnectionState.none ) { return Loading(); }
                            if (snapshot.hasError) { return Text(snapshot.error); }
                            if (snapshot.hasData) {
                              return Container(
                                color:UserAppTheme.buildLightTheme().backgroundColor,
                                child: ListView.builder(
                                  itemCount: snapshot.data.length,
                                  padding: const EdgeInsets.only(top: 8),
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (BuildContext context, int index) {
                                    final int count = snapshot.data.length > 20 ? 20 : snapshot.data?.length;
                                    final Animation<double> animation =
                                    Tween<double>(begin: 0.0, end: 1.0).animate(
                                        CurvedAnimation(
                                            parent: animationController,
                                            curve: Interval(
                                                (1 / count) * index, 1.0,
                                                curve: Curves.fastOutSlowIn)));
                                    animationController.forward();
                                    return InvoiceListView(
                                      callback: () => {},
                                      invoice: snapshot.data[index],
                                      animation: animation,
                                      animationController: animationController,
                                    );
                                  },
                                ),
                              );
                            } return Loading();
                          },
                        ))
                      )
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }



  Widget getSearchBarUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: UserAppTheme.buildLightTheme().backgroundColor,
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
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 4, bottom: 4),
                  child: TextFormField(
                    onChanged: (String text) {
                      if (_debounce?.isActive ?? false) _debounce.cancel();
                      _debounce = Timer(const Duration(milliseconds: 1000), () {
                        _search(context);
                      });
                    },
                    controller: _searchTextController,
                    decoration: InputDecoration(
                      hintText: "search".tr(),
                      contentPadding: const EdgeInsets.only(left: 24.0),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: UserAppTheme.nearlyDarkBlue,
              gradient: LinearGradient(
                  colors: [
                    UserAppTheme.nearlyDarkBlue,
                    HexColor('#6A88E5'),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),
              shape: BoxShape.circle,
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

                borderRadius: const BorderRadius.all(
                  Radius.circular(32.0),
                ),
                onTap: () {
                  _search(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(FontAwesomeIcons.search,
                      size: 20,
                      color: UserAppTheme.buildLightTheme().backgroundColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


}

class ContestTabHeader extends SliverPersistentHeaderDelegate {
  ContestTabHeader(
      this.searchUI,
      );
  final Widget searchUI;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return searchUI;
  }

  @override
  double get maxExtent => 52.0;

  @override
  double get minExtent => 52.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
