part of 'student_schedule_bloc.dart';

abstract class StudentScheduleState extends Equatable {
  const StudentScheduleState();

  @override
  List<Schedule> get props => [];
}

class StudentScheduleInitial extends StudentScheduleState {}

class StudentScheduleLoading extends StudentScheduleState {}

class StudentScheduleLoaded extends StudentScheduleState {
  final Schedule scheduleModel;
  StudentScheduleLoaded(this.scheduleModel);
}

class StudentScheduleError extends StudentScheduleState {
  final String? message;
  StudentScheduleError(this.message);
}
