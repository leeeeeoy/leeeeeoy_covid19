import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:leeeeeoy_covid19/src/model/covid_statistics.dart';
import 'package:xml/xml.dart';

class CovidStatisticsRepository {
  late var _dio;

  CovidStatisticsRepository() {
    String? key = dotenv.env['API_KEY'];

    _dio = Dio(
      BaseOptions(
        baseUrl: 'http://openapi.data.go.kr',
        queryParameters: {
          'ServiceKey': key,
        },
      ),
    );
  }

  Future<List<Covid19Statistics>> fetchCovid19Statistics(
      {String? startDate, String? endDate}) async {
    var query = Map<String, String>();

    if (startDate != null) query.putIfAbsent('startCreateDt', () => startDate);

    if (endDate != null) query.putIfAbsent('endCreateDt', () => endDate);

    var response = await _dio.get(
        '/openapi/service/rest/Covid19/getCovid19InfStateJson',
        queryParameters: query);

    final document = XmlDocument.parse(response.data);
    final results = document.findAllElements('item');

    if (results.isNotEmpty) {
      return results
          .map<Covid19Statistics>(
              (element) => Covid19Statistics.fromXml(element))
          .toList();
    } else {
      return Future.value(null);
    }
  }
}
