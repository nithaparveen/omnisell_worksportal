// To parse this JSON data, do
//
//     final projectModel = projectModelFromJson(jsonString);

import 'dart:convert';

ProjectModel projectModelFromJson(String str) => ProjectModel.fromJson(json.decode(str));

String projectModelToJson(ProjectModel data) => json.encode(data.toJson());

class ProjectModel {
    String? status;
    Data? data;
    dynamic message;

    ProjectModel({
        this.status,
        this.data,
        this.message,
    });

    factory ProjectModel.fromJson(Map<String, dynamic> json) => ProjectModel(
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
    Account? account;
    Country? country;
    User? createdUser;
    User? updatedUser;
    List<Member>? members;

    Datum({
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
        this.account,
        this.country,
        this.createdUser,
        this.updatedUser,
        this.members,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
        account: json["account"] == null ? null : Account.fromJson(json["account"]),
        country: json["country"] == null ? null : Country.fromJson(json["country"]),
        createdUser: json["created_user"] == null ? null : User.fromJson(json["created_user"]),
        updatedUser: json["updated_user"] == null ? null : User.fromJson(json["updated_user"]),
        members: json["members"] == null ? [] : List<Member>.from(json["members"]!.map((x) => Member.fromJson(x))),
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
        "account": account?.toJson(),
        "country": country?.toJson(),
        "created_user": createdUser?.toJson(),
        "updated_user": updatedUser?.toJson(),
        "members": members == null ? [] : List<dynamic>.from(members!.map((x) => x.toJson())),
    };
}

class Account {
    int? id;
    String? accountName;
    String? companyName;
    String? address;
    String? remarks;
    int? status;
    int? createdBy;
    int? updatedBy;
    DateTime? createdAt;
    DateTime? updatedAt;

    Account({
        this.id,
        this.accountName,
        this.companyName,
        this.address,
        this.remarks,
        this.status,
        this.createdBy,
        this.updatedBy,
        this.createdAt,
        this.updatedAt,
    });

    factory Account.fromJson(Map<String, dynamic> json) => Account(
        id: json["id"],
        accountName: json["account_name"],
        companyName: json["company_name"],
        address: json["address"],
        remarks: json["remarks"],
        status: json["status"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "account_name": accountName,
        "company_name": companyName,
        "address": address,
        "remarks": remarks,
        "status": status,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}

class Country {
    int? id;
    String? code3L;
    String? code2L;
    String? name;
    String? nameOfficial;
    String? latitude;
    String? longitude;
    int? zoom;
    String? flag;
    int? usingForBilling;

    Country({
        this.id,
        this.code3L,
        this.code2L,
        this.name,
        this.nameOfficial,
        this.latitude,
        this.longitude,
        this.zoom,
        this.flag,
        this.usingForBilling,
    });

    factory Country.fromJson(Map<String, dynamic> json) => Country(
        id: json["id"],
        code3L: json["code3l"],
        code2L: json["code2l"],
        name: json["name"],
        nameOfficial: json["name_official"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        zoom: json["zoom"],
        flag: json["flag"],
        usingForBilling: json["using_for_billing"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "code3l": code3L,
        "code2l": code2L,
        "name": name,
        "name_official": nameOfficial,
        "latitude": latitude,
        "longitude": longitude,
        "zoom": zoom,
        "flag": flag,
        "using_for_billing": usingForBilling,
    };
}

class User {
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
    dynamic apiToken;
    int? loggedinOrganisation;
    int? lastAccessedProjectsId;
    String? facebookUrl;
    String? linkedinUrl;
    String? instagramUrl;
    String? blogUrl;
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
        name: json["name"],
        email: json["email"],
        username: json["username"],
        emailVerifiedAt: json["email_verified_at"],
        userType: json["user_type"]!,
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
    User? user;

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
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
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
