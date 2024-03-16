import 'package:curree/constant/exchange_unit.dart';
import 'package:curree/providers/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constant/currency.dart';
import '../providers/filter_provider.dart';

class SingleSelectionMaximumWidget extends StatefulWidget {

  const SingleSelectionMaximumWidget({super.key});

  @override
  _SingleSelectionMaximumWidgetState createState() =>
      _SingleSelectionMaximumWidgetState();
}

class _SingleSelectionMaximumWidgetState extends State<SingleSelectionMaximumWidget> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Map<int, bool> selectedInfo = context.watch<FilterProvider>().filterSelectedExchangeMaximum;
    Map<int, bool> exchangeMinimum = context.watch<FilterProvider>().filterSelectedExchangeMinimum;
    Map<int, bool> exchangeIncreaseUnit = context.watch<FilterProvider>().filterSelectedExchangeIncreaseUnit;

    int exchangeMaximum = context.watch<GlobalStore>().exchangeMaximum;

    bool stopFlag = false;
    for (var entry in selectedInfo.entries) {
      if (entry.key != exchangeMaximum && entry.value) {
        stopFlag = true;
        break;
      }
    }
    if (!stopFlag) {
      selectedInfo[exchangeMaximum] = true;
    }

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: maximumList.length,
      itemBuilder: (BuildContext context, int index) {

        final selectedValue = maximumList[index];

        int selectedMinimumValue = 0;


        return GestureDetector(
          onTap: () {
            setState(() {
              print("present ${maximumList[index]}");

              for (var entry in exchangeMinimum.entries) {
                if (entry.value) {
                  selectedMinimumValue = entry.key;
                }
              }

              if (selectedValue < selectedMinimumValue) {
                print("maximum smaller than minimum");
                return;
              }

              if (selectedInfo[selectedValue] == true) {
                print("same thing touch");
                return;
              }

              selectedInfo.forEach((key, value) {
                if (key == maximumList[index]) {
                  selectedInfo[key] = true;
                } else {
                  selectedInfo[key] = false;
                }
              });

              context.read<FilterProvider>().setFilterSelectedExchangeMaximum(selectedInfo);
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
              color: selectedInfo[selectedValue] ?? false ? Colors.pink[300]  : Colors.grey[200],
              borderRadius: BorderRadius.circular(7),
            ),
            child: Text(
              maximumList[index].toString(),
              style: TextStyle(
                color: selectedInfo[maximumList[index]] ?? false ? Colors.white : Colors.black,
                fontWeight: selectedInfo[maximumList[index]] ?? false ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        );
      },
    );
  }
}
