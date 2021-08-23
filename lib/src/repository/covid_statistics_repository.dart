import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:leeeeeoy_covid19/src/model/covid_statistics.dart';
import 'package:xml/xml.dart';

class CovidStatisticsRepository {
  late var _dio;

  final data = '''
<response>
<header>
<resultCode>00</resultCode>
<resultMsg>NORMAL SERVICE.</resultMsg>
</header>
<body>
<items>
<item>
<accDefRate>1.8373517666</accDefRate>
<accExamCnt>12112086</accExamCnt>
<accExamCompCnt>11646164</accExamCompCnt>
<careCnt>24323</careCnt>
<clearCnt>187524</clearCnt>
<createDt>2021-08-10 09:37:53.03</createDt>
<deathCnt>2134</deathCnt>
<decideCnt>213981</decideCnt>
<examCnt>465922</examCnt>
<resutlNegCnt>11432183</resutlNegCnt>
<seq>599</seq>
<stateDt>20210810</stateDt>
<stateTime>00:00</stateTime>
<updateDt>2021-08-18 10:18:46.042</updateDt>
</item>
<item>
<accDefRate>1.8329430364</accDefRate>
<accExamCnt>12057830</accExamCnt>
<accExamCompCnt>11590322</accExamCompCnt>
<careCnt>24076</careCnt>
<clearCnt>186243</clearCnt>
<createDt>2021-08-09 09:37:14.335</createDt>
<deathCnt>2125</deathCnt>
<decideCnt>212444</decideCnt>
<examCnt>467508</examCnt>
<resutlNegCnt>11377878</resutlNegCnt>
<seq>598</seq>
<stateDt>20210809</stateDt>
<stateTime>00:00</stateTime>
<updateDt>2021-08-18 10:18:31.982</updateDt>
</item>
<item>
<accDefRate>1.8246692115</accDefRate>
<accExamCnt>12027443</accExamCnt>
<accExamCompCnt>11561164</accExamCompCnt>
<careCnt>23829</careCnt>
<clearCnt>185003</clearCnt>
<createDt>2021-08-08 09:43:32.979</createDt>
<deathCnt>2121</deathCnt>
<decideCnt>210953</decideCnt>
<examCnt>466279</examCnt>
<resutlNegCnt>11350211</resutlNegCnt>
<seq>597</seq>
<stateDt>20210808</stateDt>
<stateTime>00:00</stateTime>
<updateDt>2021-08-18 10:18:16.473</updateDt>
</item>
<item>
<accDefRate>1.8113166057</accDefRate>
<accExamCnt>11995927</accExamCnt>
<accExamCompCnt>11550990</accExamCompCnt>
<careCnt>23321</careCnt>
<clearCnt>183788</clearCnt>
<createDt>2021-08-07 09:40:18.999</createDt>
<deathCnt>2116</deathCnt>
<decideCnt>209225</decideCnt>
<examCnt>444937</examCnt>
<resutlNegCnt>11341765</resutlNegCnt>
<seq>596</seq>
<stateDt>20210807</stateDt>
<stateTime>00:00</stateTime>
<updateDt>2021-08-18 10:18:03.621</updateDt>
</item>
<item>
<accDefRate>1.7996458185</accDefRate>
<accExamCnt>11951651</accExamCnt>
<accExamCompCnt>11524601</accExamCompCnt>
<careCnt>23235</careCnt>
<clearCnt>182054</clearCnt>
<createDt>2021-08-06 09:43:45.386</createDt>
<deathCnt>2113</deathCnt>
<decideCnt>207402</decideCnt>
<examCnt>427050</examCnt>
<resutlNegCnt>11317199</resutlNegCnt>
<seq>595</seq>
<stateDt>20210806</stateDt>
<stateTime>00:00</stateTime>
<updateDt>2021-08-18 10:17:34.677</updateDt>
</item>
<item>
<accDefRate>1.7897760939</accDefRate>
<accExamCnt>11908435</accExamCnt>
<accExamCompCnt>11492946</accExamCompCnt>
<careCnt>22868</careCnt>
<clearCnt>180721</clearCnt>
<createDt>2021-08-05 09:50:52.915</createDt>
<deathCnt>2109</deathCnt>
<decideCnt>205698</decideCnt>
<examCnt>415489</examCnt>
<resutlNegCnt>11287248</resutlNegCnt>
<seq>594</seq>
<stateDt>20210805</stateDt>
<stateTime>00:00</stateTime>
<updateDt>2021-08-18 10:17:14.68</updateDt>
</item>
<item>
<accDefRate>1.7784465944</accDefRate>
<accExamCnt>11864244</accExamCnt>
<accExamCompCnt>11466355</accExamCompCnt>
<careCnt>22691</careCnt>
<clearCnt>179126</clearCnt>
<createDt>2021-08-04 09:49:14.864</createDt>
<deathCnt>2106</deathCnt>
<decideCnt>203923</decideCnt>
<examCnt>397889</examCnt>
<resutlNegCnt>11262432</resutlNegCnt>
<seq>593</seq>
<stateDt>20210804</stateDt>
<stateTime>00:00</stateTime>
<updateDt>2021-08-18 10:17:00.601</updateDt>
</item>
<item>
<accDefRate>1.7702945660</accDefRate>
<accExamCnt>11820015</accExamCnt>
<accExamCompCnt>11421715</accExamCompCnt>
<careCnt>22184</careCnt>
<clearCnt>177910</clearCnt>
<createDt>2021-08-03 09:38:51.531</createDt>
<deathCnt>2104</deathCnt>
<decideCnt>202198</decideCnt>
<examCnt>398300</examCnt>
<resutlNegCnt>11219517</resutlNegCnt>
<seq>592</seq>
<stateDt>20210803</stateDt>
<stateTime>00:00</stateTime>
<updateDt>2021-08-18 10:16:41.957</updateDt>
</item>
<item>
<accDefRate>1.7653961865</accDefRate>
<accExamCnt>11772603</accExamCnt>
<accExamCompCnt>11385433</accExamCompCnt>
<careCnt>22299</careCnt>
<clearCnt>176600</clearCnt>
<createDt>2021-08-02 09:37:51.966</createDt>
<deathCnt>2099</deathCnt>
<decideCnt>200998</decideCnt>
<examCnt>387170</examCnt>
<resutlNegCnt>11184435</resutlNegCnt>
<seq>591</seq>
<stateDt>20210802</stateDt>
<stateTime>00:00</stateTime>
<updateDt>2021-08-18 10:16:13.749</updateDt>
</item>
<item>
<accDefRate>1.7565885920</accDefRate>
<accExamCnt>11751781</accExamCnt>
<accExamCompCnt>11373181</accExamCompCnt>
<careCnt>22009</careCnt>
<clearCnt>175673</clearCnt>
<createDt>2021-08-01 09:38:06.089</createDt>
<deathCnt>2098</deathCnt>
<decideCnt>199780</decideCnt>
<examCnt>378600</examCnt>
<resutlNegCnt>11173401</resutlNegCnt>
<seq>590</seq>
<stateDt>20210801</stateDt>
<stateTime>00:00</stateTime>
<updateDt>2021-08-18 10:15:56.122</updateDt>
</item>
</items>
<numOfRows>10</numOfRows>
<pageNo>1</pageNo>
<totalCount>10</totalCount>
</body>
</response>''';

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

  Future<Covid19Statistics> fetchCovid19Statistics() async {
    // var response =
    //     await _dio.get('/openapi/service/rest/Covid19/getCovid19InfStateJson');

    final document = XmlDocument.parse(data);
    final results = document.findAllElements('item');

    if (results.isNotEmpty) {
      return Covid19Statistics.fromXml(results.first);
    } else {
      return Future.value(null);
    }
  }
}
