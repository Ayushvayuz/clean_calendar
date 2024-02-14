import 'package:clean_calendar/clean_calendar.dart';
import 'package:clean_calendar/src/state/page_controller.dart';
import 'package:flutter/material.dart';

class CalendarNavigatorHeaderSection extends StatelessWidget {
  Widget? icon1;
  Widget? icon2;
  final dynamic onTapNext;
  final dynamic onTapNext2;
  final dynamic onTapMonthView;
  CalendarNavigatorHeaderSection(
      {Key? key,
      required this.calendarProperties,
      required this.pageControllerState,
      this.icon1,
      this.icon2,
      this.onTapNext,
      this.onTapNext2,
      this.onTapMonthView})
      : super(key: key);

  final CalendarProperties calendarProperties;
  final PageControllerState pageControllerState;
  bool? isIconShow=true;
  List<DateTime> selectedDates = [];
  String selectDate = "";

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: pageControllerState,
      builder: (BuildContext context, Widget? child) {
        final DateTime pageViewDateTime = pageControllerState.pageViewDateTime;
        final List<String> monthsSymbolsList = [];
        calendarProperties.monthsSymbol.toMap().forEach((key, value) {
          monthsSymbolsList.add(value);
        });

        bool shouldShowResetButton = calendarProperties
                    .datePickerCalendarView ==
                DatePickerCalendarView.weekView
            ? DateUtils.dateOnly(calendarProperties.initialViewMonthDateTime) !=
                DateUtils.dateOnly(pageViewDateTime)
            : DateUtils.dateOnly(calendarProperties.initialViewMonthDateTime
                    .copyWith(day: 1)) !=
                DateUtils.dateOnly(pageViewDateTime.copyWith(day: 1));

        Icon navigatorResetButtonIcon = calendarProperties.headerProperties
                .navigatorDecoration?.navigatorResetButtonIcon ??
            const Icon(
              Icons.calendar_today,
            );

        // Widget navigateLeftButtonIcon = calendarProperties
        //         .headerProperties.navigatorDecoration?.navigateLeftButtonIcon ??
        //     const Icon(
        //       Icons.arrow_back_ios,
        //       size: 12,
        //     );

        // Widget navigateRightButtonIcon = calendarProperties.headerProperties
        //         .navigatorDecoration?.navigateRightButtonIcon ??
        //     const Icon(
        //       Icons.arrow_forward_ios,
        //       size: 12,
        //     );

        Color? monthYearTextColor = calendarProperties
            .headerProperties.monthYearDecoration?.monthYearTextColor;

        TextStyle? monthYearTextStyle = calendarProperties
                .headerProperties.monthYearDecoration?.monthYearTextStyle ??
            Theme.of(context).textTheme.titleSmall;

        return Container(
          margin: const EdgeInsets.only(left: 10, right: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(30))),
                              context: context,
                              builder: (context) {
                                return StatefulBuilder(
                                    builder: (BuildContext context, setState) {
                                  return SizedBox(
                                      child: ListView(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: CleanCalendar(
                                          isIconShow: true,
                                          enableDenseViewForDates: true,
                                          enableDenseSplashForDates: true,
                                          datesForStreaks: [
                                            DateTime(2023, 01, 5),
                                            DateTime(2023, 01, 6),
                                            DateTime(2023, 01, 7),
                                            DateTime(2023, 01, 9),
                                            DateTime(2023, 01, 10),
                                            DateTime(2023, 01, 11),
                                            DateTime(2023, 01, 13),
                                            DateTime(2023, 01, 20),
                                            DateTime(2023, 01, 21),
                                            DateTime(2023, 01, 23),
                                            DateTime(2023, 01, 24),
                                            DateTime(2023, 01, 25),
                                          ],
                                          dateSelectionMode:
                                              DatePickerSelectionMode
                                                  .singleOrMultiple,
                                          startWeekday: WeekDay.wednesday,
                                          selectedDates: selectedDates,
                                          onCalendarViewDate:
                                              (DateTime calendarViewDate) {
                                            print(calendarViewDate);
                                          },
                                          onSelectedDates:
                                              (List<DateTime> value) {
                                            setState(() {
                                              if (selectedDates
                                                  .contains(value.first)) {
                                                selectedDates.remove(value.first);
                                               // setState((){
                                                  selectDate = selectedDates.last.day.toString();
                                               // });//
                                              } else {
                                                selectedDates.add(value.first);
                                              }
                                            });
                                            // print(selectedDates);
                                          },
                                        ),
                                      ),
                                    ],
                                  ));
                                });
                              });
                        },
                        child: Container(
                          height: 25,width:25,
                          child: const Icon(
                            Icons.arrow_back_ios,
                            size: 14,
                          ),
                        )),
                    Text(
                      selectDate.isEmpty?"${monthsSymbolsList[pageViewDateTime.month - 1]}${DateTime.now().day}, ${pageViewDateTime.year}":"${monthsSymbolsList[pageViewDateTime.month - 1]}${selectedDates.last.day}, ${pageViewDateTime.year}",
                      overflow: TextOverflow.ellipsis,
                      style: monthYearTextColor != null
                          ? monthYearTextStyle?.copyWith(
                              color: monthYearTextColor)
                          : monthYearTextStyle,
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Row(
                  children: [
                    shouldShowResetButton
                        ? Expanded(
                            child: IconButton(
                              onPressed: () {
                                pageControllerState.pageController
                                    .animateToPage(
                                        pageControllerState.initialIndex,
                                        duration: kTabScrollDuration,
                                        curve: Curves.ease);
                              },
                              padding: EdgeInsets.zero,
                              icon: navigatorResetButtonIcon,
                            ),
                          )
                        : const Expanded(child: SizedBox()),
                    // Expanded(
                    //   child: IconButton(
                    //     onPressed: () {
                    //       pageControllerState.pageController.previousPage(
                    //           duration: kTabScrollDuration, curve: Curves.ease);
                    //     },
                    //     padding: EdgeInsets.zero,
                    //     icon: navigateLeftButtonIcon,
                    //   ),
                    // ),
                    // Expanded(
                    //   child: IconButton(
                    //     onPressed: () {
                    //       pageControllerState.pageController.nextPage(
                    //           duration: kTabScrollDuration, curve: Curves.ease);
                    //     },
                    //     padding: EdgeInsets.zero,
                    //     icon: navigateRightButtonIcon,
                    //   ),
                    // ),
                    isIconShow == true ? Icon(Icons.add) : SizedBox(),
                    isIconShow == true ? Icon(Icons.filter) : SizedBox()
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
