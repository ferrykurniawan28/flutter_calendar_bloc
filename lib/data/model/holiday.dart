class HolidayDate {
  String holidayDate;
  String holidayName;
  bool isNationalHoliday;

  HolidayDate({
    required this.holidayDate,
    required this.holidayName,
    required this.isNationalHoliday,
  });

  static HolidayDate fromJson(holiday) {
    String holidayDate = holiday['holiday_date'];
    return HolidayDate(
      holidayDate: _formatDate(holidayDate),
      holidayName: holiday['holiday_name'],
      isNationalHoliday: holiday['is_national_holiday'],
    );
  }

  static String _formatDate(String date) {
    List<String> parts = date.split('-');
    String year = parts[0];
    String month = parts[1].padLeft(2, '0');
    String day = parts[2].padLeft(2, '0');
    return '$year-$month-$day';
  }
}
