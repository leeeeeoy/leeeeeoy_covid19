import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:leeeeeoy_covid19/src/canvas/arrow_clip_path.dart';
import 'package:leeeeeoy_covid19/src/model/covid_statistics.dart';
import 'package:leeeeeoy_covid19/src/repository/covid_statistics_repository.dart';

class CovidStatisticsController extends GetxController {
  late CovidStatisticsRepository _covidStatisticsRepository;
  Rx<Covid19Statistics> _todayData = Covid19Statistics().obs;
  RxList<Covid19Statistics> _weekDatas = <Covid19Statistics>[].obs;

  double maxDecideValue = 0;

  @override
  void onInit() {
    super.onInit();
    _covidStatisticsRepository = CovidStatisticsRepository();
    fetchCovidState();
  }

  void fetchCovidState() async {
    var startDate = DateFormat('yyyyMMdd')
        .format(DateTime.now().subtract(Duration(days: 8)));

    var endDate = DateFormat('yyyyMMdd').format(DateTime.now());

    var result = await _covidStatisticsRepository.fetchCovid19Statistics(
      startDate: startDate,
      endDate: endDate,
    );

    if (result.isNotEmpty) {
      for (var i = 0; i < result.length; i++) {
        if (i < result.length - 1) {
          result[i].updateCalcAboutYesterday(result[i + 1]);

          if (maxDecideValue < result[i].calcDecideCnt) {
            maxDecideValue = result[i].calcDecideCnt;
          }
        }
      }
      _weekDatas.addAll(result.sublist(0, result.length - 1).reversed);
      _todayData(_weekDatas.last);
    }
  }

  Covid19Statistics get todayData => _todayData.value;

  List<Covid19Statistics> get weekDays => _weekDatas;

  ArrowDirection calculrateUpDown(double value) {
    if (value == 0) {
      return ArrowDirection.MIDDLE;
    } else if (value > 0) {
      return ArrowDirection.UP;
    } else {
      return ArrowDirection.DOWN;
    }
  }
}
