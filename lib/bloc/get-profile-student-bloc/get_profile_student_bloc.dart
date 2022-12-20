// ignore_for_file: avoid_print, no_leading_underscores_for_local_identifiers

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sister_mobile/resources/profile-provider.dart';

import '../../model/ProfileStudent-model.dart';

part 'get_profile_student_event.dart';
part 'get_profile_student_state.dart';

class GetProfileStudentBloc
    extends Bloc<GetProfileStudentEvent, GetProfileStudentState> {
  GetProfileStudentBloc() : super(GetProfileInitial()) {
    final _profileProvider = ProfileProvider();

    on<GetProfileList>((event, emit) async {
      try {
        emit(GetProfileLoading());
        final pList = await _profileProvider.fetchProfileStudent( event.code);
        emit(GetProfileLoaded(pList));
        print(pList.error);
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
