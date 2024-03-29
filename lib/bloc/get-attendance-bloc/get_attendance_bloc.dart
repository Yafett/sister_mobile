// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sister_mobile/resources/data-provider.dart';

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
        print('zoku ' + pList.data.toString());
        if (pList.error != null) {
          emit(GetAttendanceError(pList.error));
        }
      } on NetworkError {
        emit(const GetAttendanceError(
            "Failed to fetch data. is your device online?"));
      }
    });
  }
}
