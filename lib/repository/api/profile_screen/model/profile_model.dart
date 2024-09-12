class ProfileModel {
  String? status;
  Data? data;
  String? message;

  ProfileModel({this.status, this.data, this.message});

  // Factory constructor to create an instance from JSON
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      status: json['status'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
      message: json['message'],
    );
  }

  // Method to convert ProfileModel instance back to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? email;
  String? username;
  String? emailVerifiedAt;
  String? userType;
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
  String? lastUsedEmail;
  String? reportingEmail;
  int? status;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;
  Employee? employee;

  Data({
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
    this.employee,
  });

  // Factory constructor to create an instance from JSON
  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      username: json['username'],
      emailVerifiedAt: json['email_verified_at'],
      userType: json['user_type'],
      managerId: json['manager_id'],
      parantOrganisationsId: json['parant_organisations_id'],
      organisationsId: json['organisations_id'],
      viewSubordinateLeads: json['view_subordinate_leads'],
      apiToken: json['api_token'],
      loggedinOrganisation: json['loggedin_organisation'],
      lastAccessedProjectsId: json['last_accessed_projects_id'],
      facebookUrl: json['facebook_url'],
      linkedinUrl: json['linkedin_url'],
      instagramUrl: json['instagram_url'],
      blogUrl: json['blog_url'],
      lastUsedEmail: json['last_used_email'],
      reportingEmail: json['reporting_email'],
      status: json['status'],
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      employee: json['employee'] != null ? Employee.fromJson(json['employee']) : null,
    );
  }

  // Method to convert Data instance back to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['username'] = username;
    data['email_verified_at'] = emailVerifiedAt;
    data['user_type'] = userType;
    data['manager_id'] = managerId;
    data['parant_organisations_id'] = parantOrganisationsId;
    data['organisations_id'] = organisationsId;
    data['view_subordinate_leads'] = viewSubordinateLeads;
    data['api_token'] = apiToken;
    data['loggedin_organisation'] = loggedinOrganisation;
    data['last_accessed_projects_id'] = lastAccessedProjectsId;
    data['facebook_url'] = facebookUrl;
    data['linkedin_url'] = linkedinUrl;
    data['instagram_url'] = instagramUrl;
    data['blog_url'] = blogUrl;
    data['last_used_email'] = lastUsedEmail;
    data['reporting_email'] = reportingEmail;
    data['status'] = status;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (employee != null) {
      data['employee'] = employee!.toJson();
    }
    return data;
  }
}

class Employee {
  int? id;
  int? usersId;
  String? employeeId;
  int? departmentsId;
  int? employeeRolesId;
  String? phoneNumber;
  String? email;
  String? address;
  String? permanentAddress;
  String? dateOfBirth;
  String? officialDateOfBirth;
  String? marriageDate;
  String? emergencyContacts;
  String? joiningDate;
  String? releavingDate;
  String? remarks;
  int? isSuperAdmin;
  String? employeeLevel;
  String? employmentStatus;
  int? isEligibleForLeaves;
  String? selfiPhoto;
  String? familyPhoto;
  int? isSigninMandatory;
  int? hasWorkPortalAccess;
  int? hasHrPortalAccess;
  int? hasClientPortalAccess;
  int? hasInventoryPortalAccess;
  int? hasAccountPortalAccess;
  int? hasSeoPortalAccess;
  int? hasLeadPortalAccess;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;

  Employee({
    this.id,
    this.usersId,
    this.employeeId,
    this.departmentsId,
    this.employeeRolesId,
    this.phoneNumber,
    this.email,
    this.address,
    this.permanentAddress,
    this.dateOfBirth,
    this.officialDateOfBirth,
    this.marriageDate,
    this.emergencyContacts,
    this.joiningDate,
    this.releavingDate,
    this.remarks,
    this.isSuperAdmin,
    this.employeeLevel,
    this.employmentStatus,
    this.isEligibleForLeaves,
    this.selfiPhoto,
    this.familyPhoto,
    this.isSigninMandatory,
    this.hasWorkPortalAccess,
    this.hasHrPortalAccess,
    this.hasClientPortalAccess,
    this.hasInventoryPortalAccess,
    this.hasAccountPortalAccess,
    this.hasSeoPortalAccess,
    this.hasLeadPortalAccess,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  // Factory constructor to create an instance from JSON
  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'],
      usersId: json['users_id'],
      employeeId: json['employee_id'],
      departmentsId: json['departments_id'],
      employeeRolesId: json['employee_roles_id'],
      phoneNumber: json['phone_number'],
      email: json['email'],
      address: json['address'],
      permanentAddress: json['permanent_address'],
      dateOfBirth: json['date_of_birth'],
      officialDateOfBirth: json['official_date_of_birth'],
      marriageDate: json['marriage_date'],
      emergencyContacts: json['emergency_contacts'],
      joiningDate: json['joining_date'],
      releavingDate: json['releaving_date'],
      remarks: json['remarks'],
      isSuperAdmin: json['is_super_admin'],
      employeeLevel: json['employee_level'],
      employmentStatus: json['employment_status'],
      isEligibleForLeaves: json['is_eligible_for_leaves'],
      selfiPhoto: json['selfi_photo'],
      familyPhoto: json['family_photo'],
      isSigninMandatory: json['is_signin_mandatory'],
      hasWorkPortalAccess: json['has_work_portal_access'],
      hasHrPortalAccess: json['has_hr_portal_access'],
      hasClientPortalAccess: json['has_client_portal_access'],
      hasInventoryPortalAccess: json['has_inventory_portal_access'],
      hasAccountPortalAccess: json['has_account_portal_access'],
      hasSeoPortalAccess: json['has_seo_portal_access'],
      hasLeadPortalAccess: json['has_lead_portal_access'],
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  // Method to convert Employee instance back to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['users_id'] = usersId;
    data['employee_id'] = employeeId;
    data['departments_id'] = departmentsId;
    data['employee_roles_id'] = employeeRolesId;
    data['phone_number'] = phoneNumber;
    data['email'] = email;
    data['address'] = address;
    data['permanent_address'] = permanentAddress;
    data['date_of_birth'] = dateOfBirth;
    data['official_date_of_birth'] = officialDateOfBirth;
    data['marriage_date'] = marriageDate;
    data['emergency_contacts'] = emergencyContacts;
    data['joining_date'] = joiningDate;
    data['releaving_date'] = releavingDate;
    data['remarks'] = remarks;
    data['is_super_admin'] = isSuperAdmin;
    data['employee_level'] = employeeLevel;
    data['employment_status'] = employmentStatus;
    data['is_eligible_for_leaves'] = isEligibleForLeaves;
    data['selfi_photo'] = selfiPhoto;
    data['family_photo'] = familyPhoto;
    data['is_signin_mandatory'] = isSigninMandatory;
    data['has_work_portal_access'] = hasWorkPortalAccess;
    data['has_hr_portal_access'] = hasHrPortalAccess;
    data['has_client_portal_access'] = hasClientPortalAccess;
    data['has_inventory_portal_access'] = hasInventoryPortalAccess;
    data['has_account_portal_access'] = hasAccountPortalAccess;
    data['has_seo_portal_access'] = hasSeoPortalAccess;
    data['has_lead_portal_access'] = hasLeadPortalAccess;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
