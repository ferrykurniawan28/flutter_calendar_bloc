import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../data/data.dart';

part 'calendar_event.dart';
part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  final HolidayRepository _holidayRepository;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  CalendarBloc(this._holidayRepository) : super(CalendarInitial()) {
    on<CalendarFetch>(_onFetchCalendar);
    on<CalendarRefresh>(_onRefreshCalendar);
    on<CalendarSelect>(_onSelectCalendar);
    on<CalendarLoadHolidays>(_onLoadHolidays);
  }

  Future<void> _onFetchCalendar(
    CalendarFetch event,
    Emitter<CalendarState> emit,
  ) async {
    emit(CalendarLoading());
    try {
      final holidays = await _holidayRepository.getHolidays();
      emit(CalendarLoaded(holidays, _selectedDay, _focusedDay));
    } catch (e) {
      emit(CalendarError(e.toString()));
    }
  }

  Future<void> _onRefreshCalendar(
    CalendarRefresh event,
    Emitter<CalendarState> emit,
  ) async {
    emit(CalendarLoading());
    try {
      final holidays = await _holidayRepository.getHolidays();
      emit(CalendarLoaded(holidays, _selectedDay, _focusedDay));
    } catch (e) {
      emit(CalendarError(e.toString()));
    }
  }

  void _onSelectCalendar(
    CalendarSelect event,
    Emitter<CalendarState> emit,
  ) {
    _selectedDay = event.selectedDay;
    _focusedDay = event.focusedDay;

    if (state is CalendarLoaded) {
      final currentState = state as CalendarLoaded;
      emit(CalendarLoaded(currentState.holidays, _selectedDay, _focusedDay));
    }
  }

  void _onLoadHolidays(
    CalendarLoadHolidays event,
    Emitter<CalendarState> emit,
  ) {
    emit(CalendarLoaded(event.holidays, _selectedDay, _focusedDay));
  }
}
