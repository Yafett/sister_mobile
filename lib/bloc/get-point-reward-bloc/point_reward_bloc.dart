import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sister_mobile/model/PointReward-model.dart';

import '../../resources/data_provider.dart';

part 'point_reward_event.dart';
part 'point_reward_state.dart';

class PointRewardBloc extends Bloc<PointRewardEvent, PointRewardState> {
  PointRewardBloc() : super(PointRewardInitial()) {
    final _pointProvider = DataProvider();

    on<GetPointRewardList>((event, emit) async {
      try {
        emit(PointRewardLoading());
        final pList = await _pointProvider.fetchPointReward(event.code);
        emit(PointRewardLoaded(pList));
      
      } on NetworkError {
        emit(PointRewardError("Failed to fetch data. is your device online?"));
      }
    });
  }
}
