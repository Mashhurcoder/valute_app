import 'package:valute_app/data/source/remote/response/currency_response.dart';
import 'package:valute_app/data/source/remote/service/currency_service.dart';

import '../../domain/currency_repository.dart';

class CurrencyRepositoryImpl extends CurrencyRepository {
  final currencyService = CurrencyService();

  @override
  Future<List<CurrencyResponse>> getCurrency() async {
    try {
      final result = await currencyService.getCurrencies();
      return result;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<CurrencyResponse>> getCurrencyByDate(DateTime date) async {

    try {
      final result = await currencyService.getCurrenciesByDate(date);
      return result;
    } catch (e) {
      rethrow;
    }
  }
}
