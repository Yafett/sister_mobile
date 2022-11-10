part of 'get_payment_bloc.dart';

abstract class GetPaymentEvent extends Equatable {
  const GetPaymentEvent();

  @override
  List<Payment> get props => [];
}

class GetPaymentList extends GetPaymentEvent {
  final String? code;
  GetPaymentList({this.code});
}
