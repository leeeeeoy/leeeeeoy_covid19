import 'package:get/get.dart';
import 'package:leeeeeoy_covid19/src/model/covid_statistics.dart';
import 'package:leeeeeoy_covid19/src/repository/covid_statistics_repository.dart';

class CovidStatisticsController extends GetxController {
  late CovidStatisticsRepository _covidStatisticsRepository;
  Rx<Covid19Statistics> covidStatistic = Covid19Statistics().obs;

  @override
  void onInit() {
    super.onInit();
    _covidStatisticsRepository = CovidStatisticsRepository();
    fetchCovidState();
  }

  void fetchCovidState() async {
    var result = await _covidStatisticsRepository.fetchCovid19Statistics();
    if (result != null) {
      covidStatistic(result);
    }
  }
}
