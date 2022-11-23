part of 'point_reward_bloc.dart';

abstract class PointRewardEvent extends Equatable {
  const PointRewardEvent();

  @override
  List<PointReward> get props => [];
}

class GetPointRewardList extends PointRewardEvent {
  final String? code;

  GetPointRewardList({this.code});
}
