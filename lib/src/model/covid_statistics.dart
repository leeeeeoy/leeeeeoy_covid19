import 'package:leeeeeoy_covid19/src/util/data_utils.dart';
import 'package:leeeeeoy_covid19/src/util/xml_utils.dart';
import 'package:xml/xml.dart';

class Covid19Statistics {
  double? accDefRate;
  double? accExamCnt;
  double? accExamCompCnt;
  double? careCnt;
  double? clearCnt;
  double? deathCnt;
  double? decideCnt;
  double? examCnt;
  double? resutlNegCnt;
  double? seq;

  String? createDt;
  String? stateTime;
  String? updateDt;
  DateTime? stateDt;

  double calcDecideCnt = 0;
  double calcExamCnt = 0;
  double calcDeathCnt = 0;
  double calcClearCnt = 0;

  Covid19Statistics({
    this.accDefRate,
    this.accExamCnt,
    this.accExamCompCnt,
    this.careCnt,
    this.clearCnt,
    this.createDt,
    this.deathCnt,
    this.decideCnt,
    this.examCnt,
    this.resutlNegCnt,
    this.seq,
    this.stateDt,
    this.stateTime,
    this.updateDt,
  });

  factory Covid19Statistics.empty() {
    return Covid19Statistics();
  }

  factory Covid19Statistics.fromXml(XmlElement xml) {
    return Covid19Statistics(
      accExamCnt: XmlUtils.searchResultForDouble(xml, 'accExamCnt'),
      accDefRate: XmlUtils.searchResultForDouble(xml, 'accDefRate'),
      accExamCompCnt: XmlUtils.searchResultForDouble(xml, 'accExamCompCnt'),
      careCnt: XmlUtils.searchResultForDouble(xml, 'careCnt'),
      clearCnt: XmlUtils.searchResultForDouble(xml, 'clearCnt'),
      deathCnt: XmlUtils.searchResultForDouble(xml, 'deathCnt'),
      decideCnt: XmlUtils.searchResultForDouble(xml, 'decideCnt'),
      examCnt: XmlUtils.searchResultForDouble(xml, 'examCnt'),
      resutlNegCnt: XmlUtils.searchResultForDouble(xml, 'resutlNegCnt'),
      seq: XmlUtils.searchResultForDouble(xml, 'seq'),
      createDt: XmlUtils.searchResultForString(xml, 'createDt'),
      stateDt: XmlUtils.searchResultForString(xml, 'stateDt') != ''
          ? DateTime.parse(XmlUtils.searchResultForString(xml, 'stateDt'))
          : null,
      stateTime: XmlUtils.searchResultForString(xml, 'stateTime'),
      updateDt: XmlUtils.searchResultForString(xml, 'updateDt'),
    );
  }

  void updateCalcAboutYesterday(Covid19Statistics yesterdayData) {
    _updateCalcDecideCnt(yesterdayData.decideCnt!);
    _updateCalcExamCnt(yesterdayData.examCnt!);
    _updateCalcDeathCnt(yesterdayData.deathCnt!);
    _updateCalcClearCnt(yesterdayData.clearCnt!);
  }

  void _updateCalcDecideCnt(double beforeCnt) {
    calcDecideCnt = decideCnt! - beforeCnt;
  }

  void _updateCalcExamCnt(double beforeCnt) {
    calcExamCnt = examCnt! - beforeCnt;
  }

  void _updateCalcDeathCnt(double beforeCnt) {
    calcDeathCnt = deathCnt! - beforeCnt;
  }

  void _updateCalcClearCnt(double beforeCnt) {
    calcClearCnt = clearCnt! - beforeCnt;
  }

  String get standardDayString => stateDt == null
      ? ''
      : '${DataUtils.simpleDayFormat(stateDt!)} $stateTime 기준';
}
