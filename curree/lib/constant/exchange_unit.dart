List<int> minimumList = [
  100,
  500,
  1000,
  5000,
  10000,
];

List<int> maximumList = [
  1000,
  2000,
  5000,
  10000,
  20000,
  50000,
  100000,
  200000,
  500000,
];

List<int> increaseUnitList = [
  10,
  20,
  50,
  100,
  200,
  500,
  1000,
  2000,
  5000,
  10000,
];


class ExchangeUnit {
  final int seqNo;
  final int minimum;
  final int maximum;
  final int increaseUnit;

  const ExchangeUnit({
    required this.seqNo,
    required this.minimum,
    required this.maximum,
    required this.increaseUnit,
  });

  static ExchangeUnit defaultExchangeUnit = ExchangeUnit(seqNo: 1, minimum: minimumList[0], maximum: maximumList[0], increaseUnit: increaseUnitList[3]);
}

