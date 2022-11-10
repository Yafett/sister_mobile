part of 'get_attendance_bloc.dart';

abstract class GetAttendanceState extends Equatable {
  const GetAttendanceState();

  @override
  List<Object> get props => [];
}

class GetAttendanceInitial extends GetAttendanceState {}

class GetAttendanceLoading extends GetAttendanceState {}

class GetAttendanceLoaded extends GetAttendanceState {
  final Attendance attendanceModel;
  GetAttendanceLoaded(this.attendanceModel);
}

class GetAttendanceError extends GetAttendanceState {
  final String? message;
  GetAttendanceError(this.message);
}
