class Currency {
  final String code;
  final String name;
  final String symbol;

  const Currency({
    required this.code,
    required this.name,
    required this.symbol,
  });

  @override
  String toString() {
    return '[${code}, ${name}, ${symbol}]';
  }

  static const Currency won = Currency(code: "KRW", name: "won", symbol: "₩");
  static const Currency yen = Currency(code: "JPY", name: "yen", symbol: "￥");
  static const Currency dollar = Currency(code: "USD", name: "dollar", symbol: "\$");
}

List<Currency> currencyList = [
  Currency.won,
  Currency.yen,
  Currency.dollar,
];

List<String> currencyCodeList = [
  Currency.won.code,
  Currency.yen.code,
  Currency.dollar.code,
];