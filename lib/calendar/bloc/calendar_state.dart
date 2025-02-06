part of 'calendar_bloc.dart';

@immutable
sealed class CalendarState {}

final class CalendarInitial extends CalendarState {}

final class CalendarLoading extends CalendarState {}

final class CalendarLoaded extends CalendarState {
  final List<HolidayDate> holidays;
  final DateTime selectedDay;
  final DateTime focusedDay;

  CalendarLoaded(this.holidays, this.selectedDay, this.focusedDay);
}

final class CalendarError extends CalendarState {
  final String message;

  CalendarError(this.message);
}
