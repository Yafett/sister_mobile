part of 'get_profile_user_bloc.dart';

abstract class GetProfileUserEvent extends Equatable {
  const GetProfileUserEvent();

  @override
  List<ProfileUser> get props => [];
}

class GetProfileUserList extends GetProfileUserEvent {
  final String? code;

  GetProfileUserList({this.code});
}
