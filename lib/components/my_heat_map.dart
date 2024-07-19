import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class MyHeatMap extends StatelessWidget {
  final Map<DateTime, int> datasets;
  final DateTime startDate;

  const MyHeatMap({super.key, required this.startDate, required this.datasets});

  @override
  Widget build(BuildContext context) {
    // final DateTime now = DateTime.now();
    // final DateTime firstDateOfMonth = DateTime(now.year, now.month, 1);
    // final DateTime firstDayOfNextMonth = (now.month < 12)
    //     ? DateTime(now.year, now.month + 1, 1)
    //     : DateTime(now.year + 1, 1, 1);
    // final DateTime lastDayOfCurrentMonth =
    //     firstDayOfNextMonth.subtract(const Duration(days: 1));

    return HeatMapCalendar(
      // startDate: firstDateOfMonth,
      // endDate: lastDayOfCurrentMonth,
      datasets: datasets,
      colorMode: ColorMode.color,
      defaultColor: Theme.of(context).colorScheme.secondary,
      textColor: Theme.of(context).colorScheme.inversePrimary,
      showColorTip: false,
      // showText: true,
      // scrollable: true,
      size: 40,
      colorsets: {
        1: Colors.green.shade200,
        2: Colors.green.shade300,
        3: Colors.green.shade400,
        4: Colors.green.shade500,
        5: Colors.green.shade600,
      },
    );
  }
}
