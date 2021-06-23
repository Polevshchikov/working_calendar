import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:working_calendar/redux/actions.dart';
import 'package:working_calendar/redux/app_state.dart';

class InputStudyingTime extends StatelessWidget {
  const InputStudyingTime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Store<AppState> store = StoreProvider.of<AppState>(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Color.fromRGBO(253, 255, 255, 1),
        boxShadow: [
          BoxShadow(color: Colors.black, spreadRadius: 3, blurRadius: 5),
        ],
      ),
      width: 300,
      child: TextField(
        style: TextStyle(fontSize: 20),
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp('[0-9]+')),
        ],
        onChanged: (value) {
          if (value != '') {
            int inputTime = int.parse(value);
            store.dispatch(InputStudyingTimeAction(studyingTime: inputTime));
          } else {
            store.dispatch(InputStudyingTimeAction(studyingTime: 1));
          }
        },
        decoration: InputDecoration(
          hintText: 'Длительность курса',
          hintStyle: TextStyle(color: Colors.black),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(
              color: Colors.blueAccent,
              width: 2.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(
              color: Colors.blue,
              width: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}
