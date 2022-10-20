part of 'student_schedule_bloc.dart';

abstract class StudentScheduleEvent extends Equatable {
  const StudentScheduleEvent();

  @override
  List<Schedule> get props => [];
}

class GetScheduleList extends StudentScheduleEvent {}
