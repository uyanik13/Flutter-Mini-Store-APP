import 'package:store_app/models/tabIcon_data.dart';
import 'package:store_app/screens/main_widgets/drawer.dart';
import 'package:store_app/screens/store_screens/tabs/store_debs_tab.dart';
import 'package:store_app/screens/store_screens/tabs/store_profile_tab.dart';
import 'package:store_app/screens/store_screens/tabs/store_related_tab.dart';
import 'package:store_app/utils/styles/user_app_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'views/bottom_bar_view.dart';
import 'tabs/store_home_tab.dart';

class StoreHomeScreen extends StatefulWidget {
  @override
  _StoreHomeScreen createState() => _StoreHomeScreen();
}

class _StoreHomeScreen extends State<StoreHomeScreen>
    with TickerProviderStateMixin {
  AnimationController animationController;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    color: UserAppTheme.background,
  );

  @override
  void initState() {
    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    tabIconsList[0].isSelected = true;

    animationController = AnimationController(duration: const Duration(milliseconds: 600), vsync: this);
    tabBody = StoreHomeTab();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      color: UserAppTheme.background,
      child: Scaffold(
        key: _scaffoldKey,
        drawer:DroDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: new IconButton(
            icon: new Icon(Icons.menu, color: Colors.deepPurple,),
            onPressed: () => _scaffoldKey.currentState.openDrawer(),
          ),
          title: Text("appName".tr(), style: TextStyle(fontSize: 16.0,
            fontWeight: FontWeight.w500,
            color: Colors.deepPurple),),
         /* actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search, color: Colors.red), onPressed: () {},),
            IconButton(icon: Icon(Icons.notifications, color: Colors.red),
              onPressed: () {},)
          ],*/
        ),
        backgroundColor: Colors.transparent,
        body: FutureBuilder<bool>(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            } else {
              return Stack(
                children: <Widget>[
                  tabBody,
                  bottomBar(),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  Widget bottomBar() {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        BottomBarView(
          tabIconsList: tabIconsList,
          changeIndex: (int index) {
          switch (index) {
            case (0):
              animationController.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      StoreHomeTab(animationController: animationController);
                });
              });
              break;
            case (1):
              animationController.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      StoreDebsTab(animationController: animationController);
                });
              });
              break;
            case (2):
              animationController.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      StoreRelatedTab(animationController: animationController);
                });
              });
              break;
            case (3):
              animationController.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      StoreProfileTab();
                });
              });
              break;
            default:
              animationController.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      StoreHomeTab(animationController: animationController);
                });
              });
            }
          },
        ),
      ],
    );
  }
}
