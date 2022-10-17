part of 'get_profile_student_bloc.dart';

abstract class GetProfileStudentState extends Equatable {
  const GetProfileStudentState();

  @override
  List<Profile> get props => [];
}

class GetProfileInitial extends GetProfileStudentState {}

class GetProfileLoading extends GetProfileStudentState {}

class GetProfileEmpty extends GetProfileStudentState {}

class GetProfileLoaded extends GetProfileStudentState {
  final Profile profileModel;
  const GetProfileLoaded(this.profileModel);
}

class GetProfileError extends GetProfileStudentState {
  final String? message;
  const GetProfileError(this.message);
}
