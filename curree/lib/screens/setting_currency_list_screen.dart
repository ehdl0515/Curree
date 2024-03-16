import 'package:curree/constant/currency.dart';
import 'package:curree/providers/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';


class SettingCurrencyListScreen extends StatefulWidget {
  const SettingCurrencyListScreen({super.key});

  @override
  _SettingCurrencyListScreenState createState() => _SettingCurrencyListScreenState();
}

class _SettingCurrencyListScreenState extends State<SettingCurrencyListScreen> {

  @override
  Widget build(BuildContext context) {

    String selectSection = ModalRoute.of(context)?.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: const Text('통화 목록', style: TextStyle(fontFamily: 'SUITE',),),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: selectSection == 'main' ? const Text('주 통화', style: TextStyle(fontFamily: 'SUITE',)) : const Text('보조 통화', style: TextStyle(fontFamily: 'SUITE',)),
            tiles: _buildCurrencyTiles(selectSection),
          ),
        ],
      ),
    );
  }

  List<SettingsTile> _buildCurrencyTiles(String selectSection) {
    Currency currentSelectedCurrency = context.read<GlobalStore>().mainCurrency;

    if (selectSection == 'sub') {
      currentSelectedCurrency = context.read<GlobalStore>().subCurrency;
    }


    return currencyList.map((currency) {
      return SettingsTile(
        title: Text("${currency.name} (${currency.code}, ${currency.symbol})"),
        trailing: currentSelectedCurrency == currency ? const Icon(Icons.check) : null,
        onPressed: (BuildContext context) {
          setState(() {
            if (selectSection == 'main') {
              context.read<GlobalStore>().setMainCurrency(currency);
            } else {
              context.read<GlobalStore>().setSubCurrency(currency);
            }
            Navigator.pop(context);
          });
        },
      );
    }).toList();
  }
}





