import 'package:flutter/material.dart';
import 'package:working_calendar/locator_service.dart';
import 'package:working_calendar/widgets/action_button.dart';
import 'package:working_calendar/widgets/calendar_start_page.dart';
import 'package:working_calendar/widgets/input_date.dart';
import 'package:working_calendar/widgets/input_studying_time.dart';
import 'package:working_calendar/widgets/memo_text.dart';
import 'package:working_calendar/widgets/warning_banner.dart';
import 'package:working_calendar/widgets/switch_button.dart';
import 'package:working_calendar/widgets/text_page.dart';

class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    const Color.fromRGBO(0, 50, 205, 0.7),
                    const Color.fromRGBO(150, 10, 10, 0.8),
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
          ),
          title: const Text(
            'Калькулятор дней',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/images/date.jpeg',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
          ),
          trialPeriod()
              ? SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MediaQuery.of(context).size.width < 650
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 20),
                                  child: Column(
                                    children: [
                                      InputDate(),
                                      const SizedBox(height: 10),
                                      InputStudyingTime(),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Column(
                                    children: [
                                      ActionButton(),
                                      SwitchButton(),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.all(20),
                                  child: Column(
                                    children: [
                                      InputDate(),
                                      const SizedBox(height: 10),
                                      InputStudyingTime(),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    ActionButton(),
                                    SwitchButton(),
                                  ],
                                ),
                              ],
                            ),
                      CalendarStartPage(),
                      const SizedBox(height: 20),
                      MediaQuery.of(context).size.width < 650
                          ? Column(
                              children: [
                                TextPage(),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: MemoText(),
                                ),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MemoText(),
                                TextPage(),
                              ],
                            ),
                      const SizedBox(height: 20),
                    ],
                  ),
                )
              : Center(
                  child: Container(
                    color: Colors.red,
                    width: double.infinity,
                    height: 200,
                    child: Center(
                        child: Text(
                      'Пробный период окончен!',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    )),
                  ),
                ),
          WarningBanner(),
        ],
      ),
    );
  }
}

/// Пробный период
bool trialPeriod() {
  DateTime treal = sl.get<Services>().dateTime;
  if ((treal.year == 2021 && treal.day >= 5 && treal.month >= 7) ||
      (treal.year <= 2021 && treal.day <= 27 && treal.month <= 6)) {
    return false;
  } else {
    return true;
  }
  // return true;
}
