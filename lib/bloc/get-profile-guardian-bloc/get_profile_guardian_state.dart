part of 'get_profile_guardian_bloc.dart';

abstract class GetProfileGuardianState extends Equatable {
  const GetProfileGuardianState();

  @override
  List<Object> get props => [];
}

class GetProfileGuardianInitial extends GetProfileGuardianState {}

class GetProfileGuardianLoading extends GetProfileGuardianState {}

class GetProfileGuardianEmpty extends GetProfileGuardianState {}

class GetProfileGuardianLoaded extends GetProfileGuardianState {
  final ProfileGuardian guardianModel;
  const GetProfileGuardianLoaded(this.guardianModel);
}

class GetProfileGuardianError extends GetProfileGuardianState {
  final String? message;
  const GetProfileGuardianError(this.message);
}
