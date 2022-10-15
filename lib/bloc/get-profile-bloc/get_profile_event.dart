part of 'get_profile_bloc.dart';

abstract class GetProfileEvent extends Equatable {
  const GetProfileEvent();

  @override
  List<Profile> get props => [];
}

class GetProfileList extends GetProfileEvent {}
