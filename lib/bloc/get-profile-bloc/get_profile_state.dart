part of 'get_profile_bloc.dart';

abstract class GetProfileState extends Equatable {
  const GetProfileState();

  @override
  List<Profile> get props => [];
}

class GetProfileInitial extends GetProfileState {}

class GetProfileLoading extends GetProfileState {}

class GetProfileLoaded extends GetProfileState {
  final Profile profileModel;
  const GetProfileLoaded(this.profileModel);
}

class GetProfileError extends GetProfileState {
  final String? message;
  const GetProfileError(this.message);
}
