import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import '../constant/currency.dart';
import '../providers/logger_provider.dart';
import 'call_api.dart';


Future<List> fetchData(BuildContext context, List<Currency> newCurrencies) async {
  Map<String, dynamic> params = {};
  final backendServer = dotenv.get("BACKEND_SERVER");
  String standardDate = "";
  final logger = Provider.of<LoggerProvider>(context).logger;

  for (var value in newCurrencies) {
    String stringDate = newCurrencies[0].currentDate != null ? newCurrencies[0].currentDate.toString() : "";
    standardDate = "";
    if (stringDate != "") {
      standardDate = stringDate.substring(0, stringDate.length - 7);
    }
    // logger.d("CurrentRateWidget] standardDate: $standardDate");

    params = {
      "baseCurrency": "KRW",
      "convertCurrency": value.code,
      // "convertDate": formatDate(DateTime.timestamp()),
    };
    Uri url = Uri.http(backendServer, "/currencyRateLatest", params);

    Future<String> result = callGetAPI(url);

    await result.then((newValueJson) {
      List<dynamic> newValue = jsonDecode(newValueJson);
      logger.d("CurrentRateWidget] newValue: $newValue");

      value.currentRate = newValue[0]["rate"].toString();
      value.previousRate = newValue[1]["rate"].toString();

      value.currentDate = DateTime.parse("${newValue[0]['convertDate']} ${newValue[0]['convertTime']}");
      value.previousDate = DateTime.parse("${newValue[1]['convertDate']} ${newValue[1]['convertTime']}");
    });
  }

  return [standardDate, newCurrencies];
}