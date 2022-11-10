part of 'get_enrollment_bloc.dart';

abstract class GetEnrollmentState extends Equatable {
  const GetEnrollmentState();

  @override
  List<Enrollment> get props => [];
}

class GetEnrollmentInitial extends GetEnrollmentState {}

class GetEnrollmentLoading extends GetEnrollmentState {}

class GetEnrollmentLoaded extends GetEnrollmentState {
  final Enrollment enrollModel;
  const   GetEnrollmentLoaded(this.enrollModel);
}

class GetEnrollmentError extends GetEnrollmentState {
  final String? error;
  const GetEnrollmentError(this.error);
}
