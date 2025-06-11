import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:meeti_success_in_every_word_201_t/m/color_m.dart';
import 'package:meeti_success_in_every_word_201_t/m/moti_m.dart';
import 'package:meeti_success_in_every_word_201_t/m/sceen_prov.dart';
import 'package:meeti_success_in_every_word_201_t/m_scr/add_edit_scenario.dart';
import 'package:meeti_success_in_every_word_201_t/m_scr/new_profit_assessment.dart';
import 'package:provider/provider.dart';

class Scenario extends StatefulWidget {
  const Scenario({super.key});

  @override
  State<Scenario> createState() => _ScenarioState();
}

class _ScenarioState extends State<Scenario> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _a1();
    });
  }

  void _a1() {
    final a = Provider.of<ScenrioProvaider>(context, listen: false);
    final b = a.scenrios;

    final c = DateTime.now();

    for (final d in b) {
      final e = DateTime(
        d.slectedDate.year,
        d.slectedDate.month,
        d.slectedDate.day,
        d.slectedTime.hour,
        d.slectedTime.minute,
      );

      if (e.isBefore(c) && d.isRated == null) {
        _a2(d);
        break;
      }
    }
  }

  void _a2(Scenrio a) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext b) {
        return Dialog(
          backgroundColor: Color(0xFF252B30),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 16.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'How did your negotiations go?',
                  style: TextStyle(
                    color: ColorM.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10.h),
                Text(
                  '"${a.nme}"',
                  style: TextStyle(
                    color: ColorM.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _a3(
                      icon: 'assets/icons/good.svg',
                      label: 'Great!',
                      onTap: () => _a4(a, true),
                    ),
                    _a3(
                      icon: 'assets/icons/bad.svg',
                      label: 'Badly',
                      onTap: () => _a4(a, false),
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

  Widget _a3({
    required String icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 64.w,
            height: 64.w,
            child: SvgPicture.asset(icon),
          ),
          SizedBox(height: 8.h),
          Text(
            label,
            style: TextStyle(
              color: ColorM.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  void _a4(Scenrio a, bool b) async {
    final c = Provider.of<ScenrioProvaider>(context, listen: false);
    final d = a.cpyWith(isRated: b);

    await c.updteScenrio(d);

    Navigator.of(context).pop();

    Future.microtask(() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => NewProfitAssessment(scenario: d),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: _a9(),
      backgroundColor: ColorM.background,
      appBar: AppBar(
        backgroundColor: ColorM.background,
        elevation: 0,
        title: Text(
          'Negotiation scenario',
          style: TextStyle(
            color: ColorM.white,
            fontWeight: FontWeight.w500,
            fontSize: 28.sp,
            height: 1.sp,
          ),
        ),
      ),
      body: Consumer<ScenrioProvaider>(
        builder: (a, b, c) {
          final d = b.scenrios;

          return SingleChildScrollView(
            child: Column(
              children: [
                d.isEmpty ? _a5() : _a6(d),
                SizedBox(height: 100.h),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _a5() {
    return Padding(
      padding: EdgeInsets.only(top: 200.0.h),
      child: Center(
        child: Text(
          'No scenarios yet',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 18.sp,
          ),
        ),
      ),
    );
  }

  Widget _a6(List<Scenrio> a) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      itemCount: a.length,
      itemBuilder: (b, c) {
        final d = a[c];
        return _a7(d);
      },
    );
  }

  Widget _a7(Scenrio a) {
    final b = DateFormat('dd.MM.yyyy');
    final c = DateFormat('HH:mm');
    final d = b.format(a.slectedDate);
    final e = c.format(a.slectedTime);

    final f = DateTime(
      a.slectedDate.year,
      a.slectedDate.month,
      a.slectedDate.day,
      a.slectedTime.hour,
      a.slectedTime.minute,
    );
    final g = f.isBefore(DateTime.now());

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (b) => AddEditScenario(scenario: a),
          ),
        ).then((_) {
          if (mounted) _a1();
        });
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        decoration: BoxDecoration(
          color: Color(0xFF252B30),
          borderRadius: BorderRadius.circular(12.r),
        ),
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              a.nme,
              style: TextStyle(
                color: ColorM.white,
                fontWeight: FontWeight.w500,
                fontSize: 20.sp,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              a.descrption,
              style: TextStyle(
                color: ColorM.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 8.h),
            Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/gol.svg',
                ),
                SizedBox(width: 4.w),
                Expanded(
                  child: Text(
                    a.evntGoal,
                    style: TextStyle(
                      color: ColorM.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
            if (g && a.isRated != null) ...[
              SizedBox(height: 12.h),
              _a8(a.isRated!),
            ],
            SizedBox(height: 8.h),
            Divider(
              color: Colors.white.withOpacity(0.4),
              height: 1.h,
            ),
            SizedBox(height: 8.h),
            Row(
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/mongol.svg',
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      '\$${a.mnetaryGoal}',
                      style: TextStyle(
                        color: ColorM.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 8.w),
                SizedBox(
                  width: 1.w,
                  height: 24.h,
                  child: VerticalDivider(
                    color: ColorM.white.withOpacity(0.4),
                    thickness: 1.h,
                  ),
                ),
                SizedBox(width: 8.w),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/styl.svg',
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      a.businesStyle,
                      style: TextStyle(color: ColorM.white, fontSize: 14.sp),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Row(
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/dat.svg',
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      d,
                      style: TextStyle(color: ColorM.white, fontSize: 14.sp),
                    ),
                  ],
                ),
                SizedBox(width: 8.w),
                SizedBox(
                  width: 1.w,
                  height: 24.h,
                  child: VerticalDivider(
                    color: ColorM.white.withOpacity(0.4),
                    thickness: 1.h,
                  ),
                ),
                SizedBox(width: 8.w),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/hor.svg',
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      e,
                      style: TextStyle(color: ColorM.white, fontSize: 14.sp),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _a8(bool a) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
      decoration: BoxDecoration(
        color: a
            ? ColorM.blue.withOpacity(0.2)
            : Colors.redAccent.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            a ? Icons.thumb_up : Icons.thumb_down,
            color: a ? ColorM.blue : Colors.redAccent,
            size: 18.sp,
          ),
          SizedBox(width: 8.w),
          Text(
            a ? 'Great!' : 'Badly',
            style: TextStyle(
              color: a ? ColorM.blue : Colors.redAccent,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _a9() {
    return MMotiBut(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (a) => const AddEditScenario(),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: ColorM.blue,
          borderRadius: BorderRadius.circular(12.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Add a scenario',
              style: TextStyle(
                color: ColorM.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 8.w),
            Icon(Icons.add, color: ColorM.white),
          ],
        ),
      ),
    );
  }
}
