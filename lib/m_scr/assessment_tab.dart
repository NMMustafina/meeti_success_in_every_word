import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:meeti_success_in_every_word_201_t/m/color_m.dart';
import 'package:meeti_success_in_every_word_201_t/m/sceen_prov.dart';
import 'package:meeti_success_in_every_word_201_t/m_scr/edit_profit_assessment.dart';
import 'package:provider/provider.dart';

class AssessmentTab extends StatelessWidget {
  const AssessmentTab({super.key});

  @override
  Widget build(BuildContext context) {
    final scenrios = context.watch<ScenrioProvaider>().scenrios;
    final filtered = scenrios.where((e) => e.isRated != null).toList()
      ..sort((a, b) => b.slectedDate.compareTo(a.slectedDate));

    if (filtered.isEmpty) {
      return Center(
        child: Text(
          'No assessments yet',
          style: TextStyle(color: ColorM.white, fontSize: 16.sp),
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(16.r),
      itemCount: filtered.length,
      itemBuilder: (_, i) {
        final item = filtered[i];

        return GestureDetector(
          onTap: () async {
            final result = await Navigator.push<Map<String, dynamic>>(
              context,
              MaterialPageRoute(
                builder: (_) => EditProfitAssessment(
                  name: item.nme,
                  currentRating: item.isRated,
                  initialImpressions: item.assessmentText,
                  initialProfit: item.assessmentProfit,
                ),
              ),
            );

            if (result != null) {
              final prov =
                  Provider.of<ScenrioProvaider>(context, listen: false);

              if (result['delete'] == true) {
                final prov =
                    Provider.of<ScenrioProvaider>(context, listen: false);
                final cleared = item.cpyWith(
                  isRated: null,
                  assessmentText: null,
                  assessmentProfit: null,
                );
                await prov.updteScenrio(cleared);
              } else {
                final updated = item.cpyWith(
                  isRated: result['rating'],
                  assessmentText: result['impressions'],
                  assessmentProfit: result['profit'],
                );
                await prov.updteScenrio(updated);
              }
            }
          },
          child: Container(
            margin: EdgeInsets.only(bottom: 16.h),
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: const Color(0xFF252B30),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.nme,
                  style: TextStyle(
                    color: ColorM.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  item.assessmentText ?? '',
                  style: TextStyle(
                    color: ColorM.white,
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 12.h),
                Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.white.withOpacity(0.1),
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    if (item.assessmentProfit != null) ...[
                      SvgPicture.asset(
                        'assets/icons/mongol.svg',
                        width: 18.w,
                        height: 18.w,
                        color: ColorM.blue,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        '\$${item.assessmentProfit}',
                        style: TextStyle(
                          color: ColorM.white,
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      _verticalDivider(),
                      SizedBox(width: 12.w),
                    ],
                    SvgPicture.asset(
                      'assets/icons/dat.svg',
                      width: 16.w,
                      height: 16.w,
                      color: ColorM.blue,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      DateFormat('dd.MM.yyyy').format(item.slectedDate),
                      style: TextStyle(color: ColorM.white, fontSize: 14.sp),
                    ),
                    SizedBox(width: 12.w),
                    _verticalDivider(),
                    SizedBox(width: 12.w),
                    SvgPicture.asset(
                      item.isRated == true
                          ? 'assets/icons/thumb-up.svg'
                          : 'assets/icons/thumb-down.svg',
                      width: 18.w,
                      height: 18.w,
                      color: ColorM.blue,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      item.isRated == true ? 'Great' : 'Badly',
                      style: TextStyle(
                        color: ColorM.white,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget _verticalDivider() {
  return Container(
    width: 1,
    height: 16.h,
    color: Colors.white.withOpacity(0.2),
  );
}
