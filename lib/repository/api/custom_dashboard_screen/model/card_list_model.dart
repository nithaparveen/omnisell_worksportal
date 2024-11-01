// To parse this JSON data, do
//
//     final cardListModel = cardListModelFromJson(jsonString);

import 'dart:convert';

CardListModel cardListModelFromJson(String str) => CardListModel.fromJson(json.decode(str));

String cardListModelToJson(CardListModel data) => json.encode(data.toJson());

class CardListModel {
    String? status;
    List<Datum>? data;
    dynamic message;

    CardListModel({
        this.status,
        this.data,
        this.message,
    });

    factory CardListModel.fromJson(Map<String, dynamic> json) => CardListModel(
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
    int? dashboardId;
    DateTime? createDate;
    String? cardName;
    int? cardTypeId;
    int? entityItemId;
    int? count;
    int? priority;
    int? columnCard;
    String? cardDescription;
    String? backgroundColor;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? createdBy;
    int? updatedBy;
    dynamic deletedAt;

    Datum({
        this.id,
        this.dashboardId,
        this.createDate,
        this.cardName,
        this.cardTypeId,
        this.entityItemId,
        this.count,
        this.priority,
        this.columnCard,
        this.cardDescription,
        this.backgroundColor,
        this.createdAt,
        this.updatedAt,
        this.createdBy,
        this.updatedBy,
        this.deletedAt,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        dashboardId: json["dashboard_id"],
        createDate: json["create_date"] == null ? null : DateTime.parse(json["create_date"]),
        cardName: json["card_name"],
        cardTypeId: json["card_type_id"],
        entityItemId: json["entity_Item_id"],
        count: json["count"],
        priority: json["priority"],
        columnCard: json["column_card"],
        cardDescription: json["card_description"],
        backgroundColor: json["background_color"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        deletedAt: json["deleted_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "dashboard_id": dashboardId,
        "create_date": "${createDate!.year.toString().padLeft(4, '0')}-${createDate!.month.toString().padLeft(2, '0')}-${createDate!.day.toString().padLeft(2, '0')}",
        "card_name": cardName,
        "card_type_id": cardTypeId,
        "entity_Item_id": entityItemId,
        "count": count,
        "priority": priority,
        "column_card": columnCard,
        "card_description": cardDescription,
        "background_color": backgroundColor,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "created_by": createdBy,
        "updated_by": updatedBy,
        "deleted_at": deletedAt,
    };
}
