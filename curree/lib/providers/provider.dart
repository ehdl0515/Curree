import 'package:flutter/material.dart';

import '../constant/currency.dart';
import '../constant/exchange_unit.dart';

class GlobalStore extends ChangeNotifier {
  Currency _mainCurrency = Currency.won;
  Currency _subCurrency = Currency.yen;

  int _exchangeMinimum = ExchangeUnit.defaultExchangeUnit.minimum;
  int _exchangeMaximum = ExchangeUnit.defaultExchangeUnit.maximum;
  int _exchangeIncreaseUnit = ExchangeUnit.defaultExchangeUnit.increaseUnit;


  Currency get mainCurrency => _mainCurrency;

  void setMainCurrency(Currency newCurrency) {
    _mainCurrency = newCurrency;
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