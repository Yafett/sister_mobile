import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sister_mobile/resources/profile_provider.dart';

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
        final pList = await _profileProvider.fetchProfileStudent();
        emit(GetProfileLoaded(pList)); 
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
