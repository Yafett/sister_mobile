part of 'get_attendance_bloc.dart';

abstract class GetAttendanceEvent extends Equatable {
  const GetAttendanceEvent();

  @override
  List<Attendance> get props => [];
}

class GetAttendanceList extends GetAttendanceEvent {
  final String? code;
  const GetAttendanceList({this.code});
}
