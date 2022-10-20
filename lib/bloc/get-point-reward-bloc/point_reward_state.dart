part of 'point_reward_bloc.dart';

abstract class PointRewardState extends Equatable {
  const PointRewardState();

  @override
  List<Object> get props => [];
}

class PointRewardInitial extends PointRewardState {}

class PointRewardLoading extends PointRewardState {}

class PointRewardLoaded extends PointRewardState {
  final PointReward pointModel;
  PointRewardLoaded(this.pointModel);
}

class PointRewardError extends PointRewardState {
  final String? message;
  PointRewardError(this.message);
}
