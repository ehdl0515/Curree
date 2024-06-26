List<int> minimumList = [
  0,
  10,
  50,
  100,
  500,
  1000,
  5000,
  10000,
];

List<int> maximumList = [
  100,
  500,
  1000,
  2000,
  5000,
  10000,
];

List<int> increaseUnitList = [
  5,
  10,
  50,
  100,
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

  static ExchangeUnit defaultExchangeUnit = ExchangeUnit(seqNo: 1, minimum: minimumList[0], maximum: maximumList[0], increaseUnit: increaseUnitList[0]);
}

