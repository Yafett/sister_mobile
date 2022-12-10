// ignore_for_file: unnecessary_this, unnecessary_new

class ProfileGuardian {
  Data? data;
  String? error;
  ProfileGuardian({this.data, this.error});

  ProfileGuardian.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  ProfileGuardian.withError(String errorMessage) {
    error = errorMessage;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? name;
  String? owner;
  String? creation;
  String? modified;
  String? modifiedBy;
  int? idx;
  int? docstatus;
  String? guardianName;
  String? mobileNumber;
  String? emailAddress;
  String? user;
  int? acceptEmail;
  int? acceptWa;
  String? occupation;
  String? igUser;
  String? image;
  String? doctype;
  List<Students>? students;
  // List<Null>? interests;

  Data({
    this.name,
    this.owner,
    this.creation,
    this.modified,
    this.modifiedBy,
    this.idx,
    this.docstatus,
    this.guardianName,
    this.mobileNumber,
    this.emailAddress,
    this.user,
    this.acceptEmail,
    this.acceptWa,
    this.occupation,
    this.igUser,
    this.image,
    this.doctype,
    this.students,
    // this.interests
  });

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    creation = json['creation'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    idx = json['idx'];
    docstatus = json['docstatus'];
    guardianName = json['guardian_name'];
    mobileNumber = json['mobile_number'];
    emailAddress = json['email_address'];
    user = json['user'];
    acceptEmail = json['accept_email'];
    acceptWa = json['accept_wa'];
    occupation = json['occupation'];
    igUser = json['ig_user'];
    image = json['image'];
    doctype = json['doctype'];
    if (json['students'] != null) {
      students = <Students>[];
      json['students'].forEach((v) {
        students!.add(new Students.fromJson(v));
      });
    }
    // if (json['interests'] != null) {
    //   interests = <Null>[];
    //   json['interests'].forEach((v) {
    //     interests!.add(new Null.fromJson(v));
    //   });
    // }
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
    data['guardian_name'] = this.guardianName;
    data['mobile_number'] = this.mobileNumber;
    data['email_address'] = this.emailAddress;
    data['user'] = this.user;
    data['accept_email'] = this.acceptEmail;
    data['accept_wa'] = this.acceptWa;
    data['occupation'] = this.occupation;
    data['ig_user'] = this.igUser;
    data['image'] = this.image;
    data['doctype'] = this.doctype;
    if (this.students != null) {
      data['students'] = this.students!.map((v) => v.toJson()).toList();
    }
    // if (this.interests != null) {
    //   data['interests'] = this.interests!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class Students {
  String? parent;
  String? parentfield;
  String? parenttype;
  int? idx;
  int? docstatus;
  String? student;
  String? studentName;
  String? doctype;
  int? iIslocal;

  Students(
      {this.parent,
      this.parentfield,
      this.parenttype,
      this.idx,
      this.docstatus,
      this.student,
      this.studentName,
      this.doctype,
      this.iIslocal});

  Students.fromJson(Map<String, dynamic> json) {
    parent = json['parent'];
    parentfield = json['parentfield'];
    parenttype = json['parenttype'];
    idx = json['idx'];
    docstatus = json['docstatus'];
    student = json['student'];
    studentName = json['student_name'];
    doctype = json['doctype'];
    iIslocal = json['__islocal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['parent'] = this.parent;
    data['parentfield'] = this.parentfield;
    data['parenttype'] = this.parenttype;
    data['idx'] = this.idx;
    data['docstatus'] = this.docstatus;
    data['student'] = this.student;
    data['student_name'] = this.studentName;
    data['doctype'] = this.doctype;
    data['__islocal'] = this.iIslocal;
    return data;
  }
}
