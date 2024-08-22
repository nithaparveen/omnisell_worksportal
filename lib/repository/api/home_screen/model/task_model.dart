import 'dart:convert';

TaskModel taskModelFromJson(String str) => TaskModel.fromJson(json.decode(str));

String taskModelToJson(TaskModel data) => json.encode(data.toJson());

class TaskModel {
  String? status;
  Data? data;
  dynamic message;

  TaskModel({
    this.status,
    this.data,
    this.message,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
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
  int? currentPage;
  List<Datum>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  Data({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: json["links"] == null
            ? []
            : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": links == null
            ? []
            : List<dynamic>.from(links!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class Datum {
  int? id;
  String? title;
  int? projectsId;
  String? description;
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
  AssignedByUser? assignedToUser;
  List<dynamic>? timeSpend;
  AssignedByUser? assignedByUser;
  AssignedByUser? reviewer;
  AssignedByUser? createdUser;
  AssignedByUser? updatedUser;

  Datum({
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
    this.assignedToUser,
    this.timeSpend,
    this.assignedByUser,
    this.reviewer,
    this.createdUser,
    this.updatedUser,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"],
        projectsId: json["projects_id"],
        description: json["description"],
        startDate: json["start_date"],
        endDate: json["end_date"],
        dueDate:
            json["due_date"] == null ? null : DateTime.parse(json["due_date"]),
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
        // or another default value
        statusNote: json["status_note"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        project:
            json["project"] == null ? null : Project.fromJson(json["project"]),
        checkLists: json["check_lists"] == null
            ? []
            : List<dynamic>.from(json["check_lists"]!.map((x) => x)),
        assignedToUser: json["assigned_to_user"] == null
            ? null
            : AssignedByUser.fromJson(json["assigned_to_user"]),
        timeSpend: json["time_spend"] == null
            ? []
            : List<dynamic>.from(json["time_spend"]!.map((x) => x)),
        assignedByUser: json["assigned_by_user"] == null
            ? null
            : AssignedByUser.fromJson(json["assigned_by_user"]),
        reviewer: json["reviewer"] == null
            ? null
            : AssignedByUser.fromJson(json["reviewer"]),
        createdUser: json["created_user"] == null
            ? null
            : AssignedByUser.fromJson(json["created_user"]),
        updatedUser: json["updated_user"] == null
            ? null
            : AssignedByUser.fromJson(json["updated_user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "projects_id": projectsId,
        "description": description,
        "start_date": startDate,
        "end_date": endDate,
        "due_date":
            "${dueDate!.year.toString().padLeft(4, '0')}-${dueDate!.month.toString().padLeft(2, '0')}-${dueDate!.day.toString().padLeft(2, '0')}",
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
        "check_lists": checkLists == null
            ? []
            : List<dynamic>.from(checkLists!.map((x) => x)),
        "assigned_to_user": assignedToUser?.toJson(),
        "time_spend": timeSpend == null
            ? []
            : List<dynamic>.from(timeSpend!.map((x) => x)),
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
  UserType? userType;
  int? managerId;
  int? parantOrganisationsId;
  int? organisationsId;
  int? viewSubordinateLeads;
  String? apiToken;
  int? loggedinOrganisation;
  int? lastAccessedProjectsId;
  String? facebookUrl;
  String? linkedinUrl;
  String? instagramUrl;
  String? blogUrl;
  dynamic lastUsedEmail;
  String? reportingEmail;
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
        userType: userTypeValues.map[json["user_type"]]!,
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
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "username": username,
        "email_verified_at": emailVerifiedAt,
        "user_type": userTypeValues.reverse[userType],
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

enum UserType { ADMIN, EMPLOYEE, USER }

final userTypeValues = EnumValues({
  "Admin": UserType.ADMIN,
  "Employee": UserType.EMPLOYEE,
  "User": UserType.USER
});

class Project {
  int? id;
  String? name;
  dynamic leadsId;
  int? accountsId;
  int? countryId;
  DateTime? startDate;
  dynamic endDate;
  String? description;
  int? status;
  int? createdBy;
  int? updatedBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Member>? members;

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
    this.members,
  });

  factory Project.fromJson(Map<String, dynamic> json) => Project(
        id: json["id"],
        name: json["name"],
        leadsId: json["leads_id"],
        accountsId: json["accounts_id"],
        countryId: json["country_id"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate: json["end_date"],
        description: json["description"],
        status: json["status"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        members: json["members"] == null
            ? []
            : List<Member>.from(
                json["members"]!.map((x) => Member.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "leads_id": leadsId,
        "accounts_id": accountsId,
        "country_id": countryId,
        "start_date":
            "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "end_date": endDate,
        "description": description,
        "status": status,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "members": members == null
            ? []
            : List<dynamic>.from(members!.map((x) => x.toJson())),
      };
}

class Member {
  int? id;
  int? projectsId;
  int? usersId;
  String? userRole;
  int? isProjectOwner;
  int? createdBy;
  int? updatedBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  AssignedByUser? user;

  Member({
    this.id,
    this.projectsId,
    this.usersId,
    this.userRole,
    this.isProjectOwner,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  factory Member.fromJson(Map<String, dynamic> json) => Member(
        id: json["id"],
        projectsId: json["projects_id"],
        usersId: json["users_id"],
        userRole: json["user_role"],
        isProjectOwner: json["is_project_owner"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        user:
            json["user"] == null ? null : AssignedByUser.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "projects_id": projectsId,
        "users_id": usersId,
        "user_role": userRole,
        "is_project_owner": isProjectOwner,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "user": user?.toJson(),
      };
}

class Link {
  String? url;
  String? label;
  bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
