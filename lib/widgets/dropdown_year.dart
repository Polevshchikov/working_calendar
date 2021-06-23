import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:working_calendar/locator_service.dart';
import 'package:working_calendar/models/date_entity.dart';
import 'package:working_calendar/redux/actions.dart';
import 'package:working_calendar/redux/app_state.dart';
import 'package:working_calendar/utils/constant.dart';

class DropdownYear extends StatelessWidget {
  const DropdownYear({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Store<AppState> store = StoreProvider.of<AppState>(context);
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, vm) => DropdownButton(
          style: TextStyle(fontSize: 20, color: Colors.black),
          iconSize: 40,
          dropdownColor: Color(0xFF2accFa),
          value: vm.rangeStartDate.year.toString(),
          items: listYearsAsString
              .map(
                (String value) => DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                ),
              )
              .toList(),
          menuMaxHeight: 200,
          onChanged: (String? newValue) async {
            int valueInt = int.parse(newValue!);
            store.dispatch(RecordDateYearAction(newDateYear: valueInt));
            DateTime newDate = DateTime.utc(
                valueInt, vm.rangeStartDate.month, vm.rangeStartDate.day);

            DateEntity dateEntity = await sl
                .get<Services>()
                .dateRepository
                .getloadJsonDate(valueInt);

            store.dispatch(GenerateEndDateAction(
              dateEntity: dateEntity,
              isSwitchedOn: vm.isSwitchedOn,
              studyingTime: vm.studyingTime,
              selectedDay: newDate.day,
              selectedMonth: listMonths[newDate.month - 1],
              selectedYear: newDate.year.toString(),
            ));
          }),
    );
  }
}
