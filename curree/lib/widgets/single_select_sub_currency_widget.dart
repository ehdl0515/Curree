import 'package:curree/providers/setting_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constant/currency.dart';
import '../providers/filter_provider.dart';

class SingleSelectionSubCurrencyWidget extends StatefulWidget {

  const SingleSelectionSubCurrencyWidget({super.key});

  @override
  _SingleSelectionSubCurrencyWidgetState createState() =>
      _SingleSelectionSubCurrencyWidgetState();
}

class _SingleSelectionSubCurrencyWidgetState extends State<SingleSelectionSubCurrencyWidget> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Map<Currency, bool> selectedInfo = context.watch<FilterProvider>().filterSelectedSubCurrency;

    Currency subCurrency = context.watch<SettingProvider>().subCurrency;

    bool stopFlag = false;
    for (var entry in selectedInfo.entries) {
      if (entry.key != subCurrency && entry.value) {
        stopFlag = true;
        break;
      }
    }
    if (!stopFlag) {
      selectedInfo[subCurrency] = true;
    }

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: currencies.length,
      itemBuilder: (BuildContext context, int index) {

        final selectedCurrency = currencies[index];

        return GestureDetector(
          onTap: () {
            setState(() {
              FocusScope.of(context).unfocus();
              print("present ${currencies[index]}");

              if (selectedInfo[selectedCurrency] == true) {
                print("same thing touch");
                return;
              }

              selectedInfo.forEach((key, value) {
                if (key == currencies[index]) {
                  selectedInfo[key] = true;
                } else {
                  selectedInfo[key] = false;
                }
              });

              context.read<FilterProvider>().setFilterSelectedSubCurrency(selectedInfo);
              // print(index);
              // print('${selectedInfo}');
              // print('${selectedInfo[currencyList[index]]}');
              // print('\n');

            });
          },

          child: Container(
            width: 70,
            alignment: Alignment.center,
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: selectedInfo[selectedCurrency] ?? false ? Colors.pink[300]  : Colors.grey[200],
              borderRadius: BorderRadius.circular(7),
            ),
            child: Text(
              currencies[index].code,
              style: TextStyle(
                color: selectedInfo[currencies[index]] ?? false ? Colors.white : Colors.black,
                fontWeight: selectedInfo[currencies[index]] ?? false ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        );
      },
    );
  }
}
