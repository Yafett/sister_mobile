part of 'get_profile_guardian_bloc.dart';

abstract class GetProfileGuardianEvent extends Equatable {
  const GetProfileGuardianEvent();

  @override
  List<ProfileGuardian> get props => [];
}

class GetProfileGuardianList extends GetProfileGuardianEvent {
  final String? code;

  const GetProfileGuardianList({this.code});
}
