import 'package:flutter/material.dart';

import '../constant/currency.dart';


class RateProvider extends ChangeNotifier {

  Currency _dollar = Currency.dollar;
  Currency _euro = Currency.euro;
  Currency _yen = Currency.yen;
  Currency _yuan = Currency.yuan;
  Currency _pound = Currency.pound;
  Currency _hkDollar = Currency.hkDollar;
  Currency _peso = Currency.peso;
  Currency _newTaiwanDollar = Currency.newTaiwanDollar;
  Currency _baht = Currency.baht;

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

  Currency get pound => _pound;

  void setPound(Currency newCurrency) {
    _pound = newCurrency;
    notifyListeners();
  }

  Currency get hkDollar => _hkDollar;

  void setHkDollar(Currency newCurrency) {
    _hkDollar = newCurrency;
    notifyListeners();
  }

  Currency get peso => _peso;

  void setPeso(Currency newCurrency) {
    _peso = newCurrency;
    notifyListeners();
  }

  Currency get newTaiwanDollar => _newTaiwanDollar;

  void setNewTaiwanDollar(Currency newCurrency) {
    _newTaiwanDollar = newCurrency;
    notifyListeners();
  }

  Currency get baht => _baht;

  void setBaht(Currency newCurrency) {
    _baht = newCurrency;
    notifyListeners();
  }

  String? get selectedNation => _selectedNation;

  void setSelectedNation(String? newNation) {
    _selectedNation = newNation;
    notifyListeners();
  }

}