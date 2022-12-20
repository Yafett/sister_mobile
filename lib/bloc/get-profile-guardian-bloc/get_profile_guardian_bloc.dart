// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sister_mobile/model/ProfileGuardian-model.dart';
import 'package:sister_mobile/resources/profile-provider.dart';

part 'get_profile_guardian_event.dart';
part 'get_profile_guardian_state.dart';

class GetProfileGuardianBloc
    extends Bloc<GetProfileGuardianEvent, GetProfileGuardianState> {
  GetProfileGuardianBloc() : super(GetProfileGuardianInitial()) {
    on<GetProfileGuardianList>((event, emit) async {
      final _profileProvider = ProfileProvider();

      try {
        emit(GetProfileGuardianLoading());
        final pList = await _profileProvider.fetchProfileGuardian(event.code);
        emit(GetProfileGuardianLoaded(pList));
        if (pList.error != null) {
          emit(GetProfileGuardianError(pList.error));
        }
      } on NetworkError {
        emit(const GetProfileGuardianError(
            "Failed to fetch data. is your device online?"));
      }
    });
  }
}
