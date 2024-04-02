import 'package:curree/constant/exchange_unit.dart';
import 'package:curree/providers/setting_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';

import '../providers/filter_provider.dart';
import '../providers/logger_provider.dart';
import '../util/common_function.dart';


class SettingMainCurrencyScreen extends StatefulWidget {
  const SettingMainCurrencyScreen({super.key});

  @override
  _SettingMainCurrencyScreenState createState() => _SettingMainCurrencyScreenState();
}

class _SettingMainCurrencyScreenState extends State<SettingMainCurrencyScreen> {

  @override
  Widget build(BuildContext context) {
    final logger = Provider.of<LoggerProvider>(context).logger;
    logger.i("SettingMainCurrencyScreen] build");

    String selectSection = ModalRoute.of(context)?.settings.arguments as String;
    logger.d("SettingMainCurrencyScreen] selectSection: $selectSection");

    String title = '변환 최소 금액';
    if (selectSection == 'maximum') {
      title = '변환 최대 금액';
    } else if (selectSection == 'increaseUnit') {
      title = '변환 증가 폭';
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff119fa8),
        title: const Text("Curree", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: Text(title, style: const TextStyle(fontFamily: 'SUITE',)),
            tiles: _buildCurrencyTiles(selectSection),
          ),
        ],
      ),
    );
  }

  List<SettingsTile> _buildCurrencyTiles(String selectSection) {
    int currentSelectedExchange = context.watch<SettingProvider>().exchangeMinimum;
    List selectedList = minimumList;
    if (selectSection == 'maximum') {
      currentSelectedExchange = context.watch<SettingProvider>().exchangeMaximum;
      selectedList = maximumList;
    } else if (selectSection == 'increaseUnit') {
      currentSelectedExchange = context.watch<SettingProvider>().exchangeIncreaseUnit;
      selectedList = increaseUnitList;
    }


    return selectedList.map((value) {
      return SettingsTile(
        title: Text(value.toString(), style: const TextStyle(
          fontSize: 16,
        ),),
        trailing: currentSelectedExchange == value ? const Icon(Icons.check) : null,
        onPressed: (BuildContext context) {
          setState(() {

            if (selectSection == 'minimum') {
              context.read<SettingProvider>().setExchangeMinimum(value);

              final temp = context.read<FilterProvider>().filterSelectedExchangeMinimum;
              temp.forEach((key, _) {
                temp[key] = false;
                temp[value] = true;
              });
              context.read<FilterProvider>().setFilterSelectedExchangeMinimum(temp);

            } else if (selectSection == 'maximum') {
              context.read<SettingProvider>().setExchangeMaximum(value);

              final temp = context.read<FilterProvider>().filterSelectedExchangeMaximum;
              temp.forEach((key, _) {
                temp[key] = false;
                temp[value] = true;
              });
              context.read<FilterProvider>().setFilterSelectedExchangeMaximum(temp);

            } else if (selectSection == 'increaseUnit') {
              context.read<SettingProvider>().setExchangeIncreaseUnit(value);

              final temp = context.read<FilterProvider>().filterSelectedExchangeIncreaseUnit;
              temp.forEach((key, _) {
                temp[key] = false;
                temp[value] = true;
              });
              context.read<FilterProvider>().setFilterSelectedExchangeIncreaseUnit(temp);
            }

            updateProfile(context);
            Navigator.pop(context);
          });
        },
      );
    }).toList();
  }
}





