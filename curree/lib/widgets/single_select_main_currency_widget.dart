import 'package:curree/providers/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constant/currency.dart';
import '../providers/filter_provider.dart';

class SingleSelectionMainCurrencyWidget extends StatefulWidget {

  const SingleSelectionMainCurrencyWidget({super.key});

  @override
  _SingleSelectionMainCurrencyWidgetState createState() =>
      _SingleSelectionMainCurrencyWidgetState();
}

class _SingleSelectionMainCurrencyWidgetState extends State<SingleSelectionMainCurrencyWidget> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

     Map<Currency, bool> selectedInfo = context.watch<FilterProvider>().filterSelectedMainCurrency;
     Currency mainCurrency = context.watch<GlobalStore>().mainCurrency;
     Map<Currency, bool> subCurrency = context.watch<FilterProvider>().filterSelectedSubCurrency;

     bool stopFlag = false;
     for (var entry in selectedInfo.entries) {
       if (entry.key != mainCurrency && entry.value) {
         stopFlag = true;
         break;
       }
     }
     if (!stopFlag) {
       selectedInfo[mainCurrency] = true;
     }

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: currencyList.length,
      itemBuilder: (BuildContext context, int index) {

        final selectedCurrency = currencyList[index];


        Currency? selectedSubCurrency;

        return GestureDetector(
          onTap: () {
            setState(() {

              for (var entry in subCurrency.entries) {
                if (entry.value) {
                  selectedSubCurrency = entry.key;
                }
              }

              if (selectedCurrency == selectedSubCurrency) {
                print("main == sub");
                return;
              }

              if (selectedInfo[selectedCurrency] == true) {
                print("same thing touch");
                return;
              }

              selectedInfo.forEach((key, value) {
                if (key == currencyList[index]) {
                  selectedInfo[key] = true;
                } else {
                  selectedInfo[key] = false;
                }
              });

              context.read<FilterProvider>().setFilterSelectedMainCurrency(selectedInfo);
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
              currencyList[index].code,
              style: TextStyle(
                color: selectedInfo[currencyList[index]] ?? false ? Colors.white : Colors.black,
                fontWeight: selectedInfo[currencyList[index]] ?? false ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        );
      },
    );
  }
}
