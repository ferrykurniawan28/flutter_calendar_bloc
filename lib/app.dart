import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'calendar/calendart.dart';
import 'data/data.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Holiday Calendar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RepositoryProvider(
        create: (context) => HolidayRepository(HolidayProvider()),
        child: BlocProvider(
          create: (context) => CalendarBloc(
            RepositoryProvider.of<HolidayRepository>(context),
          )..add(CalendarFetch()),
          child: const CalendarPage(),
        ),
      ),
    );
  }
}
