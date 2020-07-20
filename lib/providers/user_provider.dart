import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:store_app/constants/constants.dart';
import 'package:store_app/utils/helpers/helpers.dart';
import 'auth_provider.dart';
import 'dart:io';
import 'package:async/async.dart';

class UserProvider with ChangeNotifier {
  static HelperClass _helperClass = new HelperClass();
  static AuthProvider _authProvider = new AuthProvider();

  bool _loading = false;
  File _image;
  String token;

  bool get loading => _loading;
  File get image => _image;

  UserProvider(this.token){
    initProvider();
  }


  initProvider() async {
    _authProvider.userTokenIsAvailable();
    notifyListeners();
  }

// ===============================================================
// ===================== GET USERS   =============================
// ===============================================================

  Future<String> getUsers(String token) async {
    final url = APIUrls.USERS_URL;
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'bearer $token'
    });
    if (response.statusCode <= 401 || response.statusCode >= 200) {
      // JsonStorage jsonStorage = JsonStorage();
      //await jsonStorage.writeJsonFile(response.body);
      //UsersList usersList = usersListFromJson(response.body);
      var users = json.decode(response.body);
      //var users = usersData.toList();
      return users;
    } else {
      throw Exception("Can not get User Data from API");
    }
  }

  Future<Map> updateUser(BuildContext context,int id,Map body,String token,Function page) async {
    final url = APIUrls.USERS_URL + '/$id';
    final response = await http.put(url, body: json.encode(body), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'bearer $token'
    });
    if (response.statusCode <= 401 || response.statusCode >= 200) {
      Map result = json.decode(response.body);
      _loading = false;
      _helperClass.showSuccessAlert(context,'successfullyUpdated',() => page());
      notifyListeners();
      return result;
    }

    throw Exception("faild to create order");
  }


  Future<dynamic> updateUserImage(BuildContext context,String token,Function page) async {
    final url = APIUrls.USER_IMAGE_UPDATE_URL;
    // ignore: deprecated_member_use
    File imageFile =  await ImagePicker.pickImage(source: ImageSource.gallery);
    this._image = imageFile;
    notifyListeners();
    String base64Image = base64Encode(imageFile.readAsBytesSync());
    String fileName = imageFile.path.split("/").last;
    var stream =
    // ignore: deprecated_member_use
    new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    // get file length
    var length = await imageFile.length(); //imageFile is your image file
    Map<String, String> headers = {
    "Accept": "multipart/form-data",
    "Authorization": "bearer $token"
    }; // ignore this headers if there is no authentication

    // string to uri
    var uri = Uri.parse(url);

    // create multipart request
    var request = new http.MultipartRequest("POST", uri);

    // multipart that takes file
    var multipartFileSign = new http.MultipartFile('photo', stream, length,
    filename: basename(imageFile.path));

    // add file to multipart
    request.files.add(multipartFileSign);

    //add headers
    request.headers.addAll(headers);

    //adding params
    request.fields['image'] = base64Image;
    request.fields['name'] = fileName;
    // request.fields['lastName'] = 'efg';

    // send
    var response = await request.send();

    print(response.statusCode);

    // listen for response
    response.stream.transform(utf8.decoder).listen((value) {
    print(value);
    _helperClass.showSuccessAlert(context,'successfullyUpdated',() =>page());
    });

  }




  Future<dynamic> getOnlyOneUser(String userId,String token) async {
    final url = APIUrls.USERS_URL + '/$userId';
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'bearer $token'
    });
    if (response.statusCode <= 401 || response.statusCode >= 200) {
      // JsonStorage jsonStorage = JsonStorage();
      //await jsonStorage.writeJsonFile(response.body);
      //UsersList usersList = usersListFromJson(response.body);
      var users = jsonDecode(response.body);
      //print('||||===== DEBUG [INVOICE LIST DATA] = ${users} ===|||');
      return users;
    } else {
      throw Exception("Can not get User Data from API");
    }
  }

  Future<dynamic> currentUser(String token) async {
    print('||||===== DEBUG [getCurrentUser - TOKEN] = $token ===|||');
    final url = APIUrls.CURRENT_USER_URL;
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'bearer $token'
    });
    //print('||||===== DEBUG [getCurrentUser - RESPONSE] = ${response.statusCode} ===|||');
    if (response.statusCode <= 401 || response.statusCode >= 200) {
      Map userDataJson = json.decode(response.body);
      return userDataJson;
    } else {
      return response.body;
    }
  }

Future<dynamic> currentUserSettings(String token) async {
  //print('||||===== DEBUG [getCurrentUser - TOKEN] = $token ===|||');
  final url = APIUrls.CURRENT_USER_SETTINGS_URL;
  final response = await http.get(url, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'bearer $token'
  });
  Map userDataJson = json.decode(response.body);
  //print('||||===== DEBUG [getCurrentUser - RESPONSE] = ${userDataJson['user_id']} ===|||');
  if (response.statusCode <= 401 || response.statusCode >= 200) {
    return userDataJson;
  } else {
    return userDataJson;
  }
}


Future<Map> currentUserSettingsUpdate(BuildContext context,Map body,String token,Function page) async {
  final url = APIUrls.CURRENT_USER_SETTINGS_UPDATE_URL;
  final response = await http.post(url, body: json.encode(body), headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'bearer $token'
  });
    Map result = json.decode(response.body);
  if (response.statusCode <= 401 || response.statusCode >= 200) {
    _helperClass.showSuccessAlert(context,'successfullyUpdated',() => page());
    context.read<AuthProvider>().currentUser(token);
    notifyListeners();
    return result;
  }

  throw Exception("faild to create order");
}

}