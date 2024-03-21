import 'package:curree/constant/exchange_unit.dart';
import 'package:curree/providers/setting_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/filter_provider.dart';

class SingleSelectionIncreaseUnitWidget extends StatefulWidget {

  const SingleSelectionIncreaseUnitWidget({super.key});

  @override
  _SingleSelectionIncreaseUnitWidgetState createState() =>
      _SingleSelectionIncreaseUnitWidgetState();
}

class _SingleSelectionIncreaseUnitWidgetState extends State<SingleSelectionIncreaseUnitWidget> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Map<int, bool> selectedInfo = context.watch<FilterProvider>().filterSelectedExchangeIncreaseUnit;
    Map<int, bool> exchangeMinimum = context.watch<FilterProvider>().filterSelectedExchangeMinimum;
    Map<int, bool> exchangeMaximum = context.watch<FilterProvider>().filterSelectedExchangeMaximum;

    int exchangeIncreaseUnit = context.watch<SettingProvider>().exchangeIncreaseUnit;

    bool stopFlag = false;
    for (var entry in selectedInfo.entries) {
      if (entry.key != exchangeIncreaseUnit && entry.value) {
        stopFlag = true;
        break;
      }
    }
    if (!stopFlag) {
      selectedInfo[exchangeIncreaseUnit] = true;
    }

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: increaseUnitList.length,
      itemBuilder: (BuildContext context, int index) {

        final selectedValue = increaseUnitList[index];

        int selectedMaximumValue = maximumList.last;
        int selectedMinimumValue = minimumList.first;


        return GestureDetector(
          onTap: () {
            setState(() {
              FocusScope.of(context).unfocus();

              print("present ${increaseUnitList[index]}");




              for (var entry in exchangeMaximum.entries) {
                if (entry.value) {
                  selectedMaximumValue = entry.key;
                }
              }

              for (var entry in exchangeMinimum.entries) {
                if (entry.value) {
                  selectedMinimumValue = entry.key;
                }
              }

              if (selectedMinimumValue <=500 && selectedMaximumValue >= 10000 ) {
                context.read<FilterProvider>().setFilterSelectedExchangeIncreaseUnit(
                    {1000: true});
              }


              if (selectedValue >= selectedMaximumValue) {
                print("increaseUnit greater than maximum");
                return;
              }

              if (selectedMinimumValue <=500 && selectedMaximumValue >= 10000 && selectedValue <= 500) {
                print("invalid between this value!");
                return;
              }

              if (selectedInfo[selectedValue] == true) {
                print("same thing touch");
                return;
              }


              selectedInfo.forEach((key, value) {
                if (key == increaseUnitList[index]) {
                  selectedInfo[key] = true;
                } else {
                  selectedInfo[key] = false;
                }
              });

              context.read<FilterProvider>().setFilterSelectedExchangeIncreaseUnit(selectedInfo);
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
              increaseUnitList[index].toString(),
              style: TextStyle(
                color: selectedInfo[increaseUnitList[index]] ?? false ? Colors.white : Colors.black,
                fontWeight: selectedInfo[increaseUnitList[index]] ?? false ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        );
      },
    );
  }
}
