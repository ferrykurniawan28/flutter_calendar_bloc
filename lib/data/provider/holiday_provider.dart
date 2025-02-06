import 'dart:convert';

import '../model/model.dart';
import 'package:http/http.dart' as http;

class HolidayProvider {
  final String _holidayUrl = 'https://api-harilibur.vercel.app/api';

  Future<List<HolidayDate>> getHolidays() async {
    try {
      final response = await http.get(Uri.parse(_holidayUrl));
      if (response.statusCode == 200) {
        final List<dynamic> holidays = json.decode(response.body);
        return holidays
            .map((holiday) => HolidayDate.fromJson(holiday))
            .toList();
      } else {
        throw Exception('Failed to load holidays');
      }
    } on Exception catch (e) {
      throw Exception('Failed to load holidays: $e');
    }
  }
}
