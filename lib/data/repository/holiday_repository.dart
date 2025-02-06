import '../model/model.dart';
import '../provider/holiday_provider.dart';

abstract class IHolidayRepository {
  Future<List<HolidayDate>> getHolidays();
}

class HolidayRepository implements IHolidayRepository {
  final HolidayProvider _holidayProvider;

  HolidayRepository(this._holidayProvider);

  @override
  Future<List<HolidayDate>> getHolidays() async {
    return _holidayProvider.getHolidays();
  }
}
