import 'package:curree/providers/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constant/currency.dart';

class CurrentRateWidget extends StatefulWidget {
  const CurrentRateWidget({super.key});

  @override
  _CurrentRateWidgetState createState() =>
      _CurrentRateWidgetState();
}

class _CurrentRateWidgetState extends State<CurrentRateWidget> {

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    List<Currency> tempCurrencyList = [...currencyList];

    tempCurrencyList.remove(context.watch<GlobalStore>().mainCurrency);

    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(width * 0.036, height * 0.024, 0, 0),
              child: const Text(
                '현재 환율 정보',
                style: TextStyle(
                  fontFamily: 'SUITE',
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),

            Container(
              padding: EdgeInsets.fromLTRB(width * 0.16, height * 0.024, 0, 0),
              child: const Text(
                '2024-03-02 16:20',
                style: TextStyle(
                  fontFamily: 'SUITE',
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.fromLTRB(width * 0.036, height * 0.010, 0, 0),
          alignment: Alignment.centerLeft,
          child: const Text(
            '출처: OpenExchangeReference (10분마다 갱신)',
            style: TextStyle(
              fontFamily: 'SUITE',
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ),
        SizedBox(
          height: height * 0.4,
          width: width,
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: tempCurrencyList.length,
            itemBuilder: (BuildContext context, int index) {
              final symbol = tempCurrencyList[index].symbol;
              final code = tempCurrencyList[index].code;
              final name = tempCurrencyList[index].name;
              return ListTile(
                title: Text('$code - $name', style: const TextStyle(fontFamily: 'SUITE'),),
                subtitle: Text('$symbol'),
                trailing: const Icon(CupertinoIcons.arrowtriangle_up_fill, color: Colors.red,),
              );
            },
          ),
        ),
      ],
    );
  }
}
