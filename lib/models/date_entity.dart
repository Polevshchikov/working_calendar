class DateEntity {
  late final int year;
  late final List<Months> months;

  DateEntity({required this.year, required this.months});

  DateEntity.fromJson(Map<String, dynamic> json) {
    year = json['year'];
    if (json['months'] != null) {
      months = <Months>[];
      json['months'].forEach((v) {
        months.add(new Months.fromJson(v));
      });
    }
  }
}

class Months {
  late final int month;
  late final List<int> days;

  Months({required this.month, required this.days});

  Months.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    days = json['days'].cast<int>();
  }
}
