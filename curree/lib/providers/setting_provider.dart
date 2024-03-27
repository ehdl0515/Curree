import 'package:flutter/material.dart';

import '../constant/currency.dart';
import '../constant/exchange_unit.dart';

class SettingProvider extends ChangeNotifier {

  Map<String, dynamic> _deviceInfo = {};

  Currency _subCurrency = Currency.dollar;

  int _exchangeMinimum = ExchangeUnit.defaultExchangeUnit.minimum;
  int _exchangeMaximum = ExchangeUnit.defaultExchangeUnit.maximum;
  int _exchangeIncreaseUnit = ExchangeUnit.defaultExchangeUnit.increaseUnit;

  int _profileNo = 0;

  Map<String, dynamic> get deviceInfo => _deviceInfo;
  void setDeviceInfo(Map<String, dynamic> newValue) {
    _deviceInfo = newValue;
    notifyListeners();
  }


  int get profileNo => _profileNo;
  void setProfileNo(int newValue) {
    _profileNo = newValue;
    notifyListeners();
  }

  Currency get subCurrency => _subCurrency;

  void setSubCurrency(Currency newCurrency) {
    _subCurrency = newCurrency;
    notifyListeners();
  }

  int get exchangeMinimum => _exchangeMinimum;

  void setExchangeMinimum(int newValue) {
    _exchangeMinimum = newValue;
    notifyListeners();
  }

  int get exchangeMaximum => _exchangeMaximum;

  void setExchangeMaximum(int newValue) {
    _exchangeMaximum = newValue;
    notifyListeners();
  }

  int get exchangeIncreaseUnit => _exchangeIncreaseUnit;

  void setExchangeIncreaseUnit(int newValue) {
    _exchangeIncreaseUnit = newValue;
    notifyListeners();
  }

}