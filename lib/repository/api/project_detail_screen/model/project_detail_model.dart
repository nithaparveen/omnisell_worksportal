// To parse this JSON data, do
//
//     final detailsModel = detailsModelFromJson(jsonString);

import 'dart:convert';

DetailsModel detailsModelFromJson(String str) => DetailsModel.fromJson(json.decode(str));

String detailsModelToJson(DetailsModel data) => json.encode(data.toJson());

class DetailsModel {
    String? status;
    Data? data;
    dynamic message;

    DetailsModel({
        this.status,
        this.data,
        this.message,
    });

    factory DetailsModel.fromJson(Map<String, dynamic> json) => DetailsModel(
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
    List<Scope>? scopes;
    List<dynamic>? notes;
    Country? country;
    AtedUser? createdUser;
    AtedUser? updatedUser;

    Data({
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
        this.scopes,
        this.notes,
        this.country,
        this.createdUser,
        this.updatedUser,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
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
        scopes: json["scopes"] == null ? [] : List<Scope>.from(json["scopes"]!.map((x) => Scope.fromJson(x))),
        notes: json["notes"] == null ? [] : List<dynamic>.from(json["notes"]!.map((x) => x)),
        country: json["country"] == null ? null : Country.fromJson(json["country"]),
        createdUser: json["created_user"] == null ? null : AtedUser.fromJson(json["created_user"]),
        updatedUser: json["updated_user"] == null ? null : AtedUser.fromJson(json["updated_user"]),
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
        "scopes": scopes == null ? [] : List<dynamic>.from(scopes!.map((x) => x.toJson())),
        "notes": notes == null ? [] : List<dynamic>.from(notes!.map((x) => x)),
        "country": country?.toJson(),
        "created_user": createdUser?.toJson(),
        "updated_user": updatedUser?.toJson(),
    };
}

class Account {
    int? id;
    String? accountName;
    String? companyName;
    dynamic address;
    dynamic remarks;
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

class AtedUser {
    int? id;
    String? name;
    String? email;
    String? username;
    dynamic emailVerifiedAt;
    String? userType;
    int? managerId;
    int? parantOrganisationsId;
    dynamic organisationsId;
    int? viewSubordinateLeads;
    dynamic apiToken;
    dynamic loggedinOrganisation;
    dynamic lastAccessedProjectsId;
    String? facebookUrl;
    String? linkedinUrl;
    String? instagramUrl;
    dynamic blogUrl;
    dynamic lastUsedEmail;
    dynamic reportingEmail;
    int? status;
    int? createdBy;
    int? updatedBy;
    DateTime? createdAt;
    DateTime? updatedAt;

    AtedUser({
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

    factory AtedUser.fromJson(Map<String, dynamic> json) => AtedUser(
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

class Scope {
    int? id;
    int? projectsId;
    String? scope;
    int? createdBy;
    int? updatedBy;
    DateTime? createdAt;
    DateTime? updatedAt;

    Scope({
        this.id,
        this.projectsId,
        this.scope,
        this.createdBy,
        this.updatedBy,
        this.createdAt,
        this.updatedAt,
    });

    factory Scope.fromJson(Map<String, dynamic> json) => Scope(
        id: json["id"],
        projectsId: json["projects_id"],
        scope: json["scope"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "projects_id": projectsId,
        "scope": scope,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
