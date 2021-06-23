import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:working_calendar/locator_service.dart';
import 'package:working_calendar/models/date_entity.dart';
import 'package:working_calendar/redux/actions.dart';
import 'package:working_calendar/redux/app_state.dart';
import 'package:working_calendar/utils/constant.dart';
import 'package:working_calendar/utils/utils.dart';

class CalendarStartPage extends StatelessWidget {
  const CalendarStartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Store<AppState> store = StoreProvider.of<AppState>(context);
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      child: Card(
        elevation: 10,
        child: StoreConnector<AppState, AppState>(
          converter: (store) => store.state,
          builder: (context, vm) => TableCalendar(
            headerStyle: HeaderStyle(
                titleCentered: true, titleTextStyle: TextStyle(fontSize: 20)),
            availableCalendarFormats: {CalendarFormat.month: 'Month'},
            daysOfWeekHeight: 60,
            daysOfWeekStyle: DaysOfWeekStyle(
              decoration: BoxDecoration(color: Colors.black87),
              weekendStyle: TextStyle(color: Colors.red, fontSize: 20),
              weekdayStyle: TextStyle(color: Colors.blue, fontSize: 20),
            ),
            calendarStyle: CalendarStyle(
              outsideTextStyle: TextStyle(color: Colors.grey, fontSize: 20),
              defaultTextStyle: TextStyle(color: Colors.black, fontSize: 20),

              rangeHighlightColor: Colors.greenAccent, //!
              todayTextStyle: TextStyle(color: Colors.black, fontSize: 20),
              todayDecoration: BoxDecoration(
                color: Colors.green[100],
                shape: BoxShape.circle,
              ),
              weekendTextStyle: TextStyle(
                  color: Colors.red, fontWeight: FontWeight.w600, fontSize: 20),
            ),
            startingDayOfWeek: StartingDayOfWeek.monday,
            locale: 'ru_RU',
            firstDay: kFirstDay,
            lastDay: kLastDay,
            focusedDay: vm.rangeStartDate,
            selectedDayPredicate: (day) => isSameDay(vm.rangeStartDate, day),
            rangeStartDay: vm.rangeEndDate,
            rangeEndDay: vm.rangeStartDate,
            onDaySelected: (selectedDay, focusedDay) async {
              DateEntity dateEntity = await sl
                  .get<Services>()
                  .dateRepository
                  .getloadJsonDate(selectedDay.year);

              store.dispatch(SelectedNewDate(newDateTime: selectedDay));

              store.dispatch(GenerateEndDateAction(
                dateEntity: dateEntity,
                isSwitchedOn: vm.isSwitchedOn,
                studyingTime: vm.studyingTime,
                selectedDay: selectedDay.day,
                selectedMonth: listMonths[selectedDay.month - 1],
                selectedYear: selectedDay.year.toString(),
              ));
            },
          ),
        ),
      ),
    );
  }
}
