import 'package:curree/providers/provider.dart';
import 'package:flutter/material.dart';

import '../constant/currency.dart';
import '../constant/exchange_unit.dart';


class FilterProvider extends ChangeNotifier {
  final GlobalStore globalStore;

  FilterProvider(this.globalStore);

  static Map<Currency, bool> setMyMap() {
    Map<Currency, bool> myMap = {};
    for (Currency item in currencyList) {
      myMap[item] = false;
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

  // 필터 선택 시 변수
  Map<Currency, bool> _filterSelectedMainCurrency = setMyMap();
  Map<Currency, bool> get filterSelectedMainCurrency => _filterSelectedMainCurrency;
  void setFilterSelectedMainCurrency(Map<Currency, bool> newValue) {
    _filterSelectedMainCurrency = newValue;
    notifyListeners();
  }

  static Currency getTrueMainCurrency(Map<Currency, bool> datas) {
    Currency rtnData = currencyList[0];
    datas.forEach((key, value) {
      if (value) {
        rtnData = key;
      }
    });
    return rtnData;
  }

  static Currency getTrueSubCurrency(Map<Currency, bool> datas) {
    Currency rtnData = currencyList[1];
    datas.forEach((key, value) {
      if (value) {
        rtnData = key;
      }
    });
    return rtnData;
  }

  static int getTrueExchange(Map<int, bool> datas, List<int> parentData, {int defaultIndex=0}) {
    int rtnData = parentData[defaultIndex];
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

}
