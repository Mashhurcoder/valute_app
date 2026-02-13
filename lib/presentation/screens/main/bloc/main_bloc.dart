import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:valute_app/data/repository/currency_repository_impl.dart';
import 'package:valute_app/data/source/remote/response/currency_response.dart';

import '../../../../domain/param/currency_param.dart';

part 'main_event.dart';

part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainState(status: Status.initial)) {
    final currencyRepository = CurrencyRepositoryImpl();
    on<GetCurrencyEvent>((event, emit) async {
      emit(state.copyWith(status: Status.loading));
      try {
        final data = await currencyRepository.getCurrency();
        emit(state.copyWith(data: data, status: Status.success));
      } catch (e) {
        if (e is DioException) {
          emit(state.copyWith(status: Status.fail, errorMessage: e.message));
          return;
        }
        emit(state.copyWith(status: Status.fail, errorMessage: e.toString()));
      }
    });
    on<ChangeLanguageEvent>((event, emit) {
      emit(state.copyWith(language: event.language));
    });
    on<ChangeDateEvent>((event, emit) async {
      emit(state.copyWith(status: Status.loading, date: event.date));
      try {
        final data =
        await currencyRepository.getCurrencyByDate(event.date);
        emit(state.copyWith(
          data: data,
          status: Status.success,
        ));
      } catch (e) {
        emit(state.copyWith(
          status: Status.fail,
          errorMessage: e.toString(),
        ));
      }
    });
  }
}
