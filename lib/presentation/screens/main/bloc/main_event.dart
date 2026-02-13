part of 'main_bloc.dart';

@immutable
abstract class MainEvent {}
class GetCurrencyEvent extends MainEvent{}
class ChangeLanguageEvent extends MainEvent {
  final AppLanguage language;
  ChangeLanguageEvent(this.language);
}
class ChangeDateEvent extends MainEvent{
  final DateTime date;
  ChangeDateEvent(this.date);
}
