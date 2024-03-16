import 'package:curree/providers/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';

import '../constant/currency.dart';
import 'setting_currency_list_screen.dart';
import 'setting_main_currency_screen.dart';


class MySettingScreen extends StatelessWidget {
  const MySettingScreen({super.key});

  @override
  Widget build(BuildContext context) {

    Currency selectedMainCurrency = context.watch<GlobalStore>().mainCurrency;
    Currency selectedSubCurrency = context.watch<GlobalStore>().subCurrency;
    int selectedExchangeMinimum = context.watch<GlobalStore>().exchangeMinimum;
    int selectedExchangeMaximum = context.watch<GlobalStore>().exchangeMaximum;
    int selectedExchangeIncreaseUnit = context.watch<GlobalStore>().exchangeIncreaseUnit;

    return Scaffold(
        body: SettingsList(
          sections: [
            SettingsSection(
              title: const Text('통화', style: TextStyle(fontFamily: 'SUITE', fontWeight: FontWeight.bold,)),
              tiles: <SettingsTile>[
                SettingsTile.navigation(
                  onPressed: (BuildContext context) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingCurrencyListScreen(),
                      settings: const RouteSettings(arguments: 'main')
                    ));
                    selectedMainCurrency = context.read<GlobalStore>().mainCurrency;
                  },
                  leading: const Icon(CupertinoIcons.money_dollar_circle_fill),
                  title: const Text('주 통화', style: TextStyle(fontFamily: 'SUITE',)),
                  description: const Text("기본 주 통화입니다. '환율변환'  탭에서 일시적으로 변경할 수 있습니다."),
                  value: Text(selectedMainCurrency.code),
                ),
                SettingsTile.navigation(
                  onPressed: (BuildContext context) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingCurrencyListScreen(),
                      settings: const RouteSettings(arguments: 'sub')
                    ));
                    selectedSubCurrency = context.read<GlobalStore>().subCurrency;
                  },
                  leading: const Icon(CupertinoIcons.money_dollar_circle),
                  title: const Text('보조 통화', style: TextStyle(fontFamily: 'SUITE',)),
                  description: const Text("기본 보조 통화입니다. '환율변환'  탭에서 일시적으로 변경할 수 있습니다."),
                  value: Text(selectedSubCurrency.code),
                ),
                // SettingsTile.switchTile(
                //     onToggle: (value) {},
                //     initialValue: true,
                //     leading: const Icon(Icons.format_paint),
                //     title: const Text('enable custom theme'),
                // )
              ],
            ),

            SettingsSection(
              title: const Text('변환', style: TextStyle(fontFamily: 'SUITE', fontWeight: FontWeight.bold,)),
              tiles: <SettingsTile>[
                SettingsTile.navigation(
                  onPressed: (BuildContext context) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingMainCurrencyScreen(),
                        settings: const RouteSettings(arguments: 'minimum'),

                    ));
                    selectedExchangeMinimum = context.read<GlobalStore>().exchangeMinimum;
                  },
                  leading: const Icon(CupertinoIcons.number_circle_fill),
                  title: const Text('주 통화 최소 금액', style: TextStyle(fontFamily: 'SUITE',)),
                  description: const Text("주 통화 기본 최소 금액입니다. '환율변환'  탭에서 일시적으로 변경할 수 있습니다."),
                  value: Text(selectedExchangeMinimum.toString()),
                ),
                SettingsTile.navigation(
                  onPressed: (BuildContext context) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingMainCurrencyScreen(),
                    settings: const RouteSettings(arguments: 'maximum'),
                    ));
                    selectedExchangeMaximum = context.read<GlobalStore>().exchangeMaximum;
                  },
                  leading: const Icon(CupertinoIcons.number_circle),
                  title: const Text('주 통화 최대 금액', style: TextStyle(fontFamily: 'SUITE',)),
                  description: const Text("주 통화 기본 최대 금액입니다. '환율변환'  탭에서 일시적으로 변경할 수 있습니다."),
                  value: Text(selectedExchangeMaximum.toString()),
                ),
                SettingsTile.navigation(
                  onPressed: (BuildContext context) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingMainCurrencyScreen(),
                      settings: const RouteSettings(arguments: 'increaseUnit'),
                    ));
                    selectedExchangeIncreaseUnit = context.read<GlobalStore>().exchangeIncreaseUnit;
                  },
                  leading: const Icon(CupertinoIcons.chevron_up),
                  title: const Text('주 통화 증가 폭', style: TextStyle(fontFamily: 'SUITE',)),
                  description: const Text("주 통화 금액의 기본 증가폭입니다. '환율변환'  탭에서 일시적으로 변경할 수 있습니다."),
                  value: Text(selectedExchangeIncreaseUnit.toString()),
                ),
              ],
            ),
          ],
        )
    );
  }
}