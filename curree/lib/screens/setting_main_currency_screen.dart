import 'package:curree/constant/currency.dart';
import 'package:curree/constant/exchange_unit.dart';
import 'package:curree/providers/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';


class SettingMainCurrencyScreen extends StatefulWidget {
  const SettingMainCurrencyScreen({super.key});

  @override
  _SettingMainCurrencyScreenState createState() => _SettingMainCurrencyScreenState();
}

class _SettingMainCurrencyScreenState extends State<SettingMainCurrencyScreen> {

  @override
  Widget build(BuildContext context) {

    String selectSection = ModalRoute.of(context)?.settings.arguments as String;
    String title = '주 통화 최소 금액';
    if (selectSection == 'maximum') {
      title = '주 통화 최대 금액';
    } else if (selectSection == 'increaseUnit') {
      title = '주 통화 증가 폭';
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('변환 단위', style: TextStyle(fontFamily: 'SUITE',),),
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
    int currentSelectedExchange = context.read<GlobalStore>().exchangeMinimum;
    List selectedList = minimumList;
    if (selectSection == 'maximum') {
      currentSelectedExchange = context.read<GlobalStore>().exchangeMaximum;
      selectedList = maximumList;
    } else if (selectSection == 'increaseUnit') {
      currentSelectedExchange = context.read<GlobalStore>().exchangeIncreaseUnit;
      selectedList = increaseUnitList;
    }


    return selectedList.map((value) {
      return SettingsTile(
        title: Text(value.toString()),
        trailing: currentSelectedExchange == value ? const Icon(Icons.check) : null,
        onPressed: (BuildContext context) {
          setState(() {

            if (selectSection == 'minimum') {
              context.read<GlobalStore>().setExchangeMinimum(value);
            } else if (selectSection == 'maximum') {
              context.read<GlobalStore>().setExchangeMaximum(value);
            } else if (selectSection == 'increaseUnit') {
              context.read<GlobalStore>().setExchangeIncreaseUnit(value);
            }

            Navigator.pop(context);
          });
        },
      );
    }).toList();
  }
}





