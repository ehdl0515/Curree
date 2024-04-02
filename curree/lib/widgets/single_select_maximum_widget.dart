import 'package:curree/constant/exchange_unit.dart';
import 'package:curree/providers/setting_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/filter_provider.dart';
import '../providers/logger_provider.dart';

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
    final logger = Provider.of<LoggerProvider>(context).logger;

    Map<int, bool> selectedInfo = context.watch<FilterProvider>().filterSelectedExchangeMaximum;
    Map<int, bool> exchangeMinimum = context.watch<FilterProvider>().filterSelectedExchangeMinimum;
    Map<int, bool> exchangeIncreaseUnit = context.watch<FilterProvider>().filterSelectedExchangeIncreaseUnit;

    int exchangeMaximum = context.watch<SettingProvider>().exchangeMaximum;

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

        int selectedMinimumValue = minimumList.first;

        return GestureDetector(
          onTap: () {
            setState(() {
              FocusScope.of(context).unfocus();

              for (var entry in exchangeMinimum.entries) {
                if (entry.value) {
                  selectedMinimumValue = entry.key;
                }
              }

              if (selectedValue < selectedMinimumValue) {
                logger.d("SingleSelectionMaximumWidget] maximum($selectedValue) smaller than minimum($selectedMinimumValue)");
                return;
              }

              if (selectedInfo[selectedValue] == true) {
                logger.d("SingleSelectionMaximumWidget] same thing touch ($selectedValue)");
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
            });
          },

          child: Container(
            width: 70,
            alignment: Alignment.center,
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: selectedInfo[selectedValue] ?? false ? const Color(0xff0d797e)  : Colors.grey[200],
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
