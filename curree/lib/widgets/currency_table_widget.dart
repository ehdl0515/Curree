import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constant/currency.dart';
import '../providers/filter_provider.dart';
import '../providers/logger_provider.dart';

class CurrencyTableWidget extends StatefulWidget {
  final List<int> applyData;

  const CurrencyTableWidget({super.key, required this.applyData});

  @override
  _CurrencyTableWidgetState createState() => _CurrencyTableWidgetState();
}
class _CurrencyTableWidgetState extends State<CurrencyTableWidget> {
  @override
  Widget build(BuildContext context) {
    final logger = Provider.of<LoggerProvider>(context).logger;
    logger.i("CurrencyTableWidget] build");
    logger.d("CurrencyTableWidget] tableData: ${widget.applyData}");

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    Map<Currency, bool> subData = context.watch<FilterProvider>().filterSelectedSubCurrency;
    Currency selectedSubCurrency = FilterProvider.getTrueSubCurrency(subData);

    String name = selectedSubCurrency.name;
    String code = selectedSubCurrency.code;
    String symbol = selectedSubCurrency.symbol;
    String nation = selectedSubCurrency.nation;
    int unit = selectedSubCurrency.unit;
    DateTime? currentDate = selectedSubCurrency.currentDate;
    String currentRate = selectedSubCurrency.currentRate;

    String stringDate = currentDate != null ? currentDate.toString() : "";
    String standardDate = "";
    if (stringDate != "") {
      standardDate = stringDate.substring(0, stringDate.length - 7);
    }

    logger.d("CurrencyTableWidget] selectedSubCurrency: $selectedSubCurrency");

    return Column(
        children: [
          Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: width * 0.1),
              // margin: EdgeInsets.only(left: width * 0.8 * 0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("변환 통화: $code", style: TextStyle(color: Colors.blueGrey[300]),),
                  Text('적용 환율: $currentRate', style: TextStyle(color: Colors.blueGrey[300]),),
                  Text("환율 일시: $standardDate", style: TextStyle(color: Colors.blueGrey[300]),)
                ],
              )
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                height: 50 * (widget.applyData.length + 2),
                width: width * 0.4,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.applyData.length,
                  itemBuilder: (BuildContext context, int index) {
                    int originValue = widget.applyData[index];

                    return Column(
                      children: [
                        Container(
                          width: width * 0.35,
                          height: height * 0.05,
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 4,
                                  offset: const Offset(1, 1),
                                )
                              ]
                            // border: Border.all(width: 0.5),
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: height * 0.01,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: width * 0.8 * 0.05,
                                  ),
                                ],
                              ),
                              AutoSizeText.rich(
                                TextSpan(children: [
                                  TextSpan(
                                    text: originValue.toString(),
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: " $symbol",
                                    style: const TextStyle(
                                      color: Colors.black54,
                                    ),
                                  ),
                                ]),
                                maxLines: 1,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),



              Container(
                alignment: Alignment.centerLeft,
                height: 50 * (widget.applyData.length + 2),
                width: width * 0.1,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  // itemExtent: 55,
                  itemCount: widget.applyData.length,
                  itemBuilder: (BuildContext context, int index) {

                    return Column(
                      children: [
                        Container(
                          width: width * 0.35,
                          height: height * 0.05,
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                height: height * 0.01,
                                child: const Icon(Icons.arrow_forward_rounded,
                                  size: 20,
                                  color: Colors.blueGrey,),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),


              Container(
                alignment: Alignment.centerRight,
                height: 50 * (widget.applyData.length + 2),
                width: width * 0.4,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.applyData.length,
                  // itemExtent: 55,
                  itemBuilder: (BuildContext context, int index) {
                    int originValue = widget.applyData[index];
                    String convertValue = (originValue * double.parse(selectedSubCurrency.currentRate)).toStringAsFixed(2);
                    if (unit == 100) {
                      convertValue = (double.parse(convertValue) / 100).toStringAsFixed(2);
                    }

                    return Column(
                      children: [
                        Container(
                          width: width * 0.35,
                          height: height * 0.05,
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 4,
                                  offset: const Offset(1, 1),
                                )
                              ]
                            // border: Border.all(width: 0.5),
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: height * 0.01,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: width * 0.8 * 0.05,
                                  ),
                                ],
                              ),
                              AutoSizeText.rich(
                                TextSpan(children: [
                                  TextSpan(
                                    text: convertValue.toString(),
                                    style: const TextStyle(
                                      color: Colors.blueGrey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: " 원",
                                    style: TextStyle(
                                      color: Colors.blueGrey[100],
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ]),
                                maxLines: 1,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ],
    );
  }
}
