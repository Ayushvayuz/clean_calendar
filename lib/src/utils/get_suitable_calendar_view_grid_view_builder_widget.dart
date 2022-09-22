import 'package:clean_calendar/src/state/properties_state.dart';
import 'package:clean_calendar/src/ui/calendar_view.dart';
import 'package:flutter/material.dart';

class GetSuitableCalendarViewGridViewBuilderWidget extends StatelessWidget {
  const GetSuitableCalendarViewGridViewBuilderWidget({
    Key? key,
    required this.pageViewDate,
    required this.startWeekday,
    required this.datePickerCalendarView,
  }) : super(key: key);

  final DateTime pageViewDate;
  final int startWeekday;
  final DatePickerCalendarView datePickerCalendarView;

  @override
  Widget build(BuildContext context) {
    if (datePickerCalendarView == DatePickerCalendarView.monthView) {
      return MonthViewCalendarDatesSection(
        pageViewDate: pageViewDate,
        startWeekday: startWeekday,
      );
    }
    if (datePickerCalendarView == DatePickerCalendarView.weekView) {
      return WeekViewCalendarDatesSection(
        pageViewDate: pageViewDate,
        startWeekday: startWeekday,
      );
    }
    // if (dateSelectionMode == DatePickerSelectionMode.range) {
    //   return DateRangeSelectionGridViewBuilder(
    //     pageViewMonthDate: pageViewMonthDate,
    //     pageViewElementsDates: pageViewElementsDates,
    //   );
    // }
    else {
      return const SizedBox();
    }
  }
}
