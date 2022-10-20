class PointReward {
  Data? data;
  String? error;

  PointReward({this.data});

  PointReward.withError(String errorMessage) {
    error = errorMessage;
  }

  PointReward.fromJson(Map<String, dynamic> json) {
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
  String? student;
  String? type;
  String? balance;
  String? paymentEntry;
  double? point;
  String? remark;
  String? status;
  String? doctype;

  Data(
      {this.name,
      this.owner,
      this.creation,
      this.modified,
      this.modifiedBy,
      this.idx,
      this.docstatus,
      this.student,
      this.type,
      this.balance,
      this.paymentEntry,
      this.point,
      this.remark,
      this.status,
      this.doctype});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    creation = json['creation'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    idx = json['idx'];
    docstatus = json['docstatus'];
    student = json['student'];
    type = json['type'];
    balance = json['balance'];
    paymentEntry = json['payment_entry'];
    point = json['point'];
    remark = json['remark'];
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
    data['student'] = this.student;
    data['type'] = this.type;
    data['balance'] = this.balance;
    data['payment_entry'] = this.paymentEntry;
    data['point'] = this.point;
    data['remark'] = this.remark;
    data['status'] = this.status;
    data['doctype'] = this.doctype;
    return data;
  }
}
