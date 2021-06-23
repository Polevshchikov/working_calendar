import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:working_calendar/models/date_entity.dart';
import 'package:flutter/services.dart' show rootBundle;

//сайт запроса http://xmlcalendar.ru/
//http://xmlcalendar.ru/data/ru/2013/calendar.json

class DateProvider {
  Future<DateEntity> loadJsonDate({required int queryYear}) async {
    if (queryYear >= 2015 && queryYear <= 2024) {
      final String date =
          await rootBundle.loadString("assets/files/calendar_$queryYear.json");
      final DateEntity dateEntity =
          DateEntity.fromJson(await json.decode(date));
      return dateEntity;
    } else {
      return DateEntity(
        year: 0,
        months: <Months>[
          Months(month: 0, days: [0])
        ],
      );
    }
  }

  Future<DateEntity> getDate(int queryYear) async {
    final responce = await http.get(
        Uri.parse('http://xmlcalendar.ru/data/ru/$queryYear/calendar.json'));
    if (responce.statusCode == 200) {
      final DateEntity dateEntity =
          DateEntity.fromJson(json.decode(responce.body));

      return dateEntity;
    } else {
      throw Exception('Error loading data');
    }
  }
}
