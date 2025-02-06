import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

import '../calendart.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
      ),
      body: BlocBuilder<CalendarBloc, CalendarState>(
        builder: (context, state) {
          switch (state) {
            case CalendarLoading():
              return const Center(child: CircularProgressIndicator());
            case CalendarError():
              return Center(child: Text('Error: ${state.message}'));
            case CalendarLoaded():
              return Column(
                children: [
                  TableCalendar(
                    firstDay: DateTime(DateTime.now().year - 1),
                    lastDay: DateTime(DateTime.now().year + 1),
                    focusedDay: state.focusedDay,
                    selectedDayPredicate: (day) =>
                        isSameDay(state.selectedDay, day),
                    onDaySelected: (selectedDay, focusedDay) {
                      context
                          .read<CalendarBloc>()
                          .add(CalendarSelect(selectedDay, focusedDay));
                    },
                    eventLoader: (day) {
                      return state.holidays
                          .where((holiday) => isSameDay(
                              DateTime.parse(holiday.holidayDate), day))
                          .map((holiday) => holiday.holidayName)
                          .toList();
                    },
                    calendarStyle: const CalendarStyle(
                      markerDecoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView(
                      children: state.holidays
                          .where((holiday) => isSameDay(
                              DateTime.parse(holiday.holidayDate),
                              state.selectedDay))
                          .map((holiday) => ListTile(
                                title: Text(holiday.holidayName),
                                subtitle: Text(
                                  holiday.isNationalHoliday
                                      ? 'National Holiday'
                                      : 'Local Holiday',
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                ],
              );
            default:
              return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
