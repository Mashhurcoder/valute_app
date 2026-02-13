import 'package:dio/dio.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:valute_app/data/source/remote/response/currency_response.dart';

class CurrencyService {
  final dio =
      Dio(
          BaseOptions(
            baseUrl: 'https://cbu.uz',
            connectTimeout: Duration(seconds: 30),
            receiveTimeout: Duration(seconds: 30),
            sendTimeout: Duration(seconds: 30),
            receiveDataWhenStatusError: true,
          ),
        )
        ..interceptors.add(
          TalkerDioLogger(
            settings: const TalkerDioLoggerSettings(
              printResponseMessage: true,
              printRequestData: true,
              printResponseData: true,
            ),
          ),
        );

  Future<List<CurrencyResponse>> getCurrencies() async {
    try {
      final response = await dio.get('/uz/arkhiv-kursov-valyut/json/');
      return (response.data as List)
          .map((e) => CurrencyResponse.fromJson(e))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
  Future<List<CurrencyResponse>> getCurrenciesByDate(DateTime date) async {
    try {
      final formattedDate =
          "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";

      final response =
      await dio.get('/uz/arkhiv-kursov-valyut/json/all/$formattedDate/'
      );

      return (response.data as List)
          .map((e) => CurrencyResponse.fromJson(e))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
