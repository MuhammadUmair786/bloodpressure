// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

BloodPressureModel userFromJson(String str) =>
    BloodPressureModel.fromJson(json.decode(str));

String userToJson(BloodPressureModel data) => json.encode(data.toJson());

class BloodPressureModel {
  BloodPressureModel({
    required this.id,
    required this.date,
    required this.peso,
    required this.pulso,
    required this.sis,
    required this.dia,
    required this.memberId,
    required this.v,
  });

  String id;
  String date;
  String peso;
  String pulso;
  String sis;
  String dia;
  String memberId;
  int v;

  factory BloodPressureModel.fromJson(Map<String, dynamic> json) =>
      BloodPressureModel(
        id: json["_id"],
        date: json["date"],
        peso: json["peso"],
        pulso: json["pulso"],
        sis: json["SIS"],
        dia: json["DIA"],
        memberId: json["member_id"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "date": date,
        "peso": peso,
        "pulso": pulso,
        "SIS": sis,
        "DIA": dia,
        "member_id": memberId,
        "__v": v,
      };
}
