// To parse this JSON data, do
//
//     final taskDetailModel = taskDetailModelFromJson(jsonString);

import 'dart:convert';

TaskDetailModel taskDetailModelFromJson(String str) => TaskDetailModel.fromJson(json.decode(str));

String taskDetailModelToJson(TaskDetailModel data) => json.encode(data.toJson());

class TaskDetailModel {
  String? status;
  Data? data;
  dynamic message;

  TaskDetailModel({
    this.status,
    this.data,
    this.message,
  });

  factory TaskDetailModel.fromJson(Map<String, dynamic> json) => TaskDetailModel(
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
  int? id;
  String? title;
  int? projectsId;
  dynamic description;
  dynamic startDate;
  dynamic endDate;
  DateTime? dueDate;
  int? assignedToId;
  int? assignedById;
  int? reviewerId;
  dynamic fromEntityType;
  dynamic fromEntityId;
  dynamic relatableType;
  dynamic relatableId;
  int? archived;
  dynamic archivedBy;
  dynamic archivedOn;
  int? priority;
  String? status;
  dynamic statusNote;
  int? createdBy;
  int? updatedBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  Project? project;
  List<dynamic>? checkLists;
  List<dynamic>? timeSpend;
  AssignedByUser? assignedToUser;
  AssignedByUser? assignedByUser;
  AssignedByUser? reviewer;
  AssignedByUser? createdUser;
  AssignedByUser? updatedUser;

  Data({
    this.id,
    this.title,
    this.projectsId,
    this.description,
    this.startDate,
    this.endDate,
    this.dueDate,
    this.assignedToId,
    this.assignedById,
    this.reviewerId,
    this.fromEntityType,
    this.fromEntityId,
    this.relatableType,
    this.relatableId,
    this.archived,
    this.archivedBy,
    this.archivedOn,
    this.priority,
    this.status,
    this.statusNote,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.project,
    this.checkLists,
    this.timeSpend,
    this.assignedToUser,
    this.assignedByUser,
    this.reviewer,
    this.createdUser,
    this.updatedUser,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    title: json["title"],
    projectsId: json["projects_id"],
    description: json["description"],
    startDate: json["start_date"],
    endDate: json["end_date"],
    dueDate: json["due_date"] == null ? null : DateTime.parse(json["due_date"]),
    assignedToId: json["assigned_to_id"],
    assignedById: json["assigned_by_id"],
    reviewerId: json["reviewer_id"],
    fromEntityType: json["from_entity_type"],
    fromEntityId: json["from_entity_id"],
    relatableType: json["relatable_type"],
    relatableId: json["relatable_id"],
    archived: json["archived"],
    archivedBy: json["archived_by"],
    archivedOn: json["archived_on"],
    priority: json["priority"],
    status: json["status"],
    statusNote: json["status_note"],
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    project: json["project"] == null ? null : Project.fromJson(json["project"]),
    checkLists: json["check_lists"] == null ? [] : List<dynamic>.from(json["check_lists"]!.map((x) => x)),
    timeSpend: json["time_spend"] == null ? [] : List<dynamic>.from(json["time_spend"]!.map((x) => x)),
    assignedToUser: json["assigned_to_user"] == null ? null : AssignedByUser.fromJson(json["assigned_to_user"]),
    assignedByUser: json["assigned_by_user"] == null ? null : AssignedByUser.fromJson(json["assigned_by_user"]),
    reviewer: json["reviewer"] == null ? null : AssignedByUser.fromJson(json["reviewer"]),
    createdUser: json["created_user"] == null ? null : AssignedByUser.fromJson(json["created_user"]),
    updatedUser: json["updated_user"] == null ? null : AssignedByUser.fromJson(json["updated_user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "projects_id": projectsId,
    "description": description,
    "start_date": startDate,
    "end_date": endDate,
    "due_date": "${dueDate!.year.toString().padLeft(4, '0')}-${dueDate!.month.toString().padLeft(2, '0')}-${dueDate!.day.toString().padLeft(2, '0')}",
    "assigned_to_id": assignedToId,
    "assigned_by_id": assignedById,
    "reviewer_id": reviewerId,
    "from_entity_type": fromEntityType,
    "from_entity_id": fromEntityId,
    "relatable_type": relatableType,
    "relatable_id": relatableId,
    "archived": archived,
    "archived_by": archivedBy,
    "archived_on": archivedOn,
    "priority": priority,
    "status": status,
    "status_note": statusNote,
    "created_by": createdBy,
    "updated_by": updatedBy,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "project": project?.toJson(),
    "check_lists": checkLists == null ? [] : List<dynamic>.from(checkLists!.map((x) => x)),
    "time_spend": timeSpend == null ? [] : List<dynamic>.from(timeSpend!.map((x) => x)),
    "assigned_to_user": assignedToUser?.toJson(),
    "assigned_by_user": assignedByUser?.toJson(),
    "reviewer": reviewer?.toJson(),
    "created_user": createdUser?.toJson(),
    "updated_user": updatedUser?.toJson(),
  };
}

class AssignedByUser {
  int? id;
  String? name;
  String? email;
  String? username;
  dynamic emailVerifiedAt;
  String? userType;
  int? managerId;
  int? parantOrganisationsId;
  int? organisationsId;
  int? viewSubordinateLeads;
  String? apiToken;
  int? loggedinOrganisation;
  int? lastAccessedProjectsId;
  dynamic facebookUrl;
  dynamic linkedinUrl;
  dynamic instagramUrl;
  dynamic blogUrl;
  dynamic lastUsedEmail;
  dynamic reportingEmail;
  int? status;
  int? createdBy;
  int? updatedBy;
  DateTime? createdAt;
  DateTime? updatedAt;

  AssignedByUser({
    this.id,
    this.name,
    this.email,
    this.username,
    this.emailVerifiedAt,
    this.userType,
    this.managerId,
    this.parantOrganisationsId,
    this.organisationsId,
    this.viewSubordinateLeads,
    this.apiToken,
    this.loggedinOrganisation,
    this.lastAccessedProjectsId,
    this.facebookUrl,
    this.linkedinUrl,
    this.instagramUrl,
    this.blogUrl,
    this.lastUsedEmail,
    this.reportingEmail,
    this.status,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  factory AssignedByUser.fromJson(Map<String, dynamic> json) => AssignedByUser(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    username: json["username"],
    emailVerifiedAt: json["email_verified_at"],
    userType: json["user_type"],
    managerId: json["manager_id"],
    parantOrganisationsId: json["parant_organisations_id"],
    organisationsId: json["organisations_id"],
    viewSubordinateLeads: json["view_subordinate_leads"],
    apiToken: json["api_token"],
    loggedinOrganisation: json["loggedin_organisation"],
    lastAccessedProjectsId: json["last_accessed_projects_id"],
    facebookUrl: json["facebook_url"],
    linkedinUrl: json["linkedin_url"],
    instagramUrl: json["instagram_url"],
    blogUrl: json["blog_url"],
    lastUsedEmail: json["last_used_email"],
    reportingEmail: json["reporting_email"],
    status: json["status"],
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "username": username,
    "email_verified_at": emailVerifiedAt,
    "user_type": userType,
    "manager_id": managerId,
    "parant_organisations_id": parantOrganisationsId,
    "organisations_id": organisationsId,
    "view_subordinate_leads": viewSubordinateLeads,
    "api_token": apiToken,
    "loggedin_organisation": loggedinOrganisation,
    "last_accessed_projects_id": lastAccessedProjectsId,
    "facebook_url": facebookUrl,
    "linkedin_url": linkedinUrl,
    "instagram_url": instagramUrl,
    "blog_url": blogUrl,
    "last_used_email": lastUsedEmail,
    "reporting_email": reportingEmail,
    "status": status,
    "created_by": createdBy,
    "updated_by": updatedBy,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class Project {
  int? id;
  String? name;
  dynamic leadsId;
  int? accountsId;
  dynamic countryId;
  DateTime? startDate;
  dynamic endDate;
  dynamic description;
  int? status;
  int? createdBy;
  int? updatedBy;
  DateTime? createdAt;
  DateTime? updatedAt;

  Project({
    this.id,
    this.name,
    this.leadsId,
    this.accountsId,
    this.countryId,
    this.startDate,
    this.endDate,
    this.description,
    this.status,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  factory Project.fromJson(Map<String, dynamic> json) => Project(
    id: json["id"],
    name: json["name"],
    leadsId: json["leads_id"],
    accountsId: json["accounts_id"],
    countryId: json["country_id"],
    startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
    endDate: json["end_date"],
    description: json["description"],
    status: json["status"],
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "leads_id": leadsId,
    "accounts_id": accountsId,
    "country_id": countryId,
    "start_date": "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
    "end_date": endDate,
    "description": description,
    "status": status,
    "created_by": createdBy,
    "updated_by": updatedBy,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
