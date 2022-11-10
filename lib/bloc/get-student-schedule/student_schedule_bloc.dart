import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sister_mobile/bloc/get-profile-student-bloc/get_profile_student_bloc.dart';
import 'package:sister_mobile/model/Schedule-model.dart';
import 'package:sister_mobile/resources/data_provider.dart';

part 'student_schedule_event.dart';
part 'student_schedule_state.dart';

class StudentScheduleBloc
    extends Bloc<StudentScheduleEvent, StudentScheduleState> {
      
  StudentScheduleBloc() : super(StudentScheduleInitial()) {
    on<GetScheduleList>((event, emit) async {
      final _dataProvider = DataProvider();

      try {
        emit(StudentScheduleLoading());
        final pList = await _dataProvider.fetchSchedule();
        emit(StudentScheduleLoaded(pList));
        if (pList.error != null) {
          emit(StudentScheduleError(pList.error));
        }
      } on NetworkError {
        emit(StudentScheduleError(
            "Failed to fetch data. is your device online?"));
      }
    });
  }
}
