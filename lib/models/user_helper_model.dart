

class UserHelperModel{

  final int id;
  final String name;
  final String email;
  UserHelperModel({
    this.id,
    this.name,
    this.email,
  });


  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "name": name,
      };

  factory UserHelperModel.fromJson(Map<String, dynamic> parsedJson) {
    return UserHelperModel(
      id: parsedJson["id"],
      name: parsedJson["name"] as String,
      email: parsedJson["email"] as String,
    );
  }


}
