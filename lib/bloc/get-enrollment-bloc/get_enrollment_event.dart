part of 'get_enrollment_bloc.dart';

abstract class GetEnrollmentEvent extends Equatable {
  const GetEnrollmentEvent();

  @override
  List<Enrollment> get props => [];
}

class GetEnrollmentList extends GetEnrollmentEvent {}
