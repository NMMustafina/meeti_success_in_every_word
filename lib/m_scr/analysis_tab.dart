import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meeti_success_in_every_word_201_t/m/color_m.dart';
import 'package:meeti_success_in_every_word_201_t/m/sceen_prov.dart';
import 'package:meeti_success_in_every_word_201_t/m_scr/analysis_graph.dart';
import 'package:meeti_success_in_every_word_201_t/m_scr/analysis_profit_list.dart';
import 'package:meeti_success_in_every_word_201_t/m_scr/analysis_style_tab.dart';
import 'package:provider/provider.dart';

class AnalysisTab extends StatefulWidget {
  const AnalysisTab({super.key});

  @override
  State<AnalysisTab> createState() => _AnalysisTabState();
}

class _AnalysisTabState extends State<AnalysisTab> {
  int selectedIndex = 0;
  int selectedTab = 0;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      final scenrios = context
          .read<ScenrioProvaider>()
          .scenrios
          .where((e) => e.isRated != null)
          .toList()
        ..sort((a, b) => b.slectedDate.compareTo(a.slectedDate));

      final months = generateMonths(scenrios);
      final now = DateTime.now();
      final current = DateTime(now.year, now.month);
      final index = months.indexWhere(
          (m) => m.year == current.year && m.month == current.month);
      if (index != -1) {
        selectedIndex = index;
      }
      _initialized = true;
    }
  }

  List<DateTime> generateMonths(List<Scenrio> scenrios) {
    if (scenrios.isEmpty) return [];
    scenrios.sort((a, b) => a.slectedDate.compareTo(b.slectedDate));

    DateTime first = DateTime(
        scenrios.first.slectedDate.year, scenrios.first.slectedDate.month);
    DateTime last = DateTime(
        scenrios.last.slectedDate.year, scenrios.last.slectedDate.month);

    List<DateTime> result = [];
    DateTime current = first;

    while (!current.isAfter(last)) {
      result.add(current);
      current = DateTime(current.year, current.month + 1);
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final scenrios = context
        .watch<ScenrioProvaider>()
        .scenrios
        .where((e) => e.isRated != null)
        .toList()
      ..sort((a, b) => b.slectedDate.compareTo(a.slectedDate));

    final months = generateMonths(scenrios);
    final selectedMonth =
        months.isNotEmpty ? months[selectedIndex] : DateTime.now();
    final filtered = scenrios
        .where((e) =>
            e.slectedDate.year == selectedMonth.year &&
            e.slectedDate.month == selectedMonth.month)
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => selectedTab = 0),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    decoration: BoxDecoration(
                      color:
                          selectedTab == 0 ? ColorM.blue : Colors.transparent,
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                          color: ColorM.blue.withOpacity(0.5), width: 1),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Profit',
                      style: TextStyle(
                        color: selectedTab == 0 ? Colors.white : ColorM.blue,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => selectedTab = 1),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    decoration: BoxDecoration(
                      color:
                          selectedTab == 1 ? ColorM.blue : Colors.transparent,
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                          color: ColorM.blue.withOpacity(0.5), width: 1),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Style',
                      style: TextStyle(
                        color: selectedTab == 0 ? ColorM.blue : Colors.white,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        if (selectedTab == 0)
          Expanded(
            child: scenrios.isEmpty
                ? Center(
                    child: Text(
                      'You have nothing to analyze yet',
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 16.sp,
                      ),
                    ),
                  )
                : SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        AnalysisGraph(
                          scenrios: filtered,
                          selectedMonth: selectedMonth,
                          onPrevMonth: selectedIndex > 0
                              ? () => setState(() => selectedIndex--)
                              : null,
                          onNextMonth: selectedIndex < months.length - 1
                              ? () => setState(() => selectedIndex++)
                              : null,
                          hasPrev: selectedIndex > 0,
                          hasNext: selectedIndex < months.length - 1,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: AnalysisProfitList(scenrios: filtered),
                        ),
                        SizedBox(height: 16.h),
                      ],
                    ),
                  ),
          )
        else
          Expanded(
            child: AnalysisStyleTab(
              selectedMonth: selectedMonth,
            ),
          ),
      ],
    );
  }
}
