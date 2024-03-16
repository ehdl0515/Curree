import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../constant/currency.dart';
import '../constant/exchange_unit.dart';
import '../providers/filter_provider.dart';

Map<dynamic, dynamic> makeGridMap(BuildContext context) {

  Map<dynamic, dynamic> tableData = {};

  Map<Currency, bool> mainData = context.read<FilterProvider>().filterSelectedMainCurrency;
  Currency selectedMainCurrency = FilterProvider.getTrueMainCurrency(mainData);

  Map<Currency, bool> subData = context.read<FilterProvider>().filterSelectedSubCurrency;
  Currency selectedSubCurrency = FilterProvider.getTrueSubCurrency(subData);

  Map<int, bool> minData = context.read<FilterProvider>().filterSelectedExchangeMinimum;
  int selectedExchangeMinimum = FilterProvider.getTrueExchange(minData, minimumList);

  Map<int, bool> maxData = context.read<FilterProvider>().filterSelectedExchangeMaximum;
  int selectedExchangeMaximum = FilterProvider.getTrueExchange(maxData, maximumList);

  Map<int, bool> increaseData = context.read<FilterProvider>().filterSelectedExchangeIncreaseUnit;
  int selectedExchangeIncreaseUnit = FilterProvider.getTrueExchange(increaseData, increaseUnitList, defaultIndex: 3);


  print(selectedMainCurrency);
  print(selectedSubCurrency);
  print(selectedExchangeMinimum);
  print(selectedExchangeMaximum);
  print(selectedExchangeIncreaseUnit);

  print("환율 변환");

  int finalData = 0;
  double tempData = 2.5;


  for (int i = selectedExchangeMinimum; i <= selectedExchangeMaximum; i += selectedExchangeIncreaseUnit) {
    print(i);
    tempData = 2.5;

    double result = i * tempData;
    tableData[i] = result;
    finalData = i;
  }

  if (selectedExchangeMaximum - finalData != 0) {
    tableData[selectedExchangeMaximum] = selectedExchangeMaximum * tempData;
  }

  print(tableData);
  print("환율 변환 끝");


  print("적용 버튼: $tableData}");

  tableData['mainCurrency'] = selectedMainCurrency;
  tableData['subCurrency'] = selectedSubCurrency;

  return tableData;
}