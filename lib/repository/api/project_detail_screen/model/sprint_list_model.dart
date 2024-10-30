import 'dart:convert';

SprintListModel sprintListModelFromJson(String str) => SprintListModel.fromJson(json.decode(str));

String sprintListModelToJson(SprintListModel data) => json.encode(data.toJson());

class SprintListModel {
    List<Datum>? data;

    SprintListModel({
        this.data,
    });

    factory SprintListModel.fromJson(Map<String, dynamic> json) => SprintListModel(
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    int? id;
    String? name;
    DateTime? startDate;
    DateTime? dueDate;
    DateTime? endDate;
    int? expectedHours;
    int? actualHours;
    String? description;
    String? status;
    dynamic projectId;
    String? archived;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? createdBy;
    int? updatedBy;
    int? deletedAt;

    Datum({
        this.id,
        this.name,
        this.startDate,
        this.dueDate,
        this.endDate,
        this.expectedHours,
        this.actualHours,
        this.description,
        this.status,
        this.projectId,
        this.archived,
        this.createdAt,
        this.updatedAt,
        this.createdBy,
        this.updatedBy,
        this.deletedAt,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"]!,
        startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
        dueDate: json["due_date"] == null ? null : DateTime.parse(json["due_date"]),
        endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        expectedHours: json["expected_hours"],
        actualHours: json["actual_hours"],
        description:json["description"]!,
        status: json["status"],
        projectId: json["project_id"],
        archived: json["archived"]!,
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        deletedAt: json["deleted_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name":name,
        "start_date": "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "due_date": "${dueDate!.year.toString().padLeft(4, '0')}-${dueDate!.month.toString().padLeft(2, '0')}-${dueDate!.day.toString().padLeft(2, '0')}",
        "end_date": "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
        "expected_hours": expectedHours,
        "actual_hours": actualHours,
        "description": description,
        "status": status,
        "project_id": projectId,
        "archived": archived,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "created_by": createdBy,
        "updated_by": updatedBy,
        "deleted_at": deletedAt,
    };
}
