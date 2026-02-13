
import 'package:valute_app/data/source/remote/response/currency_response.dart';

abstract class CurrencyRepository {
  Future<List<CurrencyResponse>>getCurrency();
  Future<List<CurrencyResponse>>getCurrencyByDate(DateTime date);
}