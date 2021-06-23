import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:working_calendar/locator_service.dart';
import 'package:working_calendar/models/date_entity.dart';
import 'package:working_calendar/redux/actions.dart';
import 'package:working_calendar/redux/app_state.dart';
import 'package:working_calendar/utils/constant.dart';
import 'package:working_calendar/widgets/dropdown_month.dart';
import 'package:working_calendar/widgets/dropdown_year.dart';

class InputDate extends StatelessWidget {
  const InputDate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Store<AppState> store = StoreProvider.of<AppState>(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Color.fromRGBO(210, 230, 250, 1),
        boxShadow: [
          BoxShadow(color: Colors.black, spreadRadius: 3, blurRadius: 5),
        ],
      ),
      child: StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, vm) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 40,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '${vm.rangeStartDate.day}',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                          child: Icon(
                            Icons.arrow_drop_up,
                            size: 40,
                          ),
                          onTap: () async {
                            if (vm.rangeStartDate.year <= 2023 &&
                                vm.rangeStartDate.month <= 12 &&
                                vm.rangeStartDate.day < 31) {
                              DateTime addVariable =
                                  vm.rangeStartDate.add(Duration(days: 1));

                              DateEntity dateEntity = await sl
                                  .get<Services>()
                                  .dateRepository
                                  .getloadJsonDate(addVariable.year);

                              store.dispatch(GenerateEndDateAction(
                                dateEntity: dateEntity,
                                isSwitchedOn: vm.isSwitchedOn,
                                studyingTime: vm.studyingTime,
                                selectedDay: addVariable.day,
                                selectedMonth:
                                    listMonths[addVariable.month - 1],
                                selectedYear: addVariable.year.toString(),
                              ));
                              store.dispatch(AddDayAction());
                            }
                          }),
                      GestureDetector(
                          child: Icon(
                            Icons.arrow_drop_down,
                            size: 40,
                          ),
                          onTap: () async {
                            if (vm.rangeStartDate.year >= 2015 &&
                                vm.rangeStartDate.month >= 1 &&
                                vm.rangeStartDate.day > 1) {
                              DateTime subVariable =
                                  vm.rangeStartDate.subtract(Duration(days: 1));

                              DateEntity dateEntity = await sl
                                  .get<Services>()
                                  .dateRepository
                                  .getloadJsonDate(subVariable.year);

                              store.dispatch(GenerateEndDateAction(
                                dateEntity: dateEntity,
                                isSwitchedOn: vm.isSwitchedOn,
                                studyingTime: vm.studyingTime,
                                selectedDay: subVariable.day,
                                selectedMonth:
                                    listMonths[subVariable.month - 1],
                                selectedYear: subVariable.year.toString(),
                              ));
                              store.dispatch(RemoveDayAction());
                            }
                          }),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: DropdownMonth(),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: DropdownYear(),
            ),
          ],
        ),
      ),
    );
  }
}
