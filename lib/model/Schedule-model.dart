// ignore_for_file: unnecessary_new, unnecessary_this, prefer_collection_literals

class Schedule {
  List<Message>? message;
  String? error;

  Schedule({this.message, this.error});

  Schedule.withError(String errorMessage) {
    error = errorMessage;
  }

  Schedule.fromJson(Map<String, dynamic> json) {
    if (json['message'] != null) {
      message = <Message>[];
      json['message'].forEach((v) {
        message!.add(new Message.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.message != null) {
      data['message'] = this.message!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Message {
  String? name;
  String? title;
  String? fromTime;
  String? toTime;
  String? instructorName;
  String? scheduleDate;
  String? room;
  String? status;
  String? course;

  Message(
      {this.name,
      this.title,
      this.fromTime,
      this.toTime,
      this.instructorName,
      this.scheduleDate,
      this.room,
      this.status,
      this.course});

  Message.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    title = json['title'];
    fromTime = json['from_time'];
    toTime = json['to_time'];
    instructorName = json['instructor_name'];
    scheduleDate = json['schedule_date'];
    room = json['room'];
    status = json['status'];
    course = json['course'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['title'] = this.title;
    data['from_time'] = this.fromTime;
    data['to_time'] = this.toTime;
    data['instructor_name'] = this.instructorName;
    data['schedule_date'] = this.scheduleDate;
    data['room'] = this.room;
    data['status'] = this.status;
    data['course'] = this.course;
    return data;
  }
}
