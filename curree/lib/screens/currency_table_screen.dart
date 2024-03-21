import 'package:curree/providers/filter_provider.dart';
import 'package:curree/util/common_function.dart';
import 'package:curree/widgets/currency_table_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constant/exchange_unit.dart';
import '../providers/logger_provider.dart';
import '../widgets/single_select_increase_widget.dart';
import '../widgets/single_select_maximum_widget.dart';
import '../widgets/single_select_minimum_widget.dart';
import '../widgets/single_select_sub_currency_widget.dart';


class MyCurrencyTableScreen extends StatefulWidget {
  const MyCurrencyTableScreen({super.key});

  @override
  State<MyCurrencyTableScreen> createState() =>
      _MyCurrencyTableScreenState();
}

class _MyCurrencyTableScreenState extends State<MyCurrencyTableScreen> {

  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {

    final logger = Provider.of<LoggerProvider>(context).logger;
    final ScrollController _scrollController = ScrollController();

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    List<int> tableData = context.watch<FilterProvider>().selectedConverts;
    if (tableData.isEmpty) {
      tableData = makeGridMap(context);
    }

    logger.d('build MyCurrencyTableScreen');


    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SingleChildScrollView(
        controller: _scrollController,
        child: SizedBox(
            height: height * 5,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                SearchBar(
                  controller: _controller,
                  constraints: BoxConstraints(
                    maxHeight: height * 0.07,
                    maxWidth: width * 0.8,
                  ),
                  trailing: [
                    IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        logger.d('pressed search icon');
                        FocusScope.of(context).unfocus();
                        int newValue = int.parse(_controller.text);
                        context.read<FilterProvider>().setSelectedConvert(newValue);
                        logger.d('newValue = $newValue');
                        setState(() {
                          context.read<FilterProvider>().setSelectedConverts([newValue]);
                          _scrollController.animateTo(height * 0.7, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
                        });
                      },
                    ),
                  ],
                  backgroundColor: const MaterialStatePropertyAll(Colors.white),
                  elevation: const MaterialStatePropertyAll(0),
                  overlayColor: MaterialStatePropertyAll(Colors.blueGrey[50]),

                  shape: MaterialStateProperty.all(ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  ),
                  side: MaterialStateProperty.all(const BorderSide(
                    width: 0.5,
                    color: Colors.grey,
                  )),
                  // textStyle: MaterialStateProperty.all(TextStyle(
                  //
                  // )),
                  padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
                  hintText: "금액을 입력하세요",
                  onSubmitted: (value) {
                    setState(() {
                      int newValue = int.parse(value);
                      context.read<FilterProvider>().setSelectedConvert(newValue);
                      logger.d('newValue = $newValue');
                      context.read<FilterProvider>().setSelectedConverts([newValue]);

                      _scrollController.animateTo(height * 0.7, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);

                    });
                  },
                  onTap: () {
                    _controller.selection = TextSelection(
                        baseOffset: 0,
                        extentOffset: _controller.text.length);
                  },
                ),


                Container(
                  width: width * 0.8,
                  margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                  child: ExpansionTile(
                    title: const Text('필터', style: TextStyle(fontWeight: FontWeight.bold),),
                    subtitle: const Text('설정탭의 값이 기본입니다.'),
                    initiallyExpanded: true,
                    onExpansionChanged: (isExpanded) {
                      setState(() {
                        FocusScope.of(context).unfocus();

                      });
                    },
                    children: [
                      // const Divider(
                      //   color: Colors.black,
                      // ),
                      Container(
                        height: height * 0.42,
                        margin: EdgeInsets.fromLTRB(width * 0.024, 0, 0, 0),
                        child: Column(
                          children: [
                            Container(
                              height: height * 0.05,
                              margin: EdgeInsets.fromLTRB(0, height * 0.012, 0, 0),
                              alignment: Alignment.centerLeft,
                              child: const Text('보조 통화 (변환할 통화)', style: TextStyle(
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
                              child: const Text('변환 최소 금액 (최대 금액보다 클 수 없습니다)', style: TextStyle(
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
                              child: const Text('변환 최대 금액 (최소 금액보다 작을 수 없습니다)', style: TextStyle(
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
                              child: const Text('변환 금액 증가폭', style: TextStyle(
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
                                setState(() {
                                  _controller.text = "";
                                  logger.d('ddd');
                                  List<int> temp = makeGridMap(context);
                                  logger.d('ffff');
                                  context.read<FilterProvider>().setSelectedConverts(temp);
                                  logger.d('111');

                                });
                                _scrollController.animateTo(height * 0.7, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
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
                                context.read<FilterProvider>().setFilterSelectedSubCurrency(FilterProvider.setMyMap());
                                context.read<FilterProvider>().setFilterSelectedExchangeMinimum(FilterProvider.setMyInt(minimumList));
                                context.read<FilterProvider>().setFilterSelectedExchangeMaximum(FilterProvider.setMyInt(maximumList));
                                context.read<FilterProvider>().setFilterSelectedExchangeIncreaseUnit(FilterProvider.setMyInt(increaseUnitList));

                                setState(() {
                                  _controller.text = "";
                                  context.read<FilterProvider>().setSelectedConverts(makeGridMap(context));
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
                // 변환 테이블 시작
                CurrencyTableWidget(applyData: tableData,),
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
                    _scrollController.animateTo(0, duration: const Duration(milliseconds: 750), curve: Curves.ease);
                  },
                  child: const Text('TOP'),
                ),
              ],
            )
        ),
      ),
    );
  }
}