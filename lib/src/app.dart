import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leeeeeoy_covid19/src/canvas/arrow_clip_path.dart';
import 'package:leeeeeoy_covid19/src/components/covid_statistics_viewer.dart';
import 'package:leeeeeoy_covid19/src/controller/covid_statistics_controller.dart';

class App extends GetView<CovidStatisticsController> {
  App({Key? key}) : super(key: key);

  late double headerTopZone;

  Widget infoWidget(String title, String value) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            title + ": ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
            ),
          )
        ],
      ),
    );
  }

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
            child: Text(
              '날씨 기준 날씨 기준',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      Positioned(
        top: headerTopZone + 60,
        right: 30,
        child: CovidStatisticsViewer(
          title: '확진자',
          addedCount: 1629,
          totalCount: 187362,
          upDown: ArrowDirection.UP,
          titleColor: Colors.white,
          subValueColor: Colors.white,
        ),
      ),
    ];
  }

  Widget _todayStatistics() {
    return Row(
      children: [
        Expanded(
          child: CovidStatisticsViewer(
            title: '격리해제',
            addedCount: 1629,
            totalCount: 187362,
            upDown: ArrowDirection.UP,
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
            addedCount: 1629,
            totalCount: 187362,
            upDown: ArrowDirection.DOWN,
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
            addedCount: 1629,
            totalCount: 187362,
            upDown: ArrowDirection.MIDDLE,
            dense: true,
          ),
        ),
      ],
    );
  }

  Widget _covidTrendsChart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          '확진자 추이',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        AspectRatio(
          aspectRatio: 1.7,
          child: Card(
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 20,
                barTouchData: BarTouchData(
                  enabled: false,
                  touchTooltipData: BarTouchTooltipData(
                    tooltipBgColor: Colors.transparent,
                    tooltipPadding: const EdgeInsets.all(0),
                    tooltipMargin: 8,
                    getTooltipItem: (
                      BarChartGroupData group,
                      int groupIndex,
                      BarChartRodData rod,
                      int rodIndex,
                    ) {
                      return BarTooltipItem(
                        rod.y.round().toString(),
                        TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: SideTitles(
                    showTitles: true,
                    getTextStyles: (context, value) => const TextStyle(
                        color: Color(0xff7589a2),
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                    margin: 20,
                    getTitles: (double value) {
                      switch (value.toInt()) {
                        case 0:
                          return 'Mn';
                        case 1:
                          return 'Te';
                        case 2:
                          return 'Wd';
                        case 3:
                          return 'Tu';
                        case 4:
                          return 'Fr';
                        case 5:
                          return 'St';
                        case 6:
                          return 'Sn';
                        default:
                          return '';
                      }
                    },
                  ),
                  leftTitles: SideTitles(showTitles: false),
                ),
                borderData: FlBorderData(
                  show: false,
                ),
                barGroups: [
                  BarChartGroupData(
                    x: 0,
                    barRods: [
                      BarChartRodData(
                          y: 8,
                          colors: [Colors.lightBlueAccent, Colors.greenAccent])
                    ],
                    showingTooltipIndicators: [0],
                  ),
                  BarChartGroupData(
                    x: 1,
                    barRods: [
                      BarChartRodData(
                          y: 10,
                          colors: [Colors.lightBlueAccent, Colors.greenAccent])
                    ],
                    showingTooltipIndicators: [0],
                  ),
                  BarChartGroupData(
                    x: 2,
                    barRods: [
                      BarChartRodData(
                          y: 14,
                          colors: [Colors.lightBlueAccent, Colors.greenAccent])
                    ],
                    showingTooltipIndicators: [0],
                  ),
                  BarChartGroupData(
                    x: 3,
                    barRods: [
                      BarChartRodData(
                          y: 15,
                          colors: [Colors.lightBlueAccent, Colors.greenAccent])
                    ],
                    showingTooltipIndicators: [0],
                  ),
                  BarChartGroupData(
                    x: 3,
                    barRods: [
                      BarChartRodData(
                          y: 13,
                          colors: [Colors.lightBlueAccent, Colors.greenAccent])
                    ],
                    showingTooltipIndicators: [0],
                  ),
                  BarChartGroupData(
                    x: 3,
                    barRods: [
                      BarChartRodData(
                          y: 10,
                          colors: [Colors.lightBlueAccent, Colors.greenAccent])
                    ],
                    showingTooltipIndicators: [0],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
// Obx(() {
//           var info = controller.covidStatistic.value;
//           return Column(
//             children: [
//               infoWidget('기준일', info.stateDt ?? ''),
//               infoWidget('기준시간', info.stateTime ?? ''),
//               infoWidget('확진자 수', info.decideCnt ?? ''),
//               infoWidget('검사진행 수', info.examCnt ?? ''),
//               infoWidget('사망자 수', info.deathCnt ?? ''),
//               infoWidget('치료중 환자 수', info.careCnt ?? ''),
//               infoWidget('결과 음성 수', info.resutlNegCnt ?? ''),
//               infoWidget('누적 검사 수', info.accExamCnt ?? ''),
//               infoWidget('누적 검사 완료 수', info.accExamCompCnt ?? ''),
//               infoWidget('누적 확진률', info.accDefRate ?? ''),
//             ],
//           );
//         }),
