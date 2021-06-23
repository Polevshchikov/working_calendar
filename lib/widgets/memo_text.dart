import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:working_calendar/redux/app_state.dart';

class MemoText extends StatelessWidget {
  const MemoText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, vm) => Container(
        width: MediaQuery.of(context).size.width < 650
            ? double.infinity
            : MediaQuery.of(context).size.width / 2.6,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Color.fromRGBO(205, 205, 245, 0.7),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                child: ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(4284914175),
                    ),
                    child: Center(
                      child: Text(
                        '${vm.rangeEndDate.day}',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  title: Text('- Начало обучения'),
                ),
              ),
              Container(
                child: ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(4284246976),
                    ),
                    child: Center(
                      child: Text(
                        '${vm.rangeStartDate.day}',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  title: Text('- Конец обучения'),
                ),
              ),
              Container(
                child: ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green[100],
                    ),
                    child: Center(
                      child: Text(
                        '${DateTime.now().day}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  title: Text('- Сегодня'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
