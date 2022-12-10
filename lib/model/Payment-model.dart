// ignore_for_file: unused_import, unnecessary_new, prefer_collection_literals, unnecessary_this

import 'package:googleapis/cloudsearch/v1.dart';

class Payment {
  Data? data;
  String? error;
  
  Payment({this.data, this.error});

  Payment.withError(String errorMessage) {
    error = errorMessage;
  }

  Payment.fromJson(Map<String, dynamic> json) {
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
  int? includePayment;
  int? sendPaymentRequest;
  String? company;
  String? companyabbr;
  String? postingDate;
  String? postingTime;
  int? setPostingTime;
  String? dueDate;
  String? status;
  String? programEnrollment;
  String? program;
  String? studentEmail;
  String? academicYear;
  String? currency;
  String? feeStructure;
  double? grandTotal;
  String? grandTotalInWords;
  double? outstandingAmount;
  String? letterHead;
  String? receivableAccount;
  String? incomeAccount;
  String? costCenter;
  String? doctype;
  List<Components>? components;

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
      this.includePayment,
      this.sendPaymentRequest,
      this.company,
      this.companyabbr,
      this.postingDate,
      this.postingTime,
      this.setPostingTime,
      this.dueDate,
      this.status,
      this.programEnrollment,
      this.program,
      this.studentEmail,
      this.academicYear,
      this.currency,
      this.feeStructure,
      this.grandTotal,
      this.grandTotalInWords,
      this.outstandingAmount,
      this.letterHead,
      this.receivableAccount,
      this.incomeAccount,
      this.costCenter,
      this.doctype,
      this.components});

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
    includePayment = json['include_payment'];
    sendPaymentRequest = json['send_payment_request'];
    company = json['company'];
    companyabbr = json['companyabbr'];
    postingDate = json['posting_date'];
    postingTime = json['posting_time'];
    setPostingTime = json['set_posting_time'];
    dueDate = json['due_date'];
    status = json['status'];
    programEnrollment = json['program_enrollment'];
    program = json['program'];
    studentEmail = json['student_email'];
    academicYear = json['academic_year'];
    currency = json['currency'];
    feeStructure = json['fee_structure'];
    grandTotal = json['grand_total'];
    grandTotalInWords = json['grand_total_in_words'];
    outstandingAmount = json['outstanding_amount'];
    letterHead = json['letter_head'];
    receivableAccount = json['receivable_account'];
    incomeAccount = json['income_account'];
    costCenter = json['cost_center'];
    doctype = json['doctype'];
    if (json['components'] != null) {
      components = <Components>[];
      json['components'].forEach((v) {
        components!.add(new Components.fromJson(v));
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
    data['naming_series'] = this.namingSeries;
    data['student'] = this.student;
    data['student_name'] = this.studentName;
    data['include_payment'] = this.includePayment;
    data['send_payment_request'] = this.sendPaymentRequest;
    data['company'] = this.company;
    data['companyabbr'] = this.companyabbr;
    data['posting_date'] = this.postingDate;
    data['posting_time'] = this.postingTime;
    data['set_posting_time'] = this.setPostingTime;
    data['due_date'] = this.dueDate;
    data['status'] = this.status;
    data['program_enrollment'] = this.programEnrollment;
    data['program'] = this.program;
    data['student_email'] = this.studentEmail;
    data['academic_year'] = this.academicYear;
    data['currency'] = this.currency;
    data['fee_structure'] = this.feeStructure;
    data['grand_total'] = this.grandTotal;
    data['grand_total_in_words'] = this.grandTotalInWords;
    data['outstanding_amount'] = this.outstandingAmount;
    data['letter_head'] = this.letterHead;
    data['receivable_account'] = this.receivableAccount;
    data['income_account'] = this.incomeAccount;
    data['cost_center'] = this.costCenter;
    data['doctype'] = this.doctype;
    if (this.components != null) {
      data['components'] = this.components!.map((v) => v.toJson()).toList();
    }
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
  double? amount;
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
