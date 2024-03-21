import 'package:curree/constant/currency.dart';
import 'package:curree/providers/setting_provider.dart';
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('통화 목록', style: TextStyle(fontFamily: 'SUITE',),),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: const Text('보조 통화', style: TextStyle(fontFamily: 'SUITE',)),
            tiles: _buildCurrencyTiles(),
          ),
        ],
      ),
    );
  }

  List<SettingsTile> _buildCurrencyTiles() {
    Currency currentSelectedCurrency = context.read<SettingProvider>().subCurrency;

    return currencies.map((currency) {
      return SettingsTile(
        title: Text("${currency.name} (${currency.code}, ${currency.symbol})"),
        trailing: currentSelectedCurrency == currency ? const Icon(Icons.check) : null,
        onPressed: (BuildContext context) {
          setState(() {
            context.read<SettingProvider>().setSubCurrency(currency);
            Navigator.pop(context);
          });
        },
      );
    }).toList();
  }
}





