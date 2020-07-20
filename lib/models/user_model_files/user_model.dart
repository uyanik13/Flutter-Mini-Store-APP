import 'dart:convert';

import 'package:flutter/cupertino.dart';


//============================  USER =============================================
List<UserModel> userFromJson(String str) =>
    new List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String userToJson(List<UserModel> data) =>
    json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

//==================USERS=============================================
UsersList usersListFromJson(String str) => UsersList.fromJson(json.decode(str));

String usersListToJson(UsersList users) => json.encode(users.toJson());

class UsersList with ChangeNotifier {
  List<UserModel> users;

  UsersList({
    this.users,
  });


  factory UsersList.fromJson(Map<String, dynamic> json) => new UsersList(
        users: new List<UserModel>.from(json["data"].map((x) => UserModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "users": new List<dynamic>.from(users.map((x) => x.toJson())),
      };
}

class UserModel{

  final int id;
  final String name;
  final String email;
  final String address;
  final String phone;
  final String photoUrl;
  final String role;
  final String status;
  final String userRefNUmber;
  final double userTotalDebt;
  final double  latestInvoice;
  final double  totalDebt;
  final double  giftPoints;
  final String  storeRefNumber;
  final String  storeName;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.address,
    this.phone,
    this.photoUrl,
    this.role,
    this.status,
    this.userRefNUmber,
    this.userTotalDebt,
    this.latestInvoice,
    this.totalDebt,
    this.giftPoints,
    this.storeRefNumber,
    this.storeName,
  });


  factory UserModel.fromJson(Map<String, dynamic> json) => new UserModel(
        id: json["id"] as int,
        email: json["email"],
        name: json["name"],
        photoUrl: json["photo_url"],
        role: json["role"],
        status: json["status"],
        phone: json["phone"],
        userRefNUmber: json["user_ref_number"],
        giftPoints: double.parse(json["gift_points"].toString()),
        latestInvoice: double.parse(json["latest_invoice"].toString()),
        userTotalDebt: double.parse(json["user_total_debt"].toString()),
        totalDebt: double.parse(json["total_debt"].toString()),
        storeRefNumber: json["store_ref_number"],
        storeName: json["store_name"],
      );

   /*factory UserModel.fromJson(Map<String, dynamic> json) => new UserModel(
        id: json["id"] as int,
        email: json["email"],
        name: json["name"],
        photoUrl: json["photo_url"],
        role: json["role"],
        phone: json["phone"],
        userRefNUmber: json["user_ref_number"],
        userTotalDebt: json["user_total_debt"]  as double,
        latestInvoice: json["latest_invoice"]as double,
        giftPoints: json["gift_points"] as int,
        totalDebt: json["total_debt"] as double,
        storeRefNumber: json["store_ref_number"],
        storeName: json["store_name"],
      );*/
  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "name": name,
        "photo_url": photoUrl,
        "role": role,
        "status": status,
        "phone": phone,
        "user_ref_number": userRefNUmber,
        "user_total_debt": userTotalDebt,
        "latest_invoice": latestInvoice,
        "gift_points": giftPoints,
        "total_debt": totalDebt,
        "store_ref_number": storeRefNumber,
        "store_name": storeName,
      };


  //===================== TO MAP =================================
  Map<String, dynamic> toMap() => {
    "id": id,
    "email": email,
    "name": name,
    "photo_url": photoUrl,
    "role": role,
    "status": status,
    "phone": phone,
    "user_ref_number": userRefNUmber,
    "user_total_debt": userTotalDebt,
    "latest_invoice": latestInvoice,
    "gift_points": giftPoints,
    "total_debt": totalDebt,
    "store_ref_number": storeRefNumber,
    "store_name": storeName,
  };

}
