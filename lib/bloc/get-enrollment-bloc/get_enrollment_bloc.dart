// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sister_mobile/model/Enrollment-model.dart';
import 'package:sister_mobile/resources/data-provider.dart';

part 'get_enrollment_event.dart';
part 'get_enrollment_state.dart';

class GetEnrollmentBloc extends Bloc<GetEnrollmentEvent, GetEnrollmentState> {
  GetEnrollmentBloc() : super(GetEnrollmentInitial()) {
    final _dataProvider = DataProvider();

    on<GetEnrollmentList>((event, emit) async {
      try {
        emit(GetEnrollmentLoading());
        final pList = await _dataProvider.fetchEnrollment(event.code);
        emit(GetEnrollmentLoaded(pList));
        if (pList.error != null) {
          emit(GetEnrollmentError(pList.error));
        }
      } on NetworkError {
        emit(
            const GetEnrollmentError("Failed to fetch data. is your device online?"));
      }
    });
  }
}
