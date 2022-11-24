import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sister_mobile/resources/data_provider.dart';

import '../../model/Attendance-model.dart';

part 'get_attendance_event.dart';
part 'get_attendance_state.dart';

class GetAttendanceBloc extends Bloc<GetAttendanceEvent, GetAttendanceState> {
  GetAttendanceBloc() : super(GetAttendanceInitial()) {
    final _attendanceProvider = DataProvider();

    on<GetAttendanceList>((event, emit) async {
      try {
        emit(GetAttendanceLoading());
        final pList = await _attendanceProvider.fetchAttendance(event.code);
        emit(GetAttendanceLoaded(pList));
        if (pList.error != null) {
          emit(GetAttendanceError(pList.error));
        }
      } on NetworkError {
        emit(
            GetAttendanceError("Failed to fetch data. is your device online?"));
      }
    });
  }
}
