import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:meeti_success_in_every_word_201_t/m/sceen_prov.dart';
import 'package:provider/provider.dart';

class AnalysisStyleTab extends StatelessWidget {
  final DateTime selectedMonth;

  const AnalysisStyleTab({
    super.key,
    required this.selectedMonth,
  });

  @override
  Widget build(BuildContext context) {
    final scenrios = context
        .watch<ScenrioProvaider>()
        .scenrios
        .where((e) =>
            e.businesStyle != null &&
            e.slectedDate.year == selectedMonth.year &&
            e.slectedDate.month == selectedMonth.month)
        .toList()
      ..sort((a, b) => b.slectedDate.compareTo(a.slectedDate));

    final styleCounts = {
      'Friendly': 0,
      'Neutral': 0,
      'Aggressive': 0,
    };

    for (var s in scenrios) {
      final style = (s.businesStyle ?? '').replaceAll(' style', '');
      if (styleCounts.containsKey(style)) {
        styleCounts[style] = styleCounts[style]! + 1;
      }
    }

    final totalStyles = styleCounts.values.fold(0, (a, b) => a + b);
    final pieSections = [
      if (styleCounts['Friendly']! > 0)
        PieChartSectionData(
          value: styleCounts['Friendly']!.toDouble(),
          color: Colors.green,
          radius: 40.r,
          title: '${styleCounts['Friendly']}',
          titleStyle: TextStyle(color: Colors.white, fontSize: 14.sp),
        ),
      if (styleCounts['Neutral']! > 0)
        PieChartSectionData(
          value: styleCounts['Neutral']!.toDouble(),
          color: Colors.yellow,
          radius: 40.r,
          title: '${styleCounts['Neutral']}',
          titleStyle: TextStyle(color: Colors.black, fontSize: 14.sp),
        ),
      if (styleCounts['Aggressive']! > 0)
        PieChartSectionData(
          value: styleCounts['Aggressive']!.toDouble(),
          color: Colors.red,
          radius: 40.r,
          title: '${styleCounts['Aggressive']}',
          titleStyle: TextStyle(color: Colors.white, fontSize: 14.sp),
        ),
    ];

    if (totalStyles == 0) {
      return SizedBox.expand(
        child: Center(
          child: Text(
            'No style data for this month',
            style: TextStyle(
              color: Colors.white54,
              fontSize: 16.sp,
            ),
          ),
        ),
      );
    }

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: const Color(0xFF252B30),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 160.h,
                  child: PieChart(
                    PieChartData(
                      sections: pieSections,
                      centerSpaceRadius: 30.r,
                      sectionsSpace: 4,
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _legendItem(color: Colors.green, label: 'Friendly'),
                    _legendItem(color: Colors.yellow, label: 'Neutral'),
                    _legendItem(color: Colors.red, label: 'Aggressive'),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          ...scenrios.map((s) {
            final date = DateFormat('MMMM dd, yyyy').format(s.slectedDate);
            final styleName = s.businesStyle ?? 'Unknown';
            return Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    date,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12.sp,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFF252B30),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          styleName,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                          ),
                        ),
                        Text(
                          '+1',
                          style: TextStyle(
                            color: _getStyleColor(styleName),
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Color _getStyleColor(String styleName) {
    final style = styleName.toLowerCase();
    if (style.contains('aggressive')) return Colors.red;
    if (style.contains('neutral')) return Colors.yellow;
    return Colors.green;
  }

  Widget _legendItem({required Color color, required String label}) {
    return Row(
      children: [
        Container(
          width: 10.w,
          height: 10.w,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 6.w),
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }
}
