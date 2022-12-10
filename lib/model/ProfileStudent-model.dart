// ignore_for_file: unnecessary_new, prefer_collection_literals, unnecessary_this

class Profile {
  ProfileData? data;
  String? error;

  Profile({this.data});

  Profile.withError(String errorMessage) {
    error = errorMessage;
  }

  Profile.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new ProfileData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ProfileData {
  String? name;
  String? owner;
  String? creation;
  String? modified;
  String? modifiedBy;
  int? idx;
  int? docstatus;
  int? enabled;
  String? status;
  String? nis;
  String? user;
  String? studentEmailId;
  String? studentMobileNumber;
  int? acceptEmail;
  int? acceptWa;
  String? firstName;
  String? lastName;
  String? company;
  String? companyAbbr;
  String? namingSeries;
  String? reasonJoining;
  String? knowFrom;
  String? followUp;
  String? mgm;
  String? joiningDate;
  String? image;
  String? reasonForLeaving;
  String? dateOfLeaving;
  String? dateOfBirth;
  String? placeOfBirth;
  String? bloodGroup;
  String? igUser;
  String? lastEdu;
  String? gender;
  String? nationality;
  String? religion;
  String? addressLine1;
  String? pincode;
  String? city;
  String? title;
  double? point;
  String? doctype;
  List<Guardians>? guardians;

  ProfileData({
    this.name,
    this.owner,
    this.creation,
    this.modified,
    this.modifiedBy,
    this.idx,
    this.docstatus,
    this.enabled,
    this.status,
    this.nis,
    this.user,
    this.studentEmailId,
    this.studentMobileNumber,
    this.acceptEmail,
    this.acceptWa,
    this.firstName,
    this.lastName,
    this.company,
    this.companyAbbr,
    this.namingSeries,
    this.reasonJoining,
    this.knowFrom,
    this.followUp,
    this.mgm,
    this.joiningDate,
    this.image,
    this.reasonForLeaving,
    this.dateOfLeaving,
    this.dateOfBirth,
    this.placeOfBirth,
    this.bloodGroup,
    this.igUser,
    this.lastEdu,
    this.gender,
    this.nationality,
    this.religion,
    this.addressLine1,
    this.pincode,
    this.city,
    this.title,
    this.point,
    this.doctype,
    this.guardians,
  });

  ProfileData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    creation = json['creation'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    idx = json['idx'];
    docstatus = json['docstatus'];
    enabled = json['enabled'];
    status = json['status'];
    nis = json['nis'];
    user = json['user'];
    studentEmailId = json['student_email_id'];
    studentMobileNumber = json['student_mobile_number'];
    acceptEmail = json['accept_email'];
    acceptWa = json['accept_wa'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    company = json['company'];
    companyAbbr = json['company_abbr'];
    namingSeries = json['naming_series'];
    reasonJoining = json['reason_joining'];
    image = json['image'];
    knowFrom = json['know_from'];
    followUp = json['follow_up'];
    mgm = json['mgm'];
    joiningDate = json['joining_date'];
    reasonForLeaving = json['reason_for_leaving'];
    dateOfLeaving = json['date_of_leaving'];
    dateOfBirth = json['date_of_birth'];
    placeOfBirth = json['place_of_birth'];
    bloodGroup = json['blood_group'];
    igUser = json['ig_user'];
    lastEdu = json['last_edu'];
    gender = json['gender'];
    nationality = json['nationality'];
    religion = json['religion'];
    addressLine1 = json['address_line_1'];
    pincode = json['pincode'];
    city = json['city'];
    title = json['title'];
    point = json['point'];
    doctype = json['doctype'];
    if (json['guardians'] != null) {
      guardians = <Guardians>[];
      json['guardians'].forEach((v) {
        guardians!.add(new Guardians.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['owner'] = this.owner;
    data['creation'] = this.creation;
    data['modified'] = this.modified;
    data['modified_by'] = this.modifiedBy;
    data['idx'] = this.idx;
    data['docstatus'] = this.docstatus;
    data['enabled'] = this.enabled;
    data['status'] = this.status;
    data['nis'] = this.nis;
    data['user'] = this.user;
    data['student_email_id'] = this.studentEmailId;
    data['student_mobile_number'] = this.studentMobileNumber;
    data['accept_email'] = this.acceptEmail;
    data['accept_wa'] = this.acceptWa;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['company'] = this.company;
    data['company_abbr'] = this.companyAbbr;
    data['naming_series'] = this.namingSeries;
    data['reason_joining'] = this.reasonJoining;
    data['image'] = this.image;
    data['know_from'] = this.knowFrom;
    data['follow_up'] = this.followUp;
    data['mgm'] = this.mgm;
    data['joining_date'] = this.joiningDate;
    data['reason_for_leaving'] = this.reasonForLeaving;
    data['date_of_leaving'] = this.dateOfLeaving;
    data['date_of_birth'] = this.dateOfBirth;
    data['place_of_birth'] = this.placeOfBirth;
    data['blood_group'] = this.bloodGroup;
    data['ig_user'] = this.igUser;
    data['last_edu'] = this.lastEdu;
    data['gender'] = this.gender;
    data['nationality'] = this.nationality;
    data['religion'] = this.religion;
    data['address_line_1'] = this.addressLine1;
    data['pincode'] = this.pincode;
    data['city'] = this.city;
    data['title'] = this.title;
    data['point'] = this.point;
    data['doctype'] = this.doctype;
    if (this.guardians != null) {
      data['guardians'] = this.guardians!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class Guardians {
  String? name;
  String? owner;
  String? creation;
  String? modified;
  String? modifiedBy;
  String? parent;
  String? parentfield;
  String? parenttype;
  int? idx;
  int? docstatus;
  String? guardian;
  String? guardianName;
  String? relation;
  String? doctype;

  Guardians(
      {this.name,
      this.owner,
      this.creation,
      this.modified,
      this.modifiedBy,
      this.parent,
      this.parentfield,
      this.parenttype,
      this.idx,
      this.docstatus,
      this.guardian,
      this.guardianName,
      this.relation,
      this.doctype});

  Guardians.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    creation = json['creation'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    parent = json['parent'];
    parentfield = json['parentfield'];
    parenttype = json['parenttype'];
    idx = json['idx'];
    docstatus = json['docstatus'];
    guardian = json['guardian'];
    guardianName = json['guardian_name'];
    relation = json['relation'];
    doctype = json['doctype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['owner'] = this.owner;
    data['creation'] = this.creation;
    data['modified'] = this.modified;
    data['modified_by'] = this.modifiedBy;
    data['parent'] = this.parent;
    data['parentfield'] = this.parentfield;
    data['parenttype'] = this.parenttype;
    data['idx'] = this.idx;
    data['docstatus'] = this.docstatus;
    data['guardian'] = this.guardian;
    data['guardian_name'] = this.guardianName;
    data['relation'] = this.relation;
    data['doctype'] = this.doctype;
    return data;
  }
}
