import 'package:flutter/material.dart';

import '../constant/currency.dart';


class RateProvider extends ChangeNotifier {

  Currency _dollar = Currency.dollar;
  Currency _euro = Currency.euro;
  Currency _yen = Currency.yen;
  Currency _yuan = Currency.yuan;

  String? _selectedNation;

  Currency get dollar => _dollar;

  void setDollar(Currency newCurrency) {
    _dollar = newCurrency;
    notifyListeners();
  }

  Currency get euro => _euro;

  void setEuro(Currency newCurrency) {
    _euro = newCurrency;
    notifyListeners();
  }

  Currency get yen => _yen;

  void setYen(Currency newCurrency) {
    _yen = newCurrency;
    notifyListeners();
  }

  Currency get yuan => _yuan;

  void setYuan(Currency newCurrency) {
    _yuan = newCurrency;
    notifyListeners();
  }

  String? get selectedNation => _selectedNation;

  void setSelectedNation(String? newNation) {
    _selectedNation = newNation;
    notifyListeners();
  }

}