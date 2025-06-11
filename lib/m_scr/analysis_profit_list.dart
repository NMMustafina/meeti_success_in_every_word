import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:meeti_success_in_every_word_201_t/m/color_m.dart';
import 'package:meeti_success_in_every_word_201_t/m/sceen_prov.dart';

class AnalysisProfitList extends StatelessWidget {
  final List<Scenrio> scenrios;

  const AnalysisProfitList({
    super.key,
    required this.scenrios,
  });

  @override
  Widget build(BuildContext context) {
    final validScenrios = scenrios.where((e) {
      final value = double.tryParse(e.assessmentProfit ?? '') ?? 0;
      return value > 0;
    }).toList()
      ..sort((a, b) => b.slectedDate.compareTo(a.slectedDate));

    final total = validScenrios.fold<double>(
      0,
      (sum, e) => sum + (double.tryParse(e.assessmentProfit ?? '0') ?? 0),
    );

    final showEmptyText = validScenrios.isEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 12.h, bottom: 12.h),
          child: Center(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Total: ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextSpan(
                    text: '\$${total.toStringAsFixed(0)}',
                    style: TextStyle(
                      color: ColorM.blue,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (showEmptyText)
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
            child: Center(
              child: Text(
                'You have nothing to analyze yet',
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 16.sp,
                ),
              ),
            ),
          )
        else
          ListView.builder(
            itemCount: validScenrios.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final scenrio = validScenrios[index];
              final dateFormatted =
                  DateFormat('MMMM dd, yyyy').format(scenrio.slectedDate);
              final expected = scenrio.mnetaryGoal;
              final finalProfit = scenrio.assessmentProfit ?? '0';

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    child: Text(
                      dateFormatted,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 8.h),
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFF252B30),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Expected profit',
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 12.sp,
                              ),
                            ),
                            Text(
                              '\$$expected',
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          child: const Divider(
                            color: Colors.white24,
                            thickness: 1,
                            height: 1,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Final profit',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                              ),
                            ),
                            Text(
                              '\$$finalProfit',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
      ],
    );
  }
}
