import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sister_mobile/model/ProfileUser.dart';
import 'package:sister_mobile/resources/profile-provider.dart';

part 'get_profile_user_event.dart';
part 'get_profile_user_state.dart';

class GetProfileUserBloc
    extends Bloc<GetProfileUserEvent, GetProfileUserState> {
  GetProfileUserBloc() : super(GetProfileUserInitial()) {
    final _profileProvider = ProfileProvider();

    on<GetProfileUserList>((event, emit) async {
      try {
        emit(GetProfileUserLoading());
        final pList = await _profileProvider.fetchProfileUser(event.code);
        emit(GetProfileUserLoaded(pList));
        if (pList.error != null) {
          emit(GetProfileUserError(pList.error));
        }
      } on NetworkError {
        emit(GetProfileUserError(
            "Failed to fetch data. is your device online?"));
      }
    });
  }
}
