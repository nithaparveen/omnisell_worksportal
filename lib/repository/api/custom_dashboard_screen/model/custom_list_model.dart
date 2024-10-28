import 'dart:convert';

CustomListModel customListModelFromJson(String str) =>
    CustomListModel.fromJson(json.decode(str));

String customListModelToJson(CustomListModel data) =>
    json.encode(data.toJson());

class CustomListModel {
  List<Datum>? data;

  CustomListModel({
    this.data,
  });

  factory CustomListModel.fromJson(Map<String, dynamic> json) =>
      CustomListModel(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  int? id;
  String? dashboardName;
  String? description;
  int? ownerUserId;
  DateTime? createDate;
  int? createdBy;
  int? updatedBy;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.dashboardName,
    this.description,
    this.ownerUserId,
    this.createDate,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        dashboardName: json["dashboard_name"]!,
        description: json["description"]!,
        ownerUserId: json["owner_user_id"],
        createDate: json["create_date"] == null
            ? null
            : DateTime.parse(json["create_date"]),
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "dashboard_name": dashboardName,
        "description": description,
        "owner_user_id": ownerUserId,
        "create_date":
            "${createDate!.year.toString().padLeft(4, '0')}-${createDate!.month.toString().padLeft(2, '0')}-${createDate!.day.toString().padLeft(2, '0')}",
        "created_by": createdBy,
        "updated_by": updatedBy,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
