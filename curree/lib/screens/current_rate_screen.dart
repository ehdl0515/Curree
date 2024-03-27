import 'package:curree/providers/rate_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/logger_provider.dart';
import '../widgets/current_rate_widget.dart';


class MyCurrentRateScreen extends StatefulWidget {
  const MyCurrentRateScreen({super.key});

  @override
  State<MyCurrentRateScreen> createState() =>
      _MyCurrentRateScreenState();
}

class _MyCurrentRateScreenState extends State<MyCurrentRateScreen> {

  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final logger = Provider.of<LoggerProvider>(context).logger;
    logger.i("MyCurrentRateScreen] build");

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          height: height * 3,
          child: Column(
            children: [
              const SizedBox(
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
                      FocusScope.of(context).unfocus();
                      logger.d('pressed search icon');
                      context.read<RateProvider>().setSelectedNation(_controller.text);
                      logger.d('value = ${_controller.text}');
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
                hintText: "나라 이름을 입력하세요",
                onSubmitted: (value) {
                  setState(() {
                    context.read<RateProvider>().setSelectedNation(value);
                    logger.d('value = $value');
                  });
                },
                onTap: () {
                  _controller.selection = TextSelection(
                      baseOffset: 0,
                      extentOffset: _controller.text.length);
                },
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                height: height * 0.07,
                child: Text(
                  "10분 간격으로 업데이트됩니다 (주말, 공휴일 제외)",
                  style: TextStyle(
                    color: Colors.grey[400],
                  ),
                ),
              ),
              const CurrentRateWidget(),
            ],
          ),
        ),
      ),
    );
  }
}