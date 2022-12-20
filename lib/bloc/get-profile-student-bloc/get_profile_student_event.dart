part of 'get_profile_student_bloc.dart';

abstract class GetProfileStudentEvent extends Equatable {
  const GetProfileStudentEvent();

  @override
  List<Profile> get props => [];
}

class GetProfileList extends GetProfileStudentEvent {
  final String? code;

  const GetProfileList({this.code});
}
