part of 'calendar_bloc.dart';

@immutable
sealed class CalendarEvent {}

final class CalendarFetch extends CalendarEvent {}

final class CalendarRefresh extends CalendarEvent {}

final class CalendarSelect extends CalendarEvent {
  final DateTime selectedDay;
  final DateTime focusedDay;

  CalendarSelect(this.selectedDay, this.focusedDay);
}

final class CalendarLoadHolidays extends CalendarEvent {
  final List<HolidayDate> holidays;

  CalendarLoadHolidays(this.holidays);
}
