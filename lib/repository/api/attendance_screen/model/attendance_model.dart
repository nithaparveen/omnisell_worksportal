// To parse this JSON data, do
//
//     final attendanceModel = attendanceModelFromJson(jsonString);

import 'dart:convert';

AttendanceModel attendanceModelFromJson(String str) => AttendanceModel.fromJson(json.decode(str));

String attendanceModelToJson(AttendanceModel data) => json.encode(data.toJson());

class AttendanceModel {
    String? status;
    List<Datum>? data;
    dynamic message;

    AttendanceModel({
        this.status,
        this.data,
        this.message,
    });

    factory AttendanceModel.fromJson(Map<String, dynamic> json) => AttendanceModel(
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
    int? id;
    dynamic loggedInIp;
    dynamic loggedOutIp;
    DateTime? loggedOutTime;
    int? createdBy;
    int? updatedBy;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? userId;
    String? name;
    String? email;

    Datum({
        this.id,
        this.loggedInIp,
        this.loggedOutIp,
        this.loggedOutTime,
        this.createdBy,
        this.updatedBy,
        this.createdAt,
        this.updatedAt,
        this.userId,
        this.name,
        this.email,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        loggedInIp: json["logged_in_ip"],
        loggedOutIp: json["logged_out_ip"],
        loggedOutTime: json["logged_out_time"] == null ? null : DateTime.parse(json["logged_out_time"]),
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        userId: json["user_id"],
        name: json["name"],
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "logged_in_ip": loggedInIp,
        "logged_out_ip": loggedOutIp,
        "logged_out_time": loggedOutTime?.toIso8601String(),
        "created_by": createdBy,
        "updated_by": updatedBy,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "user_id": userId,
        "name": name,
        "email": email,
    };
}
