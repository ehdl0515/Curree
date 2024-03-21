class Currency {
  final String nation;
  final String code;
  final String name;
  final String symbol;
  final String currentRate;
  final int currentDate;
  final String previousRate;
  final int previousDate;
  final String flagImage;

  Currency({
    required this.nation,
    required this.code,
    required this.name,
    required this.symbol,
    required this.currentRate,
    required this.currentDate,
    required this.previousRate,
    required this.previousDate,
    required this.flagImage,
  });

  @override
  String toString() {
    return '[$code, $name, $symbol, ($currentRate, $currentDate), ($previousRate, $previousDate), $flagImage]';
  }

  static Currency dollar = Currency(
      nation: "미국",
      code: "USD",
      name: "달러",
      symbol: "\$",
      currentRate: (0.0).toStringAsFixed(1),
      currentDate: 20240321141000,
      previousRate: (0.0).toStringAsFixed(1),
      previousDate: 20240321140000,
      flagImage: "assets/images/USAFlag.png",
  );

  static Currency euro = Currency(
      nation: "유럽",
      code: "EUR",
      name: "유로",
      symbol: "€",
      currentRate: (0.0).toStringAsFixed(1),
      currentDate: 20240321141000,
      previousRate: (0.0).toStringAsFixed(1),
      previousDate: 20240321140000,
      flagImage: "assets/images/EuropeFlag.png",
  );

  static Currency yen = Currency(
      nation: "일본",
      code: "JPY",
      name: "엔",
      symbol: "￥",
      currentRate: (0.0).toStringAsFixed(1),
      currentDate: 20240321141000,
      previousRate: (0.0).toStringAsFixed(1),
      previousDate: 20240321140000,
      flagImage: "assets/images/JapanFlag.png",
  );

  static Currency yuan = Currency(
      nation: "중국",
      code: "CNY",
      name: "위안",
      symbol: "元",
      currentRate: (0.0).toStringAsFixed(1),
      currentDate: 20240321141000,
      previousRate: (0.0).toStringAsFixed(1),
      previousDate: 20240321140000,
      flagImage: "assets/images/ChinaFlag.png",
  );


}


List<Currency> currencies = [
  Currency.dollar,
  Currency.euro,
  Currency.yen,
  Currency.yuan,
];