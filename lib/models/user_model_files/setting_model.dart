import 'dart:convert';
//============================  USER =============================================
List<Setting> settingFromJson(String str) => new List<Setting>.from(json.decode(str).map((x) => Setting.fromJson(x)));

String settingToJson(List<Setting> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

//==================USERS=============================================
SettingsList settingsListFromJson(String str) =>
    SettingsList.fromJson(json.decode(str));

String settingsListToJson(SettingsList settings) => json.encode(settings.toJson());

class SettingsList {
  List<Setting> settings;

  SettingsList({
    this.settings,
  });

  factory SettingsList.fromJson(Map<String, dynamic> json) => new SettingsList(
    settings:
    new List<Setting>.from(json["data"].map((x) => Setting.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "settings": new List<dynamic>.from(settings.map((x) => x.toJson())),
  };
}


class Setting{
 final int id;
 final String name;
 final String val;
 final String type;
 final String locale;
 final DateTime createdAt;
 final DateTime updatedAt;

  Setting({
    this.id,
    this.name,
    this.val,
    this.type,
    this.locale,
    this.createdAt,
    this.updatedAt,
  });



  factory Setting.fromJson(Map<String, dynamic> json) => new Setting(
    id: json["id"],
    name: json["name"],
    val: json["val"],
    type: json["type"],
    locale: json["locale"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  //===================== TO JSON =================================
  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "val": val,
    "type": type,
    "locale": locale,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };

  //===================== TO MAP =================================
  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "val": val,
    "type": type,
    "locale": locale,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };

}