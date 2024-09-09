// To parse this JSON data, do
//
//     final activitiesModel = activitiesModelFromJson(jsonString);

import 'dart:convert';

ActivitiesModel activitiesModelFromJson(String str) => ActivitiesModel.fromJson(json.decode(str));

String activitiesModelToJson(ActivitiesModel data) => json.encode(data.toJson());

class ActivitiesModel {
    String? status;
    Data? data;
    dynamic message;

    ActivitiesModel({
        this.status,
        this.data,
        this.message,
    });

    factory ActivitiesModel.fromJson(Map<String, dynamic> json) => ActivitiesModel(
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
    dynamic nextPageUrl;
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
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x.toJson())),
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
    int? projectsId;
    dynamic projectTasksId;
    String? title;
    dynamic description;
    dynamic startTime;
    dynamic endTime;
    dynamic duration;
    int? durationHours;
    int? durationMinutes;
    Status? status;
    int? usersId;
    int? createdBy;
    int? updatedBy;
    DateTime? createdAt;
    DateTime? updatedAt;
    Project? project;
    dynamic projectTask;
    User? user;
    User? createdUser;
    User? updatedUser;

    Datum({
        this.id,
        this.projectsId,
        this.projectTasksId,
        this.title,
        this.description,
        this.startTime,
        this.endTime,
        this.duration,
        this.durationHours,
        this.durationMinutes,
        this.status,
        this.usersId,
        this.createdBy,
        this.updatedBy,
        this.createdAt,
        this.updatedAt,
        this.project,
        this.projectTask,
        this.user,
        this.createdUser,
        this.updatedUser,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        projectsId: json["projects_id"],
        projectTasksId: json["project_tasks_id"],
        title: json["title"],
        description: json["description"],
        startTime: json["start_time"],
        endTime: json["end_time"],
        duration: json["duration"],
        durationHours: json["duration_hours"],
        durationMinutes: json["duration_minutes"],
        status: statusValues.map[json["status"]]!,
        usersId: json["users_id"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        project: json["project"] == null ? null : Project.fromJson(json["project"]),
        projectTask: json["project_task"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        createdUser: json["created_user"] == null ? null : User.fromJson(json["created_user"]),
        updatedUser: json["updated_user"] == null ? null : User.fromJson(json["updated_user"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "projects_id": projectsId,
        "project_tasks_id": projectTasksId,
        "title": title,
        "description": description,
        "start_time": startTime,
        "end_time": endTime,
        "duration": duration,
        "duration_hours": durationHours,
        "duration_minutes": durationMinutes,
        "status": statusValues.reverse[status],
        "users_id": usersId,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "project": project?.toJson(),
        "project_task": projectTask,
        "user": user?.toJson(),
        "created_user": createdUser?.toJson(),
        "updated_user": updatedUser?.toJson(),
    };
}

class User {
    int? id;
    CreatedUserName? name;
    Email? email;
    String? username;
    dynamic emailVerifiedAt;
    UserType? userType;
    int? managerId;
    int? parantOrganisationsId;
    dynamic organisationsId;
    int? viewSubordinateLeads;
    dynamic apiToken;
    dynamic loggedinOrganisation;
    dynamic lastAccessedProjectsId;
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

    User({
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

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: createdUserNameValues.map[json["name"]]!,
        email: emailValues.map[json["email"]]!,
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
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": createdUserNameValues.reverse[name],
        "email": emailValues.reverse[email],
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

enum Email {
    MUHAMMED_SPIDERWORKS_IN
}

final emailValues = EnumValues({
    "muhammed@spiderworks.in": Email.MUHAMMED_SPIDERWORKS_IN
});

enum CreatedUserName {
    MUHAMMED_ILLYAS_B
}

final createdUserNameValues = EnumValues({
    "Muhammed Illyas B": CreatedUserName.MUHAMMED_ILLYAS_B
});

enum UserType {
    EMPLOYEE
}

final userTypeValues = EnumValues({
    "Employee": UserType.EMPLOYEE
});

class Project {
    int? id;
    ProjectName? name;
    dynamic leadsId;
    int? accountsId;
    int? countryId;
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
        name: projectNameValues.map[json["name"]]!,
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
        "name": projectNameValues.reverse[name],
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

enum ProjectName {
    UNIVERSITY_HUB_DIGITAL_MARKETING
}

final projectNameValues = EnumValues({
    "University Hub Digital Marketing": ProjectName.UNIVERSITY_HUB_DIGITAL_MARKETING
});

enum Status {
    NOT_STARTED
}

final statusValues = EnumValues({
    "Not Started": Status.NOT_STARTED
});

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
