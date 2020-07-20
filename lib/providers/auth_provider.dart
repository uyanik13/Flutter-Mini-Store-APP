import 'dart:async';
import 'dart:convert';
import 'dart:io';


import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_app/constants/constants.dart';
import 'package:store_app/models/user_model_files/user_model.dart';
import 'package:store_app/screens/main_screens/welcome_page/welcome_screen.dart';
import 'package:store_app/utils/helpers/helpers.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

enum Role { Admin, Store, User ,Guest}

enum UserStatus { Active,Inactive,Uninitialized,}



class AuthProvider with ChangeNotifier  {

  static FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
  static HelperClass _helperClass = new HelperClass();


  AuthProvider() {
    initProvider();
  }

  bool _onBoardingScreen = false;
  Status _status = Status.Uninitialized;
  Role _role = Role.Guest;
  UserStatus _userStatus = UserStatus.Uninitialized;
  bool _tokenIsAvailable;
  bool _rememberMe = false;
  bool _loading = false;
  String _token;
  UserModel _user;




  String get token => _token;
  Status get status => _status;
  UserStatus get userStatus => _userStatus;
  Role get role => _role;
  bool get tokenIsAvailable => _tokenIsAvailable;
  bool get onBoardingScreen => _onBoardingScreen;
  bool get rememberMe => _rememberMe;
  bool get loading => _loading;
  UserModel get user => _user;





  initProvider() async {
    //String token = 'sfasfasfasfasf335235'; //TEST
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString("user_api_token");
    final onBoardingScreen = sharedPreferences.getBool("onBoardingScreen");
    _onBoardingScreen = onBoardingScreen;
    UserModel user = await currentUser(token);
    bool tokenIsAvailable = await userTokenIsAvailable() ?? false;
    if (tokenIsAvailable) {
      _token = token;
      _user = user;
      _status = Status.Authenticated;
      user.role == 'store' ? _role = Role.Store : user.role == 'admin' ? _role = Role.Admin : _role = Role.User;
      user.status == '1' ? _userStatus = UserStatus.Active : _userStatus = UserStatus.Inactive ;
      //print('||||===== DEBUG [authservice ] =TOKEN IS AVAILABLE ===|||');
      notifyListeners();
    } else {
      logOut();
      notifyListeners();
    }
    notifyListeners();
  }


  Future<Map>login(BuildContext context,Map body) async {
    _loading = true;
    notifyListeners();
    final response = await http.post(APIUrls.LOGIN_URL,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          'Accept': 'application/json'
        },
        body: jsonEncode(body));
    Map responseJson = jsonDecode(response.body);
   // print('||||===== DEBUG [LOGIN DATA] = ${(responseJson)} ===|||');
    if (response.statusCode == 422 ) {
      if(responseJson['errors'].containsKey('notVerified')){
        _loading = false;
        _helperClass.showErrorAlert(context,'yourAccountNotActivated');
        notifyListeners();
      }else {
        _loading = false;
        _helperClass.showErrorAlert(context,'credentialsDoNotMatch');
        notifyListeners();
      }
      _loading = false;
      notifyListeners();
      return responseJson;
    }else if (response.statusCode <= 401 || response.statusCode >= 200) {
      //print('||||===== DEBUG [LOGIN DATA] = ${(responseJson)} ===|||');
      await saveUserTokenApi(responseJson['access_token']);
      await currentUser(responseJson['access_token']);
      initProvider();
      firebaseMessaging.getToken().then((deviceToken) async{
        await updateDeviceToken({"device_token": deviceToken});
        notifyListeners();
      });
      _loading = false;
      notifyListeners();
      return responseJson;
    }
    _loading = false;
    notifyListeners();
    return responseJson;
  }


  Future<dynamic> register(BuildContext context,{Map body}) async {
   _loading = true;
   notifyListeners();
    final response = await http.post(APIUrls.REGISTER_URL,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          'Accept': 'application/json'
        },
        body: json.encode(body));
    final responseJson = jsonDecode(response.body);
   print('||||===== DEBUG [REGISTER DATA - STATUS] = ${response.statusCode} ===|||');
    if (response.statusCode == 422 ) {
     if(responseJson['errors'].containsKey('email')){
      print('||||===== DEBUG [REGISTER DATA - ERROR] = ${responseJson['errors']} ===|||');
      _loading = false;
      _helperClass.showErrorAlert(context,'alreadyHaveAnEmailErrorText');
      notifyListeners();
    }
    }else if (response.statusCode <= 401 || response.statusCode >= 200) {
      _loading = false;
     _helperClass.showSuccessAlert(context,'successfullyAccountCreated',() => WelcomeScreen());
      notifyListeners();
      return responseJson;
    }
    return responseJson;
  }



  Future<dynamic> currentUser(String token) async {
    //print('||||===== DEBUG [getCurrentUser - TOKEN] = $token ===|||');
    final url = APIUrls.CURRENT_USER_URL;
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'bearer $token'
    });
    Map userDataJson = json.decode(response.body);
    //print('||||===== DEBUG [getCurrentUser - RESPONSE] = ${response.body} ===|||');
    //print('||||===== DEBUG [getCurrentUser - RESPONSE STATUS CODE] = ${response.statusCode} ===|||');
    if (response.statusCode < 401 || response.statusCode >= 200) {
      this._user = UserModel.fromJson(userDataJson);
      this._status = Status.Authenticated;
      notifyListeners();
      return UserModel.fromJson(userDataJson);
    } else if (response.statusCode == 401) {
      logOut();
      notifyListeners();
      return false;
    }
  }



  Future<Map> updateDeviceToken(Map body) async{
    final url = APIUrls.UPDATE_DEVICE_TOKEN_URL;
    final response = await http.post(url, body: json.encode(body), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'bearer $token'
    });
    if(response.statusCode <= 401 || response.statusCode >= 200) {
      Map result = json.decode(response.body);
      // print("status code : ${response.statusCode} | ${response.body} ");
      return result;
    }
      return throw('error');
  }


  Future<bool> userTokenIsAvailable() async {
    final url = APIUrls.CURRENT_USER_URL;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString("user_api_token");
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'bearer $token'
    });
    //print('||||===== DEBUG [userTokenApiIsAvailable TOKEN] = $token ===|||');
    //print('||||===== DEBUG [userTokenApiIsAvailable STATUS] = ${response.statusCode} ===|||');
    if (response.statusCode == 401) {
      this._tokenIsAvailable = false;
      logOut();
      notifyListeners();
      return false;
    }
    this._tokenIsAvailable = true;
    notifyListeners();
    return true;

  }


  Future<bool> saveUserTokenApi(dynamic response) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool result = await sharedPreferences.setString("user_api_token", response);
    _token = response;
    notifyListeners();
    return result;
  }




  Future<bool>logOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await updateDeviceToken({"device_token": '000000000'});
    sharedPreferences.remove('user_api_token');
    _status = Status.Unauthenticated;
    _role = Role.Guest;
    _loading = false;
    _user = null;
    _token = null;
    notifyListeners();
    return true;
  }

  Future<Map> forgotPassword(context,{Map body}) async {
        _loading = true;
        notifyListeners();
    final response = await http.post(APIUrls.FORGOT_PASSWORD_URL,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          'Accept': 'application/json'
        },
        body: jsonEncode(body));
    Map responseJson = jsonDecode(response.body);
    if (response.statusCode <= 401 || response.statusCode >= 200) {
      _loading = false;
      _helperClass.showSuccessAlert(context,'Check_your_email_to_reset_your_password',() => WelcomeScreen());
      notifyListeners();
      return responseJson;
    }
    _loading = false;
    notifyListeners();
    return responseJson;
  }


}


/* void _autoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), () => logOut);
  }*/