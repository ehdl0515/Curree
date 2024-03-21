import 'package:auto_size_text/auto_size_text.dart';
import 'package:curree/providers/rate_provider.dart';
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

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    Currency dollar = context.watch<RateProvider>().dollar;
    Currency euro = context.watch<RateProvider>().euro;
    Currency yen = context.watch<RateProvider>().yen;
    Currency yuan = context.watch<RateProvider>().yuan;

    List<Currency> newCurrencies = [dollar, euro, yen ,yuan];

    String? selectedNation = Provider.of<RateProvider>(context).selectedNation;

    logger.d("build CurrentRateWidget: $selectedNation");

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

    logger.d('build CurrentRateWidget');
    logger.d("$newCurrencies");

    return SizedBox(
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
          int currentDate = newCurrencies[index].currentDate;
          int previousDate = newCurrencies[index].previousDate;
          String currentRate = newCurrencies[index].currentRate;
          String previousRate = newCurrencies[index].previousRate;
          String flagImage = newCurrencies[index].flagImage;

          dynamic imageBlock = Image.asset(flagImage, width: width * 0.15, height: height * 0.03,);

          if (flagImage.endsWith('svg')) {
            imageBlock = SvgPicture.asset(flagImage, width: width * 0.15, height: height * 0.03,);
          }

          return Column(
            children: [
              const SizedBox(
                height: 10,
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
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
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
                                  color: Colors.grey,
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
    );
  }
}
