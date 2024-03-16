import 'package:curree/widgets/current_rate_widget.dart';
import 'package:curree/providers/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constant/currency.dart';


class MyCurrentRateScreen extends StatefulWidget {
  const MyCurrentRateScreen({super.key});

  @override
  State<MyCurrentRateScreen> createState() =>
      _MyCurrentRateScreenState();
}

class _MyCurrentRateScreenState extends State<MyCurrentRateScreen> {

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    Currency mainCurrency = context.watch<GlobalStore>().mainCurrency;


    return SingleChildScrollView(
      child: Container(
        height: height * 3,
        width: width,
        child: Stack(
          children: <Widget>[
            Positioned(
              child: Container(
                color: Colors.white,
                height: height * 3,
              ),
            ),
            Positioned(
              child: Container(
                height: height * 0.26,
                width: width,
                alignment: Alignment.topLeft,
                padding: EdgeInsets.fromLTRB(width * 0.048, height * 0.024, 0, 0),
                decoration: BoxDecoration(
                  color: Colors.blueGrey[200],
                ),
                child: const Text('실시간 환율 정보', style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'SUITE',
                  fontSize: 30,
                ),),
              ),
            ),
            Positioned(
              top: height * 0.15,
              width: width,
              height: height * 0.2,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: width * 0.036, vertical: height * 0.036),
                alignment: Alignment.topLeft,
                decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: const Offset(1,1),
                    )]
                ),
                child: Stack(
                  children: [
                    Positioned(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(width * 0.048, height * 0.024, 0, 0),
                        child: const Text('선택된 주 통화',
                          style: TextStyle(
                            fontFamily: 'SUITE',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(width * 0.060, height * 0.072, 0, 0),
                        child: Text(
                          '${mainCurrency.code} (${mainCurrency.name}, ${mainCurrency.symbol})',
                          style: const TextStyle(
                            fontFamily: 'SUITE',
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              height: height * 0.6,
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: width * 0.036, vertical: height * 0.35),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(10),
                boxShadow: [BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: const Offset(1,1),
                )]
              ),
              child: const CurrentRateWidget(),
            )
          ],
        ),
      ),
    );
  }
}