
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/providers/auth_provider.dart';
import 'package:store_app/providers/store_provider.dart';
import 'package:store_app/providers/user_provider.dart';
import 'package:store_app/screens/main_screens/user_not_active_screen.dart';
import 'package:store_app/screens/main_screens/welcome_page/welcome_screen.dart';
import 'package:store_app/screens/main_widgets/loading.dart';
import 'package:store_app/screens/store_screens/store_home_screen.dart';
import 'package:store_app/screens/user_screens/user_home_screen.dart';
import 'package:store_app/utils/styles/app_theme.dart';
import 'package:easy_localization/easy_localization.dart';

class CheckStatusScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.white,
        body: Consumer<AuthProvider>(
          builder: (context, user, child) {
            print('USER Status=  ${user.userStatus}');
            switch (user.userStatus) {
              case UserStatus.Active:
                return MainHomePage();
              case UserStatus.Inactive:
                return UserNotActiveScreen();
              default:
                return MaterialApp(
                  home: Loading(),
                );
            }
          },
        )
    );
  }
}

class MainHomePage extends StatefulWidget {
  const MainHomePage({Key key}) : super(key: key);

  @override
  _MainHomePage createState() => _MainHomePage();
}

class _MainHomePage extends State<MainHomePage> with TickerProviderStateMixin {

  AnimationController animationController;
  bool multiple = true;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 0));
    return true;
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: Consumer<AuthProvider>(
        builder: (context, user, child) {
          print('USER ROLE =  ${user.role}');
          switch (user.role) {
            case Role.User:
              return ChangeNotifierProvider(
                create: (context)  => UserProvider(user.token),
                lazy: false,
                child: UserHomeScreen(),
              );
            case Role.Store:
              return ChangeNotifierProvider(
                create: (context)  => StoreProvider(user.token),
                lazy: false,
                child: StoreHomeScreen(),
              );
            case Role.Admin:
              return ChangeNotifierProvider(
                create: (context)  => AuthProvider(),
                lazy: false,
                child: StoreHomeScreen(),
              );
            case Role.Guest:
              return ChangeNotifierProvider(
                create: (context)  => AuthProvider(),
                lazy: false,
                child: WelcomeScreen(),
              );
            default:
              return MaterialApp(
                home: Loading(),
              );
          }
        },
      )
    );
  }

  Widget appBar() {
    return SizedBox(
      height: AppBar().preferredSize.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 8),
            child: Container(
              width: AppBar().preferredSize.height - 8,
              height: AppBar().preferredSize.height - 8,
            ),
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  'welcome'.tr(),
                  style: TextStyle(
                    fontSize: 22,
                    color: AppTheme.darkText,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, right: 8),
            child: Container(
              width: AppBar().preferredSize.height - 8,
              height: AppBar().preferredSize.height - 8,
              color: Colors.white,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius:
                      BorderRadius.circular(AppBar().preferredSize.height),
                  child: Icon(
                    multiple ? Icons.dashboard : Icons.view_agenda,
                    color: AppTheme.dark_grey,
                  ),
                  onTap: () {
                    setState(() {
                      multiple = !multiple;
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


