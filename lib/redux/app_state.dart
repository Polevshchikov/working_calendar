class AppState {
  final DateTime rangeStartDate;
  final DateTime rangeEndDate;
  final int studyingTime;
  final bool isSwitchedOn;
  final bool warningBannerOn;

  AppState({
    required this.warningBannerOn,
    required this.studyingTime,
    required this.isSwitchedOn,
    required this.rangeStartDate,
    required this.rangeEndDate,
  });
}
