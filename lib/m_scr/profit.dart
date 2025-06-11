import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meeti_success_in_every_word_201_t/m/color_m.dart';
import 'package:meeti_success_in_every_word_201_t/m_scr/analysis_tab.dart';
import 'package:meeti_success_in_every_word_201_t/m_scr/assessment_tab.dart';

class Profit extends StatelessWidget {
  const Profit({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: ColorM.background,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Center(
                  child: Text(
                    'Profit',
                    style: TextStyle(
                      color: ColorM.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 28.sp,
                      height: 1.sp,
                    ),
                  ),
                ),
              ),
              Theme(
                data: Theme.of(context).copyWith(
                  tabBarTheme: const TabBarTheme(
                    overlayColor: MaterialStatePropertyAll(Colors.transparent),
                    dividerColor: Colors.transparent,
                  ),
                ),
                child: TabBar(
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(
                      color: ColorM.blue,
                      width: 2.5.h,
                    ),
                    insets: EdgeInsets.symmetric(horizontal: 6.w),
                  ),
                  labelColor: ColorM.blue,
                  unselectedLabelColor: ColorM.white.withOpacity(0.6),
                  labelStyle: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  tabs: const [
                    Tab(text: 'Assessment'),
                    Tab(text: 'Analysis'),
                  ],
                ),
              ),
              SizedBox(height: 6.h),
              Container(
                height: 1,
                width: double.infinity,
                color: Colors.white.withOpacity(0.1),
              ),
              const Expanded(
                child: TabBarView(
                  children: [
                    AssessmentTab(),
                    AnalysisTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
