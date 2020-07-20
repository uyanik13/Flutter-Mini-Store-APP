import 'dart:io';
import 'package:flutter/material.dart';
import 'package:store_app/providers/store_provider.dart';
import 'dart:async';
import 'dart:io' show Platform;
import 'dart:ui';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:store_app/screens/main_screens/check_status_screen.dart';
import 'package:store_app/screens/main_screens/onboarding_screen.dart';
import 'package:store_app/screens/main_screens/welcome_page/welcome_screen.dart';
import 'package:store_app/providers/auth_provider.dart';
import 'package:store_app/providers/invoice_provider.dart';
import 'package:store_app/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_app/screens/user_screens/tabs/user_invoice_item_tab_with_fcm.dart';

import 'config.dart';

void main() {
  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
  ChangeNotifierProvider(create: (_) => UserProvider(_.read<AuthProvider>().token),lazy: false),
  ChangeNotifierProvider(create: (_) => StoreProvider(_.read<AuthProvider>().token),lazy: false),
          ],
          child: EasyLocalization(
            child: Router(),
            supportedLocales: [Locale('en', 'US'), Locale('tr', 'TR')],
            path: 'assets/i18n',
          ))
  );
}

class Router extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, user, child) {
        switch (user.status) {
          case Status.Uninitialized:
            return MaterialApp(
              home: context.watch<AuthProvider>().onBoardingScreen == true ? WelcomeScreen(): OnBoardingScreen(),
            );
          case Status.Unauthenticated:
            return MaterialApp(
              home: WelcomeScreen(),
            );
          case Status.Authenticated:
            return ChangeNotifierProvider(
              create: (context)  => InvoiceProvider(context.read<AuthProvider>().token),
              lazy: false,
              child: StoreApp(),
            );
          default:
            return MaterialApp(
              home: WelcomeScreen(),
            );
        }
      },
    );
  }
}

class StoreApp extends StatefulWidget {
  static final navKey = new GlobalKey<NavigatorState>();
  static final scaffoldKey = new GlobalKey<ScaffoldState>();
  static _StoreAppState of(BuildContext context) =>
      // ignore: deprecated_member_use
  context.ancestorStateOfType(const TypeMatcher<_StoreAppState>());
  const StoreApp({Key navKey}) : super(key: navKey);

  @override
  _StoreAppState createState() => _StoreAppState();
}

class _StoreAppState extends State<StoreApp> {
  int _selectedDrawerItem = 0;

  /// Firebase messaging
  static FirebaseMessaging firebaseMessaging = new FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    _initPushNotifications();
    //_initAdMob();
  }


  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      navigatorKey: StoreApp.navKey,
      title: 'appName'.tr(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        EasyLocalization.of(context).delegate,
      ],
      supportedLocales: EasyLocalization.of(context).supportedLocales,
      locale: EasyLocalization.of(context).locale,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CheckStatusScreen(),
    );
  }

  /// Returns index of selected item in drawer
  int getSelected() {
    return _selectedDrawerItem;
  }

  /// Updates index of selected item in drawer
  void setSelected(int index) {
    _selectedDrawerItem = index;
  }

  /// init push notifications
  Future<void> _initPushNotifications() async {
    if (!Config.pushNotificationsEnabled) {
      return;
    }

    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
        message['data']['id'] != null ? _processPushNotificationInvoice(message) : _processPushNotification(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
        message['data']['id'] != null ? _processPushNotificationInvoice(message) : _processPushNotification(message) ;
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
       message['data']['id'] != null ? _processPushNotificationInvoice(message) : _processPushNotification(message) ;
      },
    );

    if (Platform.isIOS) {
      iOSPermission();
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    firebaseMessaging.getToken().then((token) {
      if (prefs.getBool('isPushNotificationEnabled') ?? true) {
        setSubscription(true);
      }
    });
  }

  void _processPushNotificationInvoice(payload) async {
    final context = StoreApp.navKey.currentState.overlay.context;
    int invoiceID = int.parse(payload['data']['id']);
    try {
      //print('||||===== DEBUG [LARAVEL TOKEN FROM FCM - MAIN.DART] = ${authServiceProvider.token} ===|||');
      // print('||||===== DEBUG [USER ROLE TOKEN FROM FCM - MAIN.DART] = ${authServiceProvider.user.role} ===|||');
      Alert(
          context: context,
          style: Config.alertStyle,
          type: AlertType.success,
          title: 'youHaveNewInvoice'.tr(),
          desc: payload['notification']['body'],
          buttons: [
            DialogButton(
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return UserInvoiceItemTabWithFcm(id:invoiceID);
                    },
                  ),
                )
              },
              child: Text(
                'show',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ).tr(),
            ),
            DialogButton(
              onPressed: () => Navigator.pop(context),
              color: Colors.black87,
              child: Text(
                'close',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ).tr(),
            )
          ]).show();
    } catch (exception) {
      Navigator.of(context, rootNavigator: true).pop('dialog');
      Alert(
          context: context,
          style: Config.alertStyle,
          type: AlertType.info,
          title: 'warning'.tr(),
          desc: 'somethingWentWrong'.tr())
          .show();
    }
  }

  void _processPushNotification(payload) async {
    final context = StoreApp.navKey.currentState.overlay.context;
    try {
      //print('||||===== DEBUG [LARAVEL TOKEN FROM FCM - MAIN.DART] = ${authServiceProvider.token} ===|||');
      // print('||||===== DEBUG [USER ROLE TOKEN FROM FCM - MAIN.DART] = ${authServiceProvider.user.role} ===|||');
      Alert(
          context: context,
          style: Config.alertStyle,
          type: AlertType.success,
          title: payload['notification']['title'],
          desc: payload['notification']['body'],
          buttons: [
            DialogButton(
              onPressed: () => Navigator.pop(context),
              color: Colors.black87,
              child: Text(
                'close',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ).tr(),
            )
          ]).show();
    } catch (exception) {
      Navigator.of(context, rootNavigator: true).pop('dialog');
      Alert(
          context: context,
          style: Config.alertStyle,
          type: AlertType.info,
          title: 'warning'.tr(),
          desc: 'somethingWentWrong'.tr())
          .show();
    }
  }


  /// ask for permission on iOS
  void iOSPermission() {
    firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }

  setSubscription(value) {
    value ? _subscribe() : _unsubscribe();
    _setSettingToStorage(value);
  }

  static _subscribe() {
    firebaseMessaging.subscribeToTopic('dro_app');
  }

  static _unsubscribe() {
    firebaseMessaging.unsubscribeFromTopic('dro_app');
  }

  static void _setSettingToStorage(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isPushNotificationEnabled', value);
  }

 /* /// Init AdMob
  _initAdMob() {
    if (!Config.adMobEnabled) {
      return;
    }

    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    FirebaseAdMob.instance.initialize(
        appId: isIOS ? Config.adMobIOSAppID : Config.adMobAndroidID);

    BannerAd myBanner = BannerAd(
      adUnitId: BannerAd.testAdUnitId,
      size: AdSize.smartBanner,
      listener: (MobileAdEvent event) {
        print("BannerAd event is $event");
      },
    );

    /// load banner
    myBanner
      ..load()
      ..show(
          anchorType: Config.adMobPosition != 'top'
              ? AnchorType.bottom
              : AnchorType.top);
  }*/
}



class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
