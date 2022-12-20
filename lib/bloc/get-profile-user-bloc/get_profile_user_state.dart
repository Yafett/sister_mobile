part of 'get_profile_user_bloc.dart';

abstract class GetProfileUserState extends Equatable {
  const GetProfileUserState();

  @override
  List<ProfileUser> get props => [];
}

class GetProfileUserInitial extends GetProfileUserState {}

class GetProfileUserLoading extends GetProfileUserState {}

class GetProfileUserLoaded extends GetProfileUserState {
  final ProfileUser modelUser;
  const GetProfileUserLoaded(this.modelUser);
}

class GetProfileUserError extends GetProfileUserState {
  final String? message;
  const GetProfileUserError(this.message);
}
