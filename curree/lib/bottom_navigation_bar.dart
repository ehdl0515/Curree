import 'dart:convert';

import 'package:curree/constant/currency.dart';
import 'package:curree/providers/logger_provider.dart';
import 'package:curree/providers/rate_provider.dart';
import 'package:curree/providers/setting_provider.dart';
import 'package:curree/screens/currency_table_screen.dart';
import 'package:curree/screens/current_rate_screen.dart';
import 'package:curree/screens/setting_screen.dart';
import 'package:curree/util/call_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({super.key});

  @override
  State<MyBottomNavigationBar> createState() =>
      _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    MyCurrentRateScreen(),
    MyCurrencyTableScreen(),
    MySettingScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      context.read<RateProvider>().setSelectedNation(null);
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    final logger = Provider.of<LoggerProvider>(context).logger;
    logger.i('MyBottomNavigationBar] build');

    Map<String, dynamic> deviceInfo = context.read<SettingProvider>().deviceInfo;
    logger.d("MyBottomNavigationBar] selectedIndex: $_selectedIndex, identifierForVendor: ${deviceInfo['identifierForVendor']}");

    final backendServer = dotenv.get("BACKEND_SERVER", fallback: "127.0.0.1:8000");

    Map<String, dynamic> params = {
      "deviceId": deviceInfo["identifierForVendor"],
    };
    Uri url = Uri.http(backendServer, "/profile", params);
    Future<String> result = callGetAPI(url);

    result.then((newValueJson) {
      dynamic newValue = jsonDecode(newValueJson);
      logger.d("MyBottomNavigationBar] get response profileInfo: $newValue");
      String subCurrencyCode = newValue[0]["subCurrency"];
      Currency subCurrency = currencies[0];
      for (var element in currencies) {
        if (element.code == subCurrencyCode) {
          subCurrency = element;
          break;
        }
      }
      context.read<SettingProvider>().setProfileNo(newValue[0]["profileNo"]);
      context.read<SettingProvider>().setSubCurrency(subCurrency);
      context.read<SettingProvider>().setExchangeMinimum(newValue[0]["exchangeMinimum"]);
      context.read<SettingProvider>().setExchangeMaximum(newValue[0]["exchangeMaximum"]);
      context.read<SettingProvider>().setExchangeIncreaseUnit(newValue[0]["exchangeIncreaseUnit"]);
    });


    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff119fa8),
        title: const Text("Curree", style: TextStyle(fontWeight: FontWeight.bold,),),
      ),
      body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.currency_exchange),
            label: '현재 환율',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.table_fill),
            label: '환율 변환',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '설정',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueGrey[500],
        onTap: _onItemTapped,
      ),
    );
  }
}