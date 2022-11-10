part of 'get_payment_bloc.dart';

abstract class GetPaymentState extends Equatable {
  const GetPaymentState();

  @override
  List<Object> get props => [];
}

class GetPaymentInitial extends GetPaymentState {}

class GetPaymentLoading extends GetPaymentState {}

class GetPaymentLoaded extends GetPaymentState {
  final Payment paymentModel;
  GetPaymentLoaded(this.paymentModel);
}

class GetPaymentError extends GetPaymentState {
  final String? message;
  GetPaymentError(this.message);
}
