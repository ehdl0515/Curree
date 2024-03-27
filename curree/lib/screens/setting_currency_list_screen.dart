import 'package:curree/constant/currency.dart';
import 'package:curree/providers/filter_provider.dart';
import 'package:curree/providers/setting_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';

import '../providers/logger_provider.dart';
import '../util/common_function.dart';


class SettingCurrencyListScreen extends StatefulWidget {
  const SettingCurrencyListScreen({super.key});

  @override
  _SettingCurrencyListScreenState createState() => _SettingCurrencyListScreenState();
}

class _SettingCurrencyListScreenState extends State<SettingCurrencyListScreen> {

  @override
  Widget build(BuildContext context) {
    final logger = Provider.of<LoggerProvider>(context).logger;
    logger.i("SettingCurrencyListScreen] build");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text("Curree", style: TextStyle(fontWeight: FontWeight.bold,),),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: const Text('보조 통화', style: TextStyle(fontFamily: 'SUITE', fontSize: 14)),
            tiles: _buildCurrencyTiles(),
          ),
        ],
      ),
    );
  }

  List<SettingsTile> _buildCurrencyTiles() {
    Currency currentSelectedCurrency = context.watch<SettingProvider>().subCurrency;

    return currencies.map((currency) {
      return SettingsTile(
        title: Text("${currency.name} (${currency.code}, ${currency.symbol})",
        style: const TextStyle(
          fontSize: 16,
        ),
        ),
        trailing: currentSelectedCurrency == currency ? const Icon(Icons.check) : null,
        onPressed: (BuildContext context) {
          setState(() {
            context.read<SettingProvider>().setSubCurrency(currency);
            final temp = context.read<FilterProvider>().filterSelectedSubCurrency;
            temp.forEach((key, _) {
              temp[key] = false;
              temp[currency] = true;
            });
            context.read<FilterProvider>().setFilterSelectedSubCurrency(temp);
            updateProfile(context);
            Navigator.pop(context);
          });
        },
      );
    }).toList();
  }
}





