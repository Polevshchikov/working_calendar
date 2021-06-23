import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:working_calendar/locator_service.dart';
import 'package:working_calendar/models/date_entity.dart';
import 'package:working_calendar/redux/actions.dart';
import 'package:working_calendar/redux/app_state.dart';
import 'package:working_calendar/utils/constant.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Store<AppState> store = StoreProvider.of<AppState>(context);
    return Center(
      child: StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, vm) => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 60,
              width: 110,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    bottomLeft: Radius.circular(10.0)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.green, spreadRadius: 3, blurRadius: 8),
                ],
                color: Colors.white60,
              ),
              child: TextButton(
                  onPressed: () async {
                    DateEntity dateEntity = await sl
                        .get<Services>()
                        .dateRepository
                        .getloadJsonDate(vm.rangeStartDate.year);

                    store.dispatch(GenerateEndDateAction(
                      dateEntity: dateEntity,
                      isSwitchedOn: vm.isSwitchedOn,
                      studyingTime: vm.studyingTime,
                      selectedDay: vm.rangeStartDate.day,
                      selectedMonth: listMonths[vm.rangeStartDate.month - 1],
                      selectedYear: vm.rangeStartDate.year.toString(),
                    ));
                  },
                  child: Text(
                    'Рассчитать',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  )),
            ),
            SizedBox(
              width: 6,
            ),
            Container(
              height: 60,
              width: 110,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25.0),
                    bottomRight: Radius.circular(10.0)),
                boxShadow: [
                  BoxShadow(color: Colors.red, spreadRadius: 2, blurRadius: 8),
                ],
                color: Colors.white60,
              ),
              child: TextButton(
                  onPressed: () {
                    store.dispatch(ResetDayAction());
                  },
                  child: Text(
                    'Сбросить',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
