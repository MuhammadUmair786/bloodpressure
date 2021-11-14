// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

// import 'package:jiffy/jiffy.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.id,
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.dbo,
    required this.gender,
    required this.number,
    required this.height,
    required this.weight,
    required this.v,
    // required this.dobObject,
  });

  String id;
  String email;
  String password;
  String firstName;
  String lastName;
  String dbo;
  String gender;
  String number;
  String height;
  String weight;
  int v;

  // DateTime dobObject;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["_id"],
        email: json["email"],
        password: json["password"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        dbo: json["dbo"],
        // dobObject : Jiffy("19, Jan 2021", "dd, MMM yyyy").;,
        gender: json["gender"],
        number: json["number"],
        height: json["height"],
        weight: json["weight"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "email": email,
        "password": password,
        "first_name": firstName,
        "last_name": lastName,
        "dbo": dbo,
        "gender": gender,
        "number": number,
        "height": height,
        "weight": weight,
        "__v": v,
      };
}
