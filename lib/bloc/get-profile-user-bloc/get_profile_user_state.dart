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
  GetProfileUserLoaded(this.modelUser);
}

class GetProfileUserError extends GetProfileUserState {
  final String? message;
  GetProfileUserError(this.message);
}
