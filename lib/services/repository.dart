import 'package:working_calendar/models/date_entity.dart';

import 'api_provider.dart';

class DateRepository {
  DateProvider _dateProvider = DateProvider();

  Future<DateEntity> getloadJsonDate(int queryYear) =>
      _dateProvider.loadJsonDate(queryYear: queryYear);

  Future<DateEntity> getAllDate(int queryYear) =>
      _dateProvider.getDate(queryYear);
}
