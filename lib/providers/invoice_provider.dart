import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:store_app/constants/constants.dart';
import 'package:store_app/models/user_model_files/invoice_model.dart';
import 'package:store_app/utils/helpers/helpers.dart';
import 'auth_provider.dart';





class InvoiceProvider with ChangeNotifier {
  static HelperClass _helperClass = new HelperClass();
  static AuthProvider _authProvider = new AuthProvider();

  String token;

  InvoiceProvider(this.token){
    initProvider();
  }


  initProvider() async {
    _authProvider.userTokenIsAvailable();
    notifyListeners();
  }

  Future<dynamic> getInvoiceList(String token) async {
    final url = APIUrls.INVOICE_URL;
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'bearer $token'
    });

    //print('||||===== DEBUG [fetchInvoice] = ${response.body} ===|||');
    //print('||||===== DEBUG fetchInvoice token = $token ===|||');
    if (response.statusCode <= 401 || response.statusCode >= 200) {
      //print('||||===== DEBUG [fetchInvoice] = ${response.body} ===|||');
      //InvoicesList invoicesList = invoicesListFromJson(response.body);
      notifyListeners();
      return json.decode(response.body);
    }
    throw Exception("faild to load api");
  }


  Future <dynamic> fetchInvoice(int invoiceID,String token) async {
    String url = '${APIUrls.INVOICE_URL}/$invoiceID';
    final response = await http.get(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        'Authorization': 'bearer $token',
      },
    );
    final invoiceDataJson = json.decode(response.body);
    if (response.statusCode <= 401 || response.statusCode >= 200) {
      //print('||||===== DEBUG [fetchInvoice] = ${Invoice.fromJson(invoiceDataJson['data'])} ===|||');
      notifyListeners();
      return Invoice.fromJson(invoiceDataJson['data']);
    }
    throw Exception("faild to load api");
  }

  Future<dynamic> fetchInvoicesByOptions(String searchKey,String token) async {

    final url = APIUrls.FETCH_INVOICES_BY_OPTIONS_URL;
    final body = {'searchKey':searchKey};
    final response = await http.post(url, body: json.encode(body), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'bearer $token'
    });
    //print('||||===== DEBUG [INVOICE LIST DATA] = ${response.body} ===|||');

    if (response.statusCode <= 401 || response.statusCode >= 200) {
      // print('||||===== DEBUG [getInvoiceList] = ${response.body} ===|||');

      return json.decode(response.body);
    }
    throw Exception("faild to load api");
  }

// ===============================================================
// =====================   ADD ITEM  =============================
// ===============================================================

  Future<Map> addInvoice(BuildContext context, Map body,Function page) async {
    /*print("this is map : $body");
  print("this is token : $token");*/
    final url = APIUrls.INVOICE_URL;
    final response = await http.post(url, body: json.encode(body), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'bearer $token'
    });
    if (response.statusCode <= 401 || response.statusCode >= 200) {
      Map result = json.decode(response.body);
      _helperClass.showSuccessAlert(context,'shoppingSuccessfullyCreated',() => page());
      _authProvider.currentUser(token);
      notifyListeners();
      print('RESPONSE FROM STORE ADD === $result');
      return result;
    }

    throw Exception("faild to create order");
  }


// ===============================================================
// ===================== DELETE INVOICE ==========================
// ===============================================================

  Future<Map> deleteInvoice(int id) async {
    /*print("this is map : $body");
  print("this is token : $token");*/
    final url = APIUrls.INVOICE_URL + '/$id';
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'bearer $token'
    };
    final response = await http.delete(url, headers: headers);
    if (response.statusCode <= 401 || response.statusCode >= 200) {
      Map result = json.decode(response.body);
      print("status code : ${response.statusCode} | ${response.body} ");
      notifyListeners();
      return result;
    }

    throw Exception("faild to create order");
  }

// ===============================================================
// ===================== UPDATE INVOICE ==========================
// ===============================================================

  Future<Map> updateInvoice(int id, Map body) async {
    final url = APIUrls.INVOICE_URL + '/$id';
    final response = await http.put(url, body: json.encode(body), headers: {
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
