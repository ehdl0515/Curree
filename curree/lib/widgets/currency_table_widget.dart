import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../constant/currency.dart';

class CurrencyTableWidget extends StatefulWidget {

  final Map<dynamic, dynamic> applyData;

  const CurrencyTableWidget({super.key, required this.applyData});

  @override
  _CurrencyTableWidgetState createState() =>
      _CurrencyTableWidgetState();
}

class _CurrencyTableWidgetState extends State<CurrencyTableWidget> {

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    Currency selectedMainCurrency = widget.applyData.remove('mainCurrency');
    Currency selectedSubCurrency = widget.applyData.remove('subCurrency');

    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(width * 0.036, height * 0.024, 0, 0),
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontFamily: 'SUITE',
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                  children: [
                    TextSpan(
                      text: selectedMainCurrency.code,
                      style: TextStyle(
                        color: Colors.blueGrey[300],
                      ),
                    ),
                    const TextSpan(
                      text: ' 를\n',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    TextSpan(
                      text: selectedSubCurrency.code,
                      style: const TextStyle(
                        color: Colors.pink,
                      ),
                    ),
                    const TextSpan(
                      text: '   로 변환합니다.',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ]
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(width * 0.10, height * 0.024, 0, 0),
              child: const Text(
                '2024-03-02 16:20',
                style: TextStyle(
                  fontFamily: 'SUITE',
                  fontWeight: FontWeight.normal,
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.fromLTRB(width * 0.036, height * 0.010, 0, 0),
          alignment: Alignment.centerLeft,
          child: const Text(
            '출처: OpenExchangeReference',
            style: TextStyle(
              fontFamily: 'SUITE',
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ),
        Container(
          height: height * 0.4 + height * 0.01 * widget.applyData.length,
          width: width * 0.8,
          margin: EdgeInsets.only(top: height * 0.012),
          child:
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.applyData.length,
            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 1,
              // mainAxisSpacing: width * 0.010,
              // crossAxisSpacing: height * 0.010,
            ),
            itemBuilder: (BuildContext context, int index) {

              int key = widget.applyData.keys.elementAt(index);
              double value = widget.applyData[key]!;
              return Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(
                    top: const BorderSide(color: Colors.grey, width: 1),
                    left: const BorderSide(color: Colors.grey, width: 1),
                    right: BorderSide(color: Colors.grey, width: index.isEven ? 0 : 1), // 맨 오른쪽 요소의 경우만 테두리 추가
                    bottom: BorderSide(color: Colors.grey, width: index < widget.applyData.length - 2 ? 0 : 1), // 맨 아래 요소의 경우만 테두리 추가
              ),
                ),
                child: ListTile(
                  // trailing: const Icon(CupertinoIcons.arrowtriangle_up_fill, color: Colors.red,),
                  title: AutoSizeText.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: key.toString(),
                          style: TextStyle(
                            color: Colors.blueGrey[300],
                          ),
                        ),
                        const TextSpan(
                          text: ' = ',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: value.toString(),
                          style: const TextStyle(
                            color: Colors.pink,
                          ),
                        ),
                      ]
                    ),
                    maxLines: 1,
                    style: const TextStyle(
                      fontFamily: 'SUITE',
                      fontSize: 16,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
