import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:working_calendar/redux/actions.dart';
import 'package:working_calendar/redux/app_state.dart';

class WarningBanner extends StatelessWidget {
  const WarningBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Store<AppState> store = StoreProvider.of<AppState>(context);
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, vm) => vm.warningBannerOn
          ? Center(
              child: Container(
                color: Colors.redAccent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      width: 350,
                      child: Text(
                        ' Расчетный период начинается с 2015 года и по ${DateTime.now().year}. Остальные даты могут некорректно произвести расчет, т.к. рабочего официального календаря на следующие года нет, а минимальный год внесен 2015. (Для расширения границ периода, обратитесь к разработчику)',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        store.dispatch(ResetDayAction());
                        store.dispatch(WarningBannerOffAction());
                      },
                      child: Text(
                        'Понятно!',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Container(),
    );
  }
}
