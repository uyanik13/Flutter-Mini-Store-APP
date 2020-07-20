import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:store_app/constants/constants.dart';
import 'package:store_app/models/user_model_files/setting_model.dart';
import 'dart:io';


import 'auth_provider.dart';

class SettingProvider   with ChangeNotifier {
  static AuthProvider _authProvider = new AuthProvider();
  final String token = _authProvider.token;


// ===============================================================
// =====================   FETCH SETTINGS  =============================
// ===============================================================


  Future <SettingsList> fetchSettings() async {
    String url = '${APIUrls.FETCH_SETTINGS_URL}';
    final response = await http.get(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        'Authorization': 'bearer $token',
      },
    );
    //print('||||===== DEBUG [fetchInvoice] = ${response.body} ===|||');
    if (response.statusCode <= 401 || response.statusCode >= 200) {
      SettingsList settingList = settingsListFromJson(response.body);
      notifyListeners();
      return settingList;
    }
    throw Exception("faild to load api");
  }

// ===============================================================
// =====================   UPDATE SETTING  =============================
// ===============================================================

  Future<Map> updateSetting({Map body}) async {
    //print('||||===== DEBUG [INVOICE LIST DATA] = ${body} ===|||');
    final url = APIUrls.ADD_SETTINGS_URL;
    final response = await http.post(url, body: json.encode(body), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'bearer $token'
    });
    if (response.statusCode <= 401 || response.statusCode >= 200) {
      Map result = json.decode(response.body);
      print("status code : ${response.statusCode} | ${response.body} ");
      notifyListeners();
      return result;
    }

    throw Exception("faild to create order");
  }

// ===============================================================
// ===================== DELETE SETTINGS =============================
// ===============================================================

  Future<Map> deleteSetting({Map body}) async {
    print("this is map : $body");

    final url = APIUrls.DELETE_SETTING_URL;
    final response = await http.post(url, body: json.encode(body), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'bearer $token'
    });
    if (response.statusCode <= 401 || response.statusCode >= 200) {
      Map result = json.decode(response.body);
      print("status code : ${response.statusCode} | ${response.body} ");
      notifyListeners();
      return result;
    }

    throw Exception("faild to create order");
  }

}