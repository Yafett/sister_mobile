class Enrollment {
  Data? data;
  String? error;
  
  Enrollment({this.data, this.error});

  Enrollment.withError(String errorMessage) {
    error = errorMessage;
  }
  Enrollment.fromJson(Map<String, dynamic> json) {
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
  String? workflowState;
  String? student;
  String? studentName;
  String? company;
  String? companyAbbr;
  int? needTest;
  String? status;
  String? program;
  String? feeStructure;
  String? academicYear;
  String? enrollmentDate;
  int? boardingStudent;
  String? modeOfTransportation;
  String? className;
  String? classFormat;
  String? classGrading;
  String? classType;
  String? classDuration;
  String? course;
  String? classNameAbbr;
  String? classFormatAbbr;
  String? classGradingAbbr;
  String? classTypeAbbr;
  String? classDurationAbbr;
  String? courseAbbr;
  String? doctype;
  List<Components>? components;
  // List<dynamic>? courses;
  // List<dynamic>? fees;

  Data({
    this.name,
    this.owner,
    this.creation,
    this.modified,
    this.modifiedBy,
    this.idx,
    this.docstatus,
    this.workflowState,
    this.student,
    this.studentName,
    this.company,
    this.companyAbbr,
    this.needTest,
    this.status,
    this.program,
    this.feeStructure,
    this.academicYear,
    this.enrollmentDate,
    this.boardingStudent,
    this.modeOfTransportation,
    this.className,
    this.classFormat,
    this.classGrading,
    this.classType,
    this.classDuration,
    this.course,
    this.classNameAbbr,
    this.classFormatAbbr,
    this.classGradingAbbr,
    this.classTypeAbbr,
    this.classDurationAbbr,
    this.courseAbbr,
    this.doctype,
    this.components,
    // this.courses,
    // this.fees,
  });

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    creation = json['creation'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    idx = json['idx'];
    docstatus = json['docstatus'];
    workflowState = json['workflow_state'];
    student = json['student'];
    studentName = json['student_name'];
    company = json['company'];
    companyAbbr = json['company_abbr'];
    needTest = json['need_test'];
    status = json['status'];
    program = json['program'];
    feeStructure = json['fee_structure'];
    academicYear = json['academic_year'];
    enrollmentDate = json['enrollment_date'];
    boardingStudent = json['boarding_student'];
    modeOfTransportation = json['mode_of_transportation'];
    className = json['class_name'];
    classFormat = json['class_format'];
    classGrading = json['class_grading'];
    classType = json['class_type'];
    classDuration = json['class_duration'];
    course = json['course'];
    classNameAbbr = json['class_name_abbr'];
    classFormatAbbr = json['class_format_abbr'];
    classGradingAbbr = json['class_grading_abbr'];
    classTypeAbbr = json['class_type_abbr'];
    classDurationAbbr = json['class_duration_abbr'];
    courseAbbr = json['course_abbr'];
    doctype = json['doctype'];
    if (json['components'] != null) {
      components = <Components>[];
      json['components'].forEach((v) {
        components!.add(new Components.fromJson(v));
      });
    }
    // if (json['courses'] != null) {
    //   courses = <Null>[];
    //   json['courses'].forEach((v) {
    //     courses!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['fees'] != null) {
    //   fees = <Null>[];
    //   json['fees'].forEach((v) {
    //     fees!.add(new Null.fromJson(v));
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
    data['workflow_state'] = this.workflowState;
    data['student'] = this.student;
    data['student_name'] = this.studentName;
    data['company'] = this.company;
    data['company_abbr'] = this.companyAbbr;
    data['need_test'] = this.needTest;
    data['status'] = this.status;
    data['program'] = this.program;
    data['fee_structure'] = this.feeStructure;
    data['academic_year'] = this.academicYear;
    data['enrollment_date'] = this.enrollmentDate;
    data['boarding_student'] = this.boardingStudent;
    data['mode_of_transportation'] = this.modeOfTransportation;
    data['class_name'] = this.className;
    data['class_format'] = this.classFormat;
    data['class_grading'] = this.classGrading;
    data['class_type'] = this.classType;
    data['class_duration'] = this.classDuration;
    data['course'] = this.course;
    data['class_name_abbr'] = this.classNameAbbr;
    data['class_format_abbr'] = this.classFormatAbbr;
    data['class_grading_abbr'] = this.classGradingAbbr;
    data['class_type_abbr'] = this.classTypeAbbr;
    data['class_duration_abbr'] = this.classDurationAbbr;
    data['course_abbr'] = this.courseAbbr;
    data['doctype'] = this.doctype;
    if (this.components != null) {
      data['components'] = this.components!.map((v) => v.toJson()).toList();
    }
    // if (this.courses != null) {
    //   data['courses'] = this.courses!.map((v) => v.toJson()).toList();
    // }
    // if (this.fees != null) {
    //   data['fees'] = this.fees!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class Components {
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
  String? feesCategory;
  int? amount;
  String? doctype;

  Components(
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
      this.feesCategory,
      this.amount,
      this.doctype});

  Components.fromJson(Map<String, dynamic> json) {
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
    feesCategory = json['fees_category'];
    amount = json['amount'];
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
    data['fees_category'] = this.feesCategory;
    data['amount'] = this.amount;
    data['doctype'] = this.doctype;
    return data;
  }
}
