// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sister_mobile/resources/data-provider.dart';

import '../../model/Payment-model.dart';

part 'get_payment_event.dart';
part 'get_payment_state.dart';

class GetPaymentBloc extends Bloc<GetPaymentEvent, GetPaymentState> {
  GetPaymentBloc({String? code}) : super(GetPaymentInitial()) {
    final _paymentProvider = DataProvider();

    on<GetPaymentList>((event, emit) async {
      try {
        emit(GetPaymentLoading());
        final pList = await _paymentProvider.fetchFees(event.code.toString());
        emit(GetPaymentLoaded(pList));
        if (pList.error != null) {
          emit(GetPaymentError(pList.error));
        }
      } on NetworkError {
        emit(const GetPaymentError("Failed to fetch data. is your device online?"));
      }
    });
  }
}
