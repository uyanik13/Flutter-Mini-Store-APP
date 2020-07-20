import 'package:flutter/material.dart';
import 'package:store_app/screens/main_widgets/drawer.dart';
import 'package:store_app/screens/user_screens/widgets/invoice_item_widgets/invoice_bottom_info_bar_widget.dart';
import 'package:store_app/screens/user_screens/widgets/invoice_item_widgets/invoice_item_top_bar_widget.dart';
import 'package:store_app/utils/styles/user_app_theme.dart';
import 'package:easy_localization/easy_localization.dart';

class StoreInvoiceItemTab extends StatefulWidget {
  const StoreInvoiceItemTab({Key key, this.animationController,this.invoice}) : super(key: key);

  final AnimationController animationController;
  final dynamic invoice;
  @override
  _StoreInvoiceItemTab createState() => _StoreInvoiceItemTab();
}

class _StoreInvoiceItemTab extends State<StoreInvoiceItemTab>
    with TickerProviderStateMixin {
  Animation<double> topBarAnimation;

  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController,
            curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)));
    addAllListData();


    scrollController.addListener(() {
      if (scrollController.offset >= 24) {
        if (topBarOpacity != 1.0) {
          setState(() {
            topBarOpacity = 1.0;
          });
        }
      } else if (scrollController.offset <= 24 &&
          scrollController.offset >= 0) {
        if (topBarOpacity != scrollController.offset / 24) {
          setState(() {
            topBarOpacity = scrollController.offset / 24;
          });
        }
      } else if (scrollController.offset <= 0) {
        if (topBarOpacity != 0.0) {
          setState(() {
            topBarOpacity = 0.0;
          });
        }
      }
    });
    super.initState();
  }

  void addAllListData() {
    const int count = 9;
    listViews.add(
      InvoiceItemTopBarWidget(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController,
            curve:
                Interval((1 / count) * 1, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController,
        invoice:widget.invoice,
      ),
    );

    listViews.add(
      InvoiceBottomInfoBarWidget(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController,
            curve:
            Interval((1 / count) * 1, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController,
      ),
    );




  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: UserAppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        key: _scaffoldKey,
        drawer:DroDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: new IconButton(
            icon: new Icon(Icons.menu, color: Colors.deepPurple,),
            onPressed: () => _scaffoldKey.currentState.openDrawer(),
          ),
          title: Text("yourCustomersInvoicesDetail".tr(), style: TextStyle(fontSize: 16.0,
              fontWeight: FontWeight.w500,
              color: Colors.deepPurple),),
          /* actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search, color: Colors.red), onPressed: () {},),
            IconButton(icon: Icon(Icons.notifications, color: Colors.red),
              onPressed: () {},)
          ],*/
        ),
        body: Stack(
          children: <Widget>[
            getMainListViewUI(),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );
  }

  Widget getMainListViewUI() {
    return FutureBuilder<bool>(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        } else {
          return ListView.builder(
            controller: scrollController,
            padding: EdgeInsets.only(
              top: 20 ,
              bottom: 62 + MediaQuery.of(context).padding.bottom,
            ),
            itemCount: listViews.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              widget.animationController.forward();
              return listViews[index];
            },
          );
        }
      },
    );
  }

}
