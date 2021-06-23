import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:redux/redux.dart';
import 'package:working_calendar/locator_service.dart';
import 'package:working_calendar/redux/actions.dart';
import 'package:working_calendar/redux/app_state.dart';
import 'package:working_calendar/redux/reducers.dart';

import 'pages/start_page.dart';

void main() async {
  sl.registerSingletonAsync<Services>(() async {
    final _services = Services();
    _services.init();
    return _services;
  });
  final store = Store<AppState>(appReducers,
      initialState: AppState(
        rangeStartDate: DateTime.now(),
        rangeEndDate: DateTime.now(),
        isSwitchedOn: false,
        studyingTime: 1,
        warningBannerOn: false,
      ));
  initializeDateFormatting().then((_) => runApp(
        StoreProvider(
          store: store,
          child: MyApp(),
        ),
      ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Store<AppState> store = StoreProvider.of<AppState>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StoreConnector<AppState, AppState>(
          converter: (store) => store.state,
          builder: (context, vm) {
            if ((vm.rangeEndDate.year <= 2014 &&
                    vm.rangeEndDate.month <= 12 &&
                    vm.rangeEndDate.day <= 15) ||
                vm.rangeStartDate.year >= 2024) {
              store.dispatch(WarningBannerOnAction());
            }
            return StartPage();
          }),
    );
  }
}
