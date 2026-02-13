part of 'main_bloc.dart';

class MainState {
  final List<CurrencyResponse>? data;
  final Status status;
  final String? errorMessage;
  final AppLanguage language;
  final DateTime date;

   MainState({
    this.data,
    this.status = Status.initial,
    this.errorMessage,
    this.language = AppLanguage.uz,
    DateTime? date,
  }) : date = date ?? DateTime.now();

  MainState copyWith({
    List<CurrencyResponse>? data,
    Status? status,
    String? errorMessage,
    AppLanguage? language,
    DateTime? date,
  }) {
    return MainState(
      data: data ?? this.data,
      status: status ?? this.status,
      errorMessage: errorMessage,
      language: language ?? this.language,
      date: date ?? this.date,
    );
  }
}


enum Status { initial, loading, fail, success }