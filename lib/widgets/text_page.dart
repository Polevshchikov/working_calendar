import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:working_calendar/redux/app_state.dart';

class TextPage extends StatelessWidget {
  const TextPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, vm) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black, spreadRadius: 3, blurRadius: 5),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Дата начала обучения: ${vm.rangeEndDate.day}.${vm.rangeEndDate.month}.${vm.rangeEndDate.year}',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
