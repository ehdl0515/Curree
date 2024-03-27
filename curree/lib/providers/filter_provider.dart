import 'package:flutter/material.dart';

import '../constant/currency.dart';
import '../constant/exchange_unit.dart';


class FilterProvider extends ChangeNotifier {

  static Map<Currency, bool> setMyMap() {
    Map<Currency, bool> myMap = {};
    for (Currency item in currencies) {
      myMap[item] = false;
    }
    return myMap;
  }

  static Map<Currency, bool> setSettingMap(Currency setValue) {
    Map<Currency, bool> myMap = {};
    for (Currency item in currencies) {
      myMap[item] = false;
      myMap[setValue] = true;
    }
    return myMap;
  }


  static Map<int, bool> setMyInt(List data) {
    Map<int, bool> myMap = {};
    for (int item in data) {
      myMap[item] = false;
    }
    return myMap;
  }

  static Map<int, bool> setSettingInt(List data, int setValue) {
    Map<int, bool> myMap = {};
    for (int item in data) {
      myMap[item] = false;
      myMap[setValue] = true;
    }
    return myMap;
  }


  // 필터 선택 시 변수
  static Currency getTrueSubCurrency(Map<Currency, bool> datas) {
    Currency rtnData = currencies[0];
    datas.forEach((key, value) {
      if (value) {
        rtnData = key;
      }
    });
    return rtnData;
  }

  static int getTrueExchange(Map<int, bool> datas, int setValue) {
    int rtnData = setValue;
    datas.forEach((key, value) {
      if (value) {
        rtnData = key;
      }
    });
    return rtnData;
  }


  Map<Currency, bool> _filterSelectedSubCurrency = setMyMap();
  Map<Currency, bool> get filterSelectedSubCurrency => _filterSelectedSubCurrency;
  void setFilterSelectedSubCurrency(Map<Currency, bool> newCurrency) {
    _filterSelectedSubCurrency = newCurrency;
    notifyListeners();
  }

  Map<int, bool> _filterSelectedExchangeMinimum = setMyInt(minimumList);
  Map<int, bool> get filterSelectedExchangeMinimum => _filterSelectedExchangeMinimum;
  void setFilterSelectedExchangeMinimum(Map<int, bool> newValue) {
    _filterSelectedExchangeMinimum = newValue;
    notifyListeners();
  }

  Map<int, bool> _filterSelectedExchangeMaximum = setMyInt(maximumList);
  Map<int, bool> get filterSelectedExchangeMaximum => _filterSelectedExchangeMaximum;
  void setFilterSelectedExchangeMaximum(Map<int, bool> newValue) {
    _filterSelectedExchangeMaximum = newValue;
    notifyListeners();
  }

  Map<int, bool> _filterSelectedExchangeIncreaseUnit = setMyInt(increaseUnitList);
  Map<int, bool> get filterSelectedExchangeIncreaseUnit => _filterSelectedExchangeIncreaseUnit;
  void setFilterSelectedExchangeIncreaseUnit(Map<int, bool> newValue) {
    _filterSelectedExchangeIncreaseUnit = newValue;
    notifyListeners();
  }

  int _selectedConvert = 100;
  int get selectedConvert => _selectedConvert;
  void setSelectedConvert(int newValue) {
    _selectedConvert = newValue;
    notifyListeners();
  }

  List<int> _selectedConverts = [];
  List<int> get selectedConverts => _selectedConverts;
  void setSelectedConverts(List<int> newValues) {
    _selectedConverts = newValues;
    notifyListeners();
  }

}
