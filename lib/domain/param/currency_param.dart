import '../../data/source/remote/response/currency_response.dart';

class CurrencyParam {
  final String name;
  final String code;
  final double rate;
  final double change;
  final String date;

  CurrencyParam({
    required this.name,
    required this.code,
    required this.rate,
    required this.change,
    required this.date,
  });

  factory CurrencyParam.fromResponse(
      CurrencyResponse res,
      AppLanguage lang,
      ) {
    final name = switch (lang) {
      AppLanguage.ru  => res.ccyNmRU ?? res.ccy ?? '',
      AppLanguage.en  => res.ccyNmEN ?? res.ccy ?? '',
      AppLanguage.uzc => res.ccyNmUZC ?? res.ccy ?? '',
      AppLanguage.uz  => res.ccyNmUZ ?? res.ccy ?? '',
    };

    return CurrencyParam(
      name: name,
      code: res.ccy ?? '',
      rate: double.tryParse(res.rate ?? '0') ?? 0,
      change: double.tryParse(res.diff ?? '0') ?? 0,
      date: res.date ?? '',
    );
  }
}
enum AppLanguage {
  uz,
  ru,
  en,
  uzc,
}

