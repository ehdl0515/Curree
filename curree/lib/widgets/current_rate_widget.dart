import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:curree/providers/rate_provider.dart';
import 'package:curree/util/fetch_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../constant/currency.dart';
import '../providers/logger_provider.dart';

class CurrentRateWidget extends StatefulWidget {
  const CurrentRateWidget({super.key});

  @override
  _CurrentRateWidgetState createState() =>
      _CurrentRateWidgetState();
}

class _CurrentRateWidgetState extends State<CurrentRateWidget> {

  @override
  Widget build(BuildContext context) {
    final logger = Provider.of<LoggerProvider>(context).logger;
    logger.i("CurrentRateWidget] build");

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    Currency dollar = context.watch<RateProvider>().dollar;
    Currency euro = context.watch<RateProvider>().euro;
    Currency yen = context.watch<RateProvider>().yen;
    Currency yuan = context.watch<RateProvider>().yuan;

    List<Currency> newCurrencies = [dollar, euro, yen ,yuan];

    String? selectedNation = Provider.of<RateProvider>(context, listen: false).selectedNation;

    logger.d("CurrentRateWidget] selectedNation: $selectedNation");

    if (selectedNation != null) {
      switch (selectedNation) {
        case '미국':
          newCurrencies = [dollar];
          break;
        case '유럽':
          newCurrencies = [euro];
          break;
        case '일본':
          newCurrencies = [yen];
          break;
        case '중국':
          newCurrencies = [yuan];
          break;
        default:
          newCurrencies = [dollar, euro, yen ,yuan];
    }
  }

    return FutureBuilder(
        future: fetchData(context, newCurrencies),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              String standardDate = snapshot.data[0];
              newCurrencies = snapshot.data[1];
              logger.d('CurrentRateWidget] newCurrencies: $newCurrencies');

              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    height: height * 0.03,
                    child: Text(
                      "기준일시: $standardDate",
                      style: const TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 2,
                    width: width * 0.9,
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: newCurrencies.length,
                      itemBuilder: (BuildContext context, int index) {
                        String name = newCurrencies[index].name;
                        String code = newCurrencies[index].code;
                        String symbol = newCurrencies[index].symbol;
                        String nation = newCurrencies[index].nation;
                        String currentDate = newCurrencies[index].currentDate.toString();
                        String previousDate = newCurrencies[index].previousDate.toString();
                        String currentRate = newCurrencies[index].currentRate;
                        String previousRate = newCurrencies[index].previousRate;
                        String flagImage = newCurrencies[index].flagImage;
                        Icon arrowIcon = const Icon(CupertinoIcons.arrowtriangle_up_fill, color: Colors.red,);
                        if (double.parse(currentRate) < double.parse(previousRate)) {
                          arrowIcon = const Icon(CupertinoIcons.arrowtriangle_down_fill, color: Colors.blue,);
                        }

                        dynamic imageBlock = Image.asset(flagImage, width: width * 0.15, height: height * 0.03,);

                        if (flagImage.endsWith('svg')) {
                          imageBlock = SvgPicture.asset(flagImage, width: width * 0.15, height: height * 0.03,);
                        }

                        return Column(
                          children: [
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Container(
                              width: width * 0.8,
                              height: height * 0.1,
                              alignment: Alignment.centerLeft,
                              // margin: EdgeInsets.symmetric(horizontal: width * 0.036, vertical: height * 0.05),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 4,
                                    offset: const Offset(1,1),
                                  )]
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height: height * 0.1 * 0.1,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: width * 0.8 * 0.05,
                                      ),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(5),

                                        child: Container(
                                          decoration: const BoxDecoration(
                                            color: Colors.white30,
                                          ),
                                          child: imageBlock,
                                        ),
                                      ),

                                      Container(
                                        margin: EdgeInsets.only(left: width * 0.8 * 0.03),
                                        child: Text(
                                          "$nation $name($code,$symbol)",
                                          style: const TextStyle(
                                            // fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(left: 10),
                                        child: arrowIcon,
                                      )
                                    ],
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(horizontal:15, vertical: 10),
                                    child: AutoSizeText.rich(
                                      TextSpan(
                                          children: [
                                            const TextSpan(
                                              text: "현재 환율: ",
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                            TextSpan(
                                              text: currentRate,
                                              style: const TextStyle(
                                                color: Colors.blueGrey,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const TextSpan(
                                              text: "    이전 환율: ",
                                              style: TextStyle(
                                                color: Colors.grey,
                                              ),
                                            ),
                                            TextSpan(
                                              text: previousRate,
                                              style: const TextStyle(
                                                color: Colors.blueGrey,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ]
                                      ),
                                      maxLines: 1,
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
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
              );
            }
          }
        });
  }
}
