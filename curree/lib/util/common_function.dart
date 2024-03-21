import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../constant/currency.dart';
import '../constant/exchange_unit.dart';
import '../providers/filter_provider.dart';
import '../providers/logger_provider.dart';

List<int> makeGridMap(BuildContext context) {

  final logger = Provider.of<LoggerProvider>(context, listen: false).logger;

  List<int> tableData = [];

  Map<Currency, bool> subData = context.read<FilterProvider>().filterSelectedSubCurrency;
  Currency selectedSubCurrency = FilterProvider.getTrueSubCurrency(subData);

  Map<int, bool> minData = context.read<FilterProvider>().filterSelectedExchangeMinimum;
  int selectedExchangeMinimum = FilterProvider.getTrueExchange(minData, minimumList);

  Map<int, bool> maxData = context.read<FilterProvider>().filterSelectedExchangeMaximum;
  int selectedExchangeMaximum = FilterProvider.getTrueExchange(maxData, maximumList);

  Map<int, bool> increaseData = context.read<FilterProvider>().filterSelectedExchangeIncreaseUnit;
  int selectedExchangeIncreaseUnit = FilterProvider.getTrueExchange(increaseData, increaseUnitList, defaultIndex: 3);


  logger.d(selectedSubCurrency);
  logger.d(selectedExchangeMinimum);
  logger.d(selectedExchangeMaximum);
  logger.d(selectedExchangeIncreaseUnit);

  logger.d("환율 변환");

  int finalData = 0;


  for (int i = selectedExchangeMinimum; i <= selectedExchangeMaximum; i += selectedExchangeIncreaseUnit) {
    logger.d(i);
    tableData.add(i);
    finalData = i;
  }

  if (selectedExchangeMaximum - finalData != 0) {
    tableData.add(selectedExchangeMaximum);
  }

  logger.d(tableData);
  logger.d("환율 변환 끝");

  logger.d("적용 버튼: $tableData}");

  return tableData;
}