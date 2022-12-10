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
  const GetPaymentLoaded(this.paymentModel);
}

class GetPaymentError extends GetPaymentState {
  final String? message;
  const GetPaymentError(this.message);
}
