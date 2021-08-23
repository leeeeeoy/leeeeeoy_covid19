import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:leeeeeoy_covid19/src/app.dart';
import 'package:leeeeeoy_covid19/src/controller/covid_statistics_controller.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      initialBinding: BindingsBuilder(() {
        Get.put(CovidStatisticsController());
      }),
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: App(),
      debugShowCheckedModeBanner: false,
    );
  }
}
