import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leeeeeoy_covid19/src/components/bar_chart.dart';
import 'package:leeeeeoy_covid19/src/components/covid_statistics_viewer.dart';
import 'package:leeeeeoy_covid19/src/controller/covid_statistics_controller.dart';

class App extends GetView<CovidStatisticsController> {
  App({Key? key}) : super(key: key);

  late double headerTopZone;

  @override
  Widget build(BuildContext context) {
    headerTopZone = Get.mediaQuery.padding.top + AppBar().preferredSize.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '코로나 일별 현황',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        leading: Icon(
          Icons.menu,
          color: Colors.white,
        ),
        actions: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: Icon(
              Icons.notifications,
              color: Colors.white,
            ),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        color: Color(0xff3c727c),
        child: Stack(
          children: [
            ...background(),
            Positioned(
              top: headerTopZone + 200,
              right: 0,
              left: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  color: Colors.white,
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        _todayStatistics(),
                        SizedBox(height: 50),
                        _covidTrendsChart(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> background() {
    return [
      Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: [
              Color(0xff3c727c),
              Color(0xff285861),
            ],
          ),
        ),
      ),
      Positioned(
        left: -110,
        top: headerTopZone + 30,
        child: Container(
          child: Image.asset(
            'assets/images/covid_img.png',
            width: Get.size.width * 0.7,
          ),
        ),
      ),
      Positioned(
        top: headerTopZone + 10,
        left: 0,
        right: 0,
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 2,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color(0xff195f68),
            ),
            child: Obx(() => Text(
                  controller.todayData.standardDayString,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                )),
          ),
        ),
      ),
      Positioned(
        top: headerTopZone + 60,
        right: 30,
        child: Obx(() => CovidStatisticsViewer(
              title: '확진자',
              addedCount: controller.todayData.calcDecideCnt,
              totalCount: controller.todayData.decideCnt ?? 0,
              titleColor: Colors.white,
              subValueColor: Colors.white,
              upDown: controller
                  .calculrateUpDown(controller.todayData.calcDecideCnt),
            )),
      ),
    ];
  }

  Widget _todayStatistics() {
    return Obx(() => Row(
          children: [
            Expanded(
              child: CovidStatisticsViewer(
                title: '격리해제',
                addedCount: controller.todayData.calcClearCnt,
                totalCount: controller.todayData.clearCnt ?? 0,
                upDown: controller
                    .calculrateUpDown(controller.todayData.calcClearCnt),
                dense: true,
              ),
            ),
            Container(
              height: 60,
              child: VerticalDivider(
                color: Color(0xffc7c7c7),
              ),
            ),
            Expanded(
              child: CovidStatisticsViewer(
                title: '검사 중',
                addedCount: controller.todayData.calcExamCnt,
                totalCount: controller.todayData.examCnt ?? 0,
                upDown: controller
                    .calculrateUpDown(controller.todayData.calcExamCnt),
                dense: true,
              ),
            ),
            Container(
              height: 60,
              child: VerticalDivider(
                color: Color(0xffc7c7c7),
              ),
            ),
            Expanded(
              child: CovidStatisticsViewer(
                title: '사망자',
                addedCount: controller.todayData.calcDeathCnt,
                totalCount: controller.todayData.deathCnt ?? 0,
                upDown: controller
                    .calculrateUpDown(controller.todayData.calcDeathCnt),
                dense: true,
              ),
            ),
          ],
        ));
  }

  Widget _covidTrendsChart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          '확진자 추이',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        AspectRatio(
          aspectRatio: 1.7,
          child: Obx(() => controller.weekDays.length == 0
              ? CircularProgressIndicator()
              : CovidBarChart(
                  covidDatas: controller.weekDays,
                  maxY: controller.maxDecideValue,
                )),
        ),
      ],
    );
  }
}
