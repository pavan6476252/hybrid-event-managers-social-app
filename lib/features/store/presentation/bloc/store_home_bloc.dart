import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hybrid/core/api_resository.dart';
import 'package:hybrid/core/failure.dart';
import 'package:hybrid/features/store/domain/model/store_model.dart'; 

part 'store_home_event.dart';
part 'store_home_state.dart';

class StoreHomeBloc extends Bloc<StoreHomeEvent, StoreHomeState> {
  ApiRepository apiRepository;
  StoreHomeBloc(this.apiRepository) : super(StoreHomeInitial()) {
    on<StoreHomeGetEvent>(_getStoreHome);
  }

  _getStoreHome(StoreHomeGetEvent event, Emitter emit) async {
    final res = await apiRepository.get('http://localhost:3000/api/store',
        requireAuth: false);
    res.fold((failure) {
      emit(StoreHomeFailed(failure: failure));
    }, (response) {
      print(response.body);
      emit(StoreHomeLoaded(StoreHomeModel.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>)));
    });
  }
}
