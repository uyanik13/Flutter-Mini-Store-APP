import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:store_app/constants/constants.dart';
import 'package:store_app/providers/auth_provider.dart';


class ApiService {

  static AuthProvider _authProvider = AuthProvider();
  String token = _authProvider.token;

    /// GET METHOD FOR SERVICES
  Future<dynamic> get(String endPoint) async {
    //print('||||===== DEBUG [GET METHOD] = $body ===|||');
    final url = Constants.RestApiUrl+'$endPoint';
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'bearer $token'
    });
    final result = json.decode(response.body);
    if (response.statusCode == 422 ) {
      return result;
    }
    if (response.statusCode <= 401 || response.statusCode >= 200) {
      return result;
    }
    return result;
  }

  /// POST METHOD FOR SERVICES
  Future<dynamic> post(String endPoint,{Map body} ) async {
    //print('||||===== DEBUG [POST METHOD] = $body ===|||');
    final url = Constants.RestApiUrl+'$endPoint';
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'bearer $token'
    };
    final response = await http.post(url, body: json.encode(body), headers: headers);
    final result = json.decode(response.body);
    if (response.statusCode == 422 ) {
      return result;
    }
    if (response.statusCode <= 401 || response.statusCode >= 200) {
      return result;
    }
    return result;
  }

  /// PUT METHOD FOR SERVICES
  Future<dynamic> put(String endPoint,int id,{Map body} ) async {
    //print('||||===== DEBUG [PUT METHOD] = $body ===|||');
    final url = Constants.RestApiUrl+'$endPoint'+ '/$id';
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'bearer $token'
    };
    final response = await http.put(url, body: json.encode(body), headers: headers);
    final result = json.decode(response.body);
    if (response.statusCode == 422 ) {
      return result;
    }
    if (response.statusCode <= 401 || response.statusCode >= 200) {
      return result;
    }
    return result;
  }

  /// DELETE METHOD FOR SERVICES
  Future<dynamic> delete(String endPoint,int id) async {
    //print('||||===== DEBUG [DELETE METHOD] = $body ===|||');
    final url = Constants.RestApiUrl+'$endPoint'+ '/$id';
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'bearer $token'
    };
    final response = await http.delete(url, headers: headers);
    final result = json.decode(response.body);
    if (response.statusCode == 422 ) {
      return result;
    }
    if (response.statusCode <= 401 || response.statusCode >= 200) {
      return result;
    }
    return result;
  }



}