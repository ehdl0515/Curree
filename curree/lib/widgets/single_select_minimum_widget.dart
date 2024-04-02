import 'package:curree/constant/exchange_unit.dart';
import 'package:curree/providers/setting_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/filter_provider.dart';
import '../providers/logger_provider.dart';

class SingleSelectionMinimumWidget extends StatefulWidget {

  const SingleSelectionMinimumWidget({super.key});

  @override
  _SingleSelectionMinimumWidgetState createState() =>
      _SingleSelectionMinimumWidgetState();
}

class _SingleSelectionMinimumWidgetState extends State<SingleSelectionMinimumWidget> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final logger = Provider.of<LoggerProvider>(context).logger;

    Map<int, bool> selectedInfo = context.watch<FilterProvider>().filterSelectedExchangeMinimum;
    Map<int, bool> exchangeMaximum = context.watch<FilterProvider>().filterSelectedExchangeMaximum;
    Map<int, bool> exchangeIncreaseUnit = context.watch<FilterProvider>().filterSelectedExchangeIncreaseUnit;

    int exchangeMinimum = context.watch<SettingProvider>().exchangeMinimum;

    bool stopFlag = false;
    for (var entry in selectedInfo.entries) {
      if (entry.key != exchangeMinimum && entry.value) {
        stopFlag = true;
        break;
      }
    }
    if (!stopFlag) {
      selectedInfo[exchangeMinimum] = true;
    }

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: minimumList.length,
      itemBuilder: (BuildContext context, int index) {

        final selectedValue = minimumList[index];

        int selectedMaximumValue = maximumList.last;

        return GestureDetector(
          onTap: () {
            setState(() {
              FocusScope.of(context).unfocus();

              for (var entry in exchangeMaximum.entries) {
                if (entry.value) {
                  selectedMaximumValue = entry.key;
                }
              }

              if (selectedValue > selectedMaximumValue) {
                logger.d("SingleSElectionMinimumWidget] minimum($selectedValue) greater than maximum($selectedMaximumValue)");
                return;
              }

              if (selectedInfo[selectedValue] == true) {
                logger.d("SingleSElectionMinimumWidget] same thing touch ($selectedValue)");
                return;
              }

              selectedInfo.forEach((key, value) {
                if (key == minimumList[index]) {
                  selectedInfo[key] = true;
                } else {
                  selectedInfo[key] = false;
                }
              });

              context.read<FilterProvider>().setFilterSelectedExchangeMinimum(selectedInfo);
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
              minimumList[index].toString(),
              style: TextStyle(
                color: selectedInfo[minimumList[index]] ?? false ? Colors.white : Colors.black,
                fontWeight: selectedInfo[minimumList[index]] ?? false ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        );
      },
    );
  }
}
