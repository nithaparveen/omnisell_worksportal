// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
    String? status;
    Data? data;
    dynamic message;

    LoginModel({
        this.status,
        this.data,
        this.message,
    });

    factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
        "message": message,
    };
}

class Data {
    String? authToken;
    int? defaultLeadType;
    User? user;

    Data({
        this.authToken,
        this.defaultLeadType,
        this.user,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        authToken: json["auth_token"],
        defaultLeadType: json["default_lead_type"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "auth_token": authToken,
        "default_lead_type": defaultLeadType,
        "user": user?.toJson(),
    };
}

class User {
    int? userId;
    String? email;
    String? name;
    List<dynamic>? permissions;

    User({
        this.userId,
        this.email,
        this.name,
        this.permissions,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["user_id"],
        email: json["email"],
        name: json["name"],
        permissions: json["permissions"] == null ? [] : List<dynamic>.from(json["permissions"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "email": email,
        "name": name,
        "permissions": permissions == null ? [] : List<dynamic>.from(permissions!.map((x) => x)),
    };
}
