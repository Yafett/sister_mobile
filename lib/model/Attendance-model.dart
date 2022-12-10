// ignore_for_file: unnecessary_new, prefer_collection_literals, unnecessary_this

class Attendance {
  Data? data;
  String? error;

  Attendance.withError(String errorMessage) {
    error = errorMessage;
  }
  Attendance({this.data, this.error});

  Attendance.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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
  String? namingSeries;
  String? student;
  String? studentName;
  String? studentMobileNumber;
  String? instructor;
  String? courseSchedule;
  String? studentGroup;
  String? date;
  String? status;
  double? growthPoint;
  String? comment;
  String? lesson;
  String? doctype;

  Data(
      {this.name,
      this.owner,
      this.creation,
      this.modified,
      this.modifiedBy,
      this.idx,
      this.docstatus,
      this.namingSeries,
      this.student,
      this.studentName,
      this.studentMobileNumber,
      this.instructor,
      this.courseSchedule,
      this.studentGroup,
      this.date,
      this.status,
      this.growthPoint,
      this.comment,
      this.lesson,
      this.doctype});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    creation = json['creation'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    idx = json['idx'];
    docstatus = json['docstatus'];
    namingSeries = json['naming_series'];
    student = json['student'];
    studentName = json['student_name'];
    studentMobileNumber = json['student_mobile_number'];
    instructor = json['instructor'];
    courseSchedule = json['course_schedule'];
    studentGroup = json['student_group'];
    date = json['date'];
    status = json['status'];
    growthPoint = json['growth_point'];
    comment = json['comment'];
    lesson = json['lesson'];
    doctype = json['doctype'];
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
    data['naming_series'] = this.namingSeries;
    data['student'] = this.student;
    data['student_name'] = this.studentName;
    data['student_mobile_number'] = this.studentMobileNumber;
    data['instructor'] = this.instructor;
    data['course_schedule'] = this.courseSchedule;
    data['student_group'] = this.studentGroup;
    data['date'] = this.date;
    data['status'] = this.status;
    data['growth_point'] = this.growthPoint;
    data['comment'] = this.comment;
    data['lesson'] = this.lesson;
    data['doctype'] = this.doctype;
    return data;
  }
}
