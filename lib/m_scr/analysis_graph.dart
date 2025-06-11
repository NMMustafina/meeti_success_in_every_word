import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:meeti_success_in_every_word_201_t/m/color_m.dart';
import 'package:meeti_success_in_every_word_201_t/m/sceen_prov.dart';

class AnalysisGraph extends StatefulWidget {
  final List<Scenrio> scenrios;
  final DateTime selectedMonth;
  final VoidCallback? onPrevMonth;
  final VoidCallback? onNextMonth;
  final bool hasPrev;
  final bool hasNext;

  const AnalysisGraph({
    super.key,
    required this.scenrios,
    required this.selectedMonth,
    this.onPrevMonth,
    this.onNextMonth,
    required this.hasPrev,
    required this.hasNext,
  });

  @override
  State<AnalysisGraph> createState() => _AnalysisGraphState();
}

class _AnalysisGraphState extends State<AnalysisGraph>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _controller.forward();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  double getMaxY(List<FlSpot> spots) {
    if (spots.isEmpty) return 400;
    double max = spots.map((e) => e.y).reduce((a, b) => a > b ? a : b);
    return ((max / 100).ceil() * 100).toDouble().clamp(400, double.infinity);
  }

  double getIntervalY(double maxY) {
    if (maxY <= 400) return 100;
    if (maxY <= 1000) return 200;
    if (maxY <= 3000) return 500;
    if (maxY <= 10000) return 1000;
    return 2000;
  }

  @override
  Widget build(BuildContext context) {
    final filtered =
        widget.scenrios.where((e) => e.assessmentProfit != null).toList();

    final spots = filtered.map((e) {
      final day = e.slectedDate.day.toDouble();
      final profit = double.tryParse(e.assessmentProfit ?? '') ?? 0;
      return FlSpot(day, profit);
    }).toList();

    final bool singlePoint = spots.length == 1;
    final int daysInMonth =
        DateTime(widget.selectedMonth.year, widget.selectedMonth.month + 1, 0)
            .day;
    final double maxY = getMaxY(spots);
    final double intervalY = getIntervalY(maxY);

    List<FlSpot> verticalLines = [];
    for (var spot in spots) {
      verticalLines.add(FlSpot(spot.x, 0));
      verticalLines.add(FlSpot(spot.x, spot.y));
    }

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 8.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: widget.hasPrev ? widget.onPrevMonth : null,
                icon: Icon(
                  Icons.chevron_left,
                  color: widget.hasPrev ? Colors.white : Colors.white38,
                ),
              ),
              Text(
                DateFormat('MMMM yyyy').format(widget.selectedMonth),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              IconButton(
                onPressed: widget.hasNext ? widget.onNextMonth : null,
                icon: Icon(
                  Icons.chevron_right,
                  color: widget.hasNext ? Colors.white : Colors.white38,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SizedBox(
            height: 270.h,
            child: SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              child: Container(
                width: daysInMonth * 20.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF252B30),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: FadeTransition(
                  opacity: _controller,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(12.r, 24.r, 12.r, 12.r),
                    child: LineChart(
                      LineChartData(
                        minX: 1,
                        maxX: daysInMonth.toDouble(),
                        minY: 0,
                        maxY: maxY,
                        gridData: FlGridData(
                          show: true,
                          drawVerticalLine: true,
                          verticalInterval: 1,
                          horizontalInterval: intervalY,
                          getDrawingHorizontalLine: (_) => FlLine(
                            color: Colors.white.withOpacity(0.1),
                            strokeWidth: 1,
                          ),
                          getDrawingVerticalLine: (_) => FlLine(
                            color: Colors.white.withOpacity(0.1),
                            strokeWidth: 1,
                          ),
                        ),
                        titlesData: FlTitlesData(
                          topTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false)),
                          rightTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false)),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 45,
                              getTitlesWidget: (value, meta) => Padding(
                                padding: EdgeInsets.only(bottom: 8.h),
                                child: Text(
                                  '\$${value.toInt()}',
                                  style: TextStyle(
                                    color: Colors.white54,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              interval: 1,
                              getTitlesWidget: (value, _) => Text(
                                value.toInt() >= 1 &&
                                        value.toInt() <= daysInMonth
                                    ? value.toInt().toString().padLeft(2, '0')
                                    : '',
                                style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 10.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                        borderData: FlBorderData(show: false),
                        lineBarsData: spots.isEmpty
                            ? [
                                LineChartBarData(
                                  spots: [],
                                  isCurved: false,
                                  color: Colors.transparent,
                                  barWidth: 0,
                                  dotData: const FlDotData(show: false),
                                  belowBarData: BarAreaData(show: false),
                                )
                              ]
                            : singlePoint
                                ? [
                                    LineChartBarData(
                                      spots: verticalLines,
                                      isCurved: false,
                                      color: ColorM.blue,
                                      barWidth: 2,
                                      dotData: const FlDotData(show: false),
                                      belowBarData: BarAreaData(show: false),
                                    ),
                                  ]
                                : [
                                    LineChartBarData(
                                      spots: spots,
                                      isCurved: false,
                                      color: ColorM.blue,
                                      barWidth: 2,
                                      belowBarData: BarAreaData(
                                        show: true,
                                        gradient: LinearGradient(
                                          colors: [
                                            ColorM.blue.withAlpha(153),
                                            ColorM.blue.withAlpha(26),
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                        ),
                                      ),
                                      dotData: const FlDotData(show: false),
                                    ),
                                  ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
