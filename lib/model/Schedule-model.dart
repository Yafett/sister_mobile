class Schedule {
  Data? data;
  String? error;

  Schedule({this.data});

  Schedule.withError(String errorMessage) {
    error = errorMessage;
  }

  Schedule.fromJson(Map<String, dynamic> json) {
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
  String? studentGroup;
  String? instructor;
  String? instructorName;
  String? company;
  String? companyAbbr;
  String? namingSeries;
  String? courseScheduleRepeat;
  String? program;
  String? course;
  String? colorCode;
  String? color;
  String? scheduleDate;
  String? room;
  String? fromTime;
  String? toTime;
  String? newToTime;
  String? title;
  String? status;
  String? doctype;

  Data({
    this.name,
    this.owner,
    this.creation,
    this.modified,
    this.modifiedBy,
    this.idx,
    this.docstatus,
    this.studentGroup,
    this.instructor,
    this.instructorName,
    this.company,
    this.companyAbbr,
    this.namingSeries,
    this.courseScheduleRepeat,
    this.program,
    this.course,
    this.colorCode,
    this.color,
    this.scheduleDate,
    this.room,
    this.fromTime,
    this.toTime,
    this.newToTime,
    this.title,
    this.status,
    this.doctype,
  });

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    creation = json['creation'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    idx = json['idx'];
    docstatus = json['docstatus'];
    studentGroup = json['student_group'];
    instructor = json['instructor'];
    instructorName = json['instructor_name'];
    company = json['company'];
    companyAbbr = json['company_abbr'];
    namingSeries = json['naming_series'];
    courseScheduleRepeat = json['course_schedule_repeat'];
    program = json['program'];
    course = json['course'];
    colorCode = json['color_code'];
    color = json['color'];
    scheduleDate = json['schedule_date'];
    room = json['room'];
    fromTime = json['from_time'];
    toTime = json['to_time'];
    newToTime = json['new_to_time'];
    title = json['title'];
    status = json['status'];
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
    data['student_group'] = this.studentGroup;
    data['instructor'] = this.instructor;
    data['instructor_name'] = this.instructorName;
    data['company'] = this.company;
    data['company_abbr'] = this.companyAbbr;
    data['naming_series'] = this.namingSeries;
    data['course_schedule_repeat'] = this.courseScheduleRepeat;
    data['program'] = this.program;
    data['course'] = this.course;
    data['color_code'] = this.colorCode;
    data['color'] = this.color;
    data['schedule_date'] = this.scheduleDate;
    data['room'] = this.room;
    data['from_time'] = this.fromTime;
    data['to_time'] = this.toTime;
    data['new_to_time'] = this.newToTime;
    data['title'] = this.title;
    data['status'] = this.status;
    data['doctype'] = this.doctype;

    return data;
  }
}
