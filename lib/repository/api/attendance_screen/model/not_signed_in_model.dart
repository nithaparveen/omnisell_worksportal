// To parse this JSON data, do
//
//     final notSignedInModel = notSignedInModelFromJson(jsonString);

import 'dart:convert';

NotSignedInModel notSignedInModelFromJson(String str) => NotSignedInModel.fromJson(json.decode(str));

String notSignedInModelToJson(NotSignedInModel data) => json.encode(data.toJson());

class NotSignedInModel {
    String? status;
    List<Datum>? data;
    dynamic message;

    NotSignedInModel({  
        this.status,
        this.data,
        this.message,
    });

    factory NotSignedInModel.fromJson(Map<String, dynamic> json) => NotSignedInModel(
        status: json["status"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
    };
}

class Datum {
    int? userId;
    String? name;
    String? email;

    Datum({
        this.userId,
        this.name,
        this.email,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        userId: json["user_id"],
        name: json["name"],
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "name": name,
        "email": email,
    };
}
