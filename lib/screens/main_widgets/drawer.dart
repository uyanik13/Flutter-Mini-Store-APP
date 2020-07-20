import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:store_app/providers/auth_provider.dart';
import 'package:store_app/screens/main_screens/about_screen.dart';
import 'package:store_app/screens/main_screens/help_screen.dart';
import 'package:store_app/screens/main_screens/check_status_screen.dart';
import 'package:store_app/screens/store_screens/my_customers_screen.dart';

import '../../main.dart';



class DrawerItem {
  final String title;
  final IconData icon;
  final String role;
  final Function page;

  DrawerItem(this.title, this.icon,this.role, this.page);
}

class DroDrawer extends StatefulWidget {

  @override
  _DroDrawer createState() => _DroDrawer();
}

class _DroDrawer extends State<DroDrawer> {


  @override
  void dispose() {
    super.dispose();
    ///provider dipsose
  }

  @override
  Widget build(BuildContext context) {
    final  _authProvider =  context.watch<AuthProvider>();
    int selectedIndex = StoreApp.of(context).getSelected();
     final List<DrawerItem> drawerItems = [
      DrawerItem('homeMenu'.tr(), FontAwesomeIcons.home, 'user',() => CheckStatusScreen()),
      DrawerItem('debtIncOrDec'.tr(), Icons.note_add, 'store', () => MyCustomersScreen()),
      DrawerItem('helpMenu'.tr(), Icons.supervised_user_circle, 'user', () => HelpScreen()),
      DrawerItem('aboutUsMenu'.tr(), FontAwesomeIcons.infoCircle,  'user', () => AboutScreen()),
      DrawerItem('logoutMenu'.tr(), Icons.power_settings_new,  'user', () => context.read<AuthProvider>().logOut())
    ];

    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.white),
      child: Drawer(
        child: (  Row(
              children: [
                 Expanded(
                    child: Column(
                      children: [
                           UserAccountsDrawerHeader(
                                accountName: Text('${_authProvider.user?.name}'),
                                accountEmail: Text('${_authProvider?.user?.email}'),
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.topRight,
                                        end: Alignment.bottomLeft,
                                        colors: [Colors.blue, Colors.green])),
                                currentAccountPicture: CircleAvatar(
                                  child: Text(
                                    toBeginningOfSentenceCase(_authProvider?.user?.name[0]),
                                    style: TextStyle(fontSize: 40.0),
                                  ),
                                ),
                              ),
                           ListView(
                                shrinkWrap: true,
                                children: drawerItems.map((DrawerItem item) {
                                   int index = drawerItems.indexOf(item);
                                   return _authProvider.user?.role == 'user' && item.role =='store'
                                       ? Text('')
                                       :Container(
                                    height: 50.0,
                                    margin: EdgeInsets.only(right: 50.0),
                                    decoration: BoxDecoration(
                                      color: index == selectedIndex
                                          ? Colors.deepPurple
                                          : Color(0x00282C39),
                                      borderRadius:
                                      BorderRadius.horizontal(right: Radius.circular(25)),
                                    ),
                                    child:  ListTile(
                                      leading: Icon(
                                        item.icon,
                                        size: 20.0,
                                        color: index == selectedIndex
                                            ? Colors.white
                                            : Colors.deepPurple,
                                      ),
                                      title:Text(
                                        item.title,
                                        style: TextStyle(
                                          color: index == selectedIndex
                                              ? Colors.white
                                              : Color(0xFF7F7E96),
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      onTap: () {
                                        //Navigator.pop(context);
                                        StoreApp.of(context).setSelected(index);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return item.page();
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                }).toList(),
                              ),
              ]
                    ),
            ),
          ],
        )
      ),
        ));
  }
}
