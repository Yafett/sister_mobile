import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sister_mobile/resources/profile_provider.dart';

import '../../model/Profile-model.dart';

part 'get_profile_event.dart';
part 'get_profile_state.dart';

class GetProfileBloc extends Bloc<GetProfileEvent, GetProfileState> {
  GetProfileBloc() : super(GetProfileInitial()) {
    final _profileProvider = ProfileProvider();

    on<GetProfileList>((event, emit) async {
      try {
        emit(GetProfileLoading());
        print('dandadan');
        final pList = await _profileProvider.fetchProfile();
        emit(GetProfileLoaded(pList));
        print('dandadan');
        if (pList.error != null) {
          emit(GetProfileError(pList.error));
        }
      } on NetworkError {
        emit(const GetProfileError(
            "Failed to fetch data. is your device online?"));
      }
    });
  }
}
