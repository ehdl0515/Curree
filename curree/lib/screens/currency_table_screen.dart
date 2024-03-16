import 'package:curree/providers/filter_provider.dart';
import 'package:curree/util/common_function.dart';
import 'package:curree/widgets/currency_table_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constant/exchange_unit.dart';
import '../widgets/single_select_increase_widget.dart';
import '../widgets/single_select_maximum_widget.dart';
import '../widgets/single_select_minimum_widget.dart';
import '../widgets/single_select_sub_currency_widget.dart';
import '../widgets/single_select_main_currency_widget.dart';


class MyCurrencyTableScreen extends StatefulWidget {
  const MyCurrencyTableScreen({super.key});

  @override
  State<MyCurrencyTableScreen> createState() =>
      _MyCurrencyTableScreenState();
}

class _MyCurrencyTableScreenState extends State<MyCurrencyTableScreen> {

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    final ScrollController _scrollController = ScrollController();

    Map<dynamic, dynamic> tableData = {};
    tableData = makeGridMap(context);

    return SingleChildScrollView(
      controller: _scrollController,
      child: SizedBox(
        height: height * 10,
        width: width,
        child: Column(
            children: [
              Container(
                height: height * 0.26,
                width: width,
                alignment: Alignment.topLeft,
                padding: EdgeInsets.fromLTRB(width * 0.048, height * 0.024, 0, 0),
                decoration: BoxDecoration(
                  color: Colors.blueGrey[200],
                ),
                child: const Text('단위 별 환율\n계산표', style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'SUITE',
                  fontSize: 30,
                ),),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: ExpansionTile(
                  title: const Text('필터'),
                  subtitle: const Text('설정탭의 값이 기본입니다.'),
                  initiallyExpanded: false,
                  onExpansionChanged: (isExpanded) {
                    setState(() {
                    });
                  },
                  children: <Widget>[
                    const Divider(
                      color: Colors.black,
                    ),
                    Container(
                      height: height * 0.5,
                      margin: EdgeInsets.fromLTRB(width * 0.024, 0, 0, 0),
                      child: Column(
                        children: [
                          Container(
                            height: height * 0.05,
                            alignment: Alignment.centerLeft,
                            child: const Text('주 통화 (보조 통화와 같을 수 없습니다)', style: TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'SUITE',
                              fontSize: 16,
                            ),),
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: height * 0.032,
                            child: const SingleSelectionMainCurrencyWidget(),
                          ),

                          Container(
                            height: height * 0.05,
                            margin: EdgeInsets.fromLTRB(0, height * 0.012, 0, 0),
                            alignment: Alignment.centerLeft,
                            child: const Text('보조 통화 (주 통화와 같을 수 없습니다)', style: TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'SUITE',
                              fontSize: 16,
                            ),),
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: height * 0.032,
                            child: const SingleSelectionSubCurrencyWidget(),
                          ),


                          Container(
                            height: height * 0.05,
                            margin: EdgeInsets.fromLTRB(0, height * 0.012, 0, 0),
                            alignment: Alignment.centerLeft,
                            child: const Text('주 통화 최소 금액 (최대 금액보다 클 수 없습니다)', style: TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'SUITE',
                              fontSize: 16,
                            ),),
                          ),
                          Container(
                            // margin: EdgeInsets.symmetric(horizontal: width * 0.036, vertical: height * 0.395),
                            alignment: Alignment.center,
                            height: height * 0.032,
                            child: const SingleSelectionMinimumWidget(),
                          ),


                          Container(
                            height: height * 0.05,
                            margin: EdgeInsets.fromLTRB(0, height * 0.012, 0, 0),
                            alignment: Alignment.centerLeft,
                            child: const Text('주 통화 최대 금액 (최소 금액보다 작을 수 없습니다)', style: TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'SUITE',
                              fontSize: 16,
                            ),),
                          ),
                          Container(
                            // margin: EdgeInsets.symmetric(horizontal: width * 0.036, vertical: height * 0.48),
                            alignment: Alignment.center,
                            height: height * 0.032,
                            child: const SingleSelectionMaximumWidget(),
                          ),


                          Container(
                            height: height * 0.05,
                            margin: EdgeInsets.fromLTRB(0, height * 0.012, 0, 0),
                            alignment: Alignment.centerLeft,
                            child: const Text('주 통화 금액 증가폭', style: TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'SUITE',
                              fontSize: 16,
                            ),),
                          ),
                          Container(
                            // margin: EdgeInsets.symmetric(horizontal: width * 0.036, vertical: height * 0.57),
                            alignment: Alignment.center,
                            height: height * 0.032,
                            child: const SingleSelectionIncreaseUnitWidget(),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: width * 0.8,
                      margin: EdgeInsets.only(bottom: height * 0.024),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(width * 0.3, height * 0.05),
                              elevation: 2,
                              foregroundColor: Colors.black,
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              )
                            ),
                            onPressed: () {
                              Map<dynamic, dynamic> newTableData = makeGridMap(context);
                              setState(() {
                                tableData = newTableData;
                              });
                              _scrollController.animateTo(height, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
                            },
                            child: const Text('적용'),
                          ),
                          Container(width: width * 0.1,),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: Size(width * 0.3, height * 0.05),
                                elevation: 2,
                                foregroundColor: Colors.black,
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                )
                            ),
                            onPressed: () {
                              context.read<FilterProvider>().setFilterSelectedMainCurrency(FilterProvider.setMyMap());
                              context.read<FilterProvider>().setFilterSelectedSubCurrency(FilterProvider.setMyMap());
                              context.read<FilterProvider>().setFilterSelectedExchangeMinimum(FilterProvider.setMyInt(minimumList));
                              context.read<FilterProvider>().setFilterSelectedExchangeMaximum(FilterProvider.setMyInt(maximumList));
                              context.read<FilterProvider>().setFilterSelectedExchangeIncreaseUnit(FilterProvider.setMyInt(increaseUnitList));
                              Map<dynamic, dynamic> newTableData = makeGridMap(context);

                              setState(() {
                                tableData = newTableData;
                              });
                            },
                            child: const Text('초기화'),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),


              Container(
                height: height * 0.6 + height * 0.01 * tableData.length,
                alignment: Alignment.topCenter,
                margin: EdgeInsets.symmetric(horizontal: width * 0.036, vertical: height * 0.03),
                decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: const Offset(1,1),
                    )]
                  // border: Border.all(width: 0.5),
                ),
                child: CurrencyTableWidget(applyData: tableData,),
              ),
            ],
          )
      ),
    );
  }
}