import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import '../constant/currency.dart';
import '../providers/filter_provider.dart';
import '../providers/logger_provider.dart';
import '../providers/setting_provider.dart';
import 'call_api.dart';

List<int> makeGridMap(BuildContext context) {

  final logger = Provider.of<LoggerProvider>(context, listen: false).logger;

  List<int> tableData = [];

  Map<Currency, bool> subData = Provider.of<FilterProvider>(context, listen: false).filterSelectedSubCurrency;
  Currency selectedSubCurrency = FilterProvider.getTrueSubCurrency(subData);

  Map<int, bool> minData = Provider.of<FilterProvider>(context, listen: false).filterSelectedExchangeMinimum;
  int selectedExchangeMinimum = FilterProvider.getTrueExchange(minData, context.read<SettingProvider>().exchangeMinimum);

  Map<int, bool> maxData = Provider.of<FilterProvider>(context, listen: false).filterSelectedExchangeMaximum;
  int selectedExchangeMaximum = FilterProvider.getTrueExchange(maxData, context.read<SettingProvider>().exchangeMaximum);

  Map<int, bool> increaseData = Provider.of<FilterProvider>(context, listen: false).filterSelectedExchangeIncreaseUnit;
  int selectedExchangeIncreaseUnit = FilterProvider.getTrueExchange(increaseData, context.read<SettingProvider>().exchangeIncreaseUnit);


  logger.d(selectedSubCurrency);
  logger.d(selectedExchangeMinimum);
  logger.d(selectedExchangeMaximum);
  logger.d(selectedExchangeIncreaseUnit);

  logger.d("환율 변환");

  int finalData = 0;


  for (int i = selectedExchangeMinimum; i <= selectedExchangeMaximum; i += selectedExchangeIncreaseUnit) {
    tableData.add(i);
    finalData = i;
  }

  if (selectedExchangeMaximum - finalData != 0) {
    tableData.add(selectedExchangeMaximum);
  }

  if (tableData.first == 0) {
    tableData.removeAt(0);
  }

  logger.d(tableData);

  logger.d("환율 변환 끝");

  return tableData;
}


Future<void> updateProfile(BuildContext context) async {
  final logger = Provider.of<LoggerProvider>(context, listen: false).logger;

  int profileNo = context.read<SettingProvider>().profileNo;
  final deviceInfo = context.read<SettingProvider>().deviceInfo;
  Currency selectedSubCurrency = context.read<SettingProvider>().subCurrency;
  int selectedExchangeMinimum = context.read<SettingProvider>().exchangeMinimum;
  int selectedExchangeMaximum = context.read<SettingProvider>().exchangeMaximum;
  int selectedExchangeIncreaseUnit = context.read<SettingProvider>().exchangeIncreaseUnit;

  Map<String, dynamic> body = {
    "deviceId": deviceInfo["identifierForVendor"],
    "subCurrency": selectedSubCurrency.code,
    "exchangeMinimum": selectedExchangeMinimum,
    "exchangeMaximum": selectedExchangeMaximum,
    "exchangeIncreaseUnit": selectedExchangeIncreaseUnit,
    // "convertDate": formatDate(DateTime.timestamp()),
  };

  final backendServer = dotenv.get("BACKEND_SERVER");
  late Future<String> result;

  if (profileNo == 0) {
    Uri url = Uri.http(backendServer, "/profile");
    logger.d("updateProfile] profileNo: $profileNo");
    logger.d("updateProfile] url: $url");
    logger.d("updateProfile] body: $body");
    result = callMethodAPI(url, body, "POST");
  } else {
    Uri url = Uri.http(backendServer, "/profile/$profileNo");
    logger.d("updateProfile] profileNo: $profileNo");
    logger.d("updateProfile] url: $url");
    logger.d("updateProfile] body: $body");
    result = callMethodAPI(url, body, "PUT");
  }


  await result.then((newValueJson) {
    dynamic newValue = jsonDecode(newValueJson);
    logger.d("updateProfile] newValue: $newValue");

    context.read<SettingProvider>().setProfileNo(newValue["profileNo"]);
  });
}