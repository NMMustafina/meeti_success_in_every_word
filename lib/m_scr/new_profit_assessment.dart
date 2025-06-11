import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meeti_success_in_every_word_201_t/m/color_m.dart';
import 'package:meeti_success_in_every_word_201_t/m/sceen_prov.dart';
import 'package:provider/provider.dart';

class NewProfitAssessment extends StatefulWidget {
  final Scenrio scenario;

  const NewProfitAssessment({super.key, required this.scenario});

  @override
  State<NewProfitAssessment> createState() => _NewProfitAssessmentState();
}

class _NewProfitAssessmentState extends State<NewProfitAssessment> {
  final impressionsController = TextEditingController();
  final profitController = TextEditingController();

  bool get isValid => impressionsController.text.trim().isNotEmpty;

  void onSave() async {
    final updated = widget.scenario.cpyWith(
      isRated: widget.scenario.isRated,
      assessmentText: impressionsController.text.trim(),
      assessmentProfit: profitController.text.trim().isEmpty
          ? null
          : profitController.text.trim(),
    );

    final prov = Provider.of<ScenrioProvaider>(context, listen: false);
    await prov.updteScenrio(updated);

    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    impressionsController.dispose();
    profitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scenario = widget.scenario;

    return Scaffold(
      backgroundColor: ColorM.background,
      appBar: AppBar(
        backgroundColor: ColorM.background,
        elevation: 0,
        iconTheme: const IconThemeData(color: ColorM.white),
        title: Text(
          'New profit assessment',
          style: TextStyle(
            color: ColorM.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF252B30),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  scenario.nme,
                  style: TextStyle(
                    color: ColorM.white,
                    fontSize: 16.sp,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              TextField(
                controller: impressionsController,
                onChanged: (_) => setState(() {}),
                style: TextStyle(color: ColorM.white, fontSize: 16.sp),
                maxLines: null,
                decoration: InputDecoration(
                  hintText: 'Impressions',
                  hintStyle: TextStyle(color: ColorM.white.withOpacity(0.5)),
                  filled: true,
                  fillColor: const Color(0xFF252B30),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              TextField(
                controller: profitController,
                onChanged: (_) => setState(() {}),
                keyboardType: TextInputType.number,
                style: TextStyle(color: ColorM.white, fontSize: 16.sp),
                decoration: InputDecoration(
                  prefixText:
                      profitController.text.trim().isNotEmpty ? '\$ ' : null,
                  prefixStyle: TextStyle(color: ColorM.white, fontSize: 16.sp),
                  hintText: 'Profit',
                  hintStyle: TextStyle(color: ColorM.white.withOpacity(0.5)),
                  filled: true,
                  fillColor: const Color(0xFF252B30),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isValid ? onSave : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorM.blue,
                    disabledBackgroundColor: ColorM.blue.withOpacity(0.5),
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Save',
                    style: TextStyle(
                      color: ColorM.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
