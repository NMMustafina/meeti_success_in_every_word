import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meeti_success_in_every_word_201_t/m/color_m.dart';

class EditProfitAssessment extends StatefulWidget {
  final String name;
  final String? initialImpressions;
  final String? initialProfit;
  final bool? currentRating;

  const EditProfitAssessment({
    super.key,
    required this.name,
    this.initialImpressions,
    this.initialProfit,
    this.currentRating,
  });

  @override
  State<EditProfitAssessment> createState() => _EditProfitAssessmentState();
}

class _EditProfitAssessmentState extends State<EditProfitAssessment> {
  bool? selectedRating;
  final impressionsController = TextEditingController();
  final profitController = TextEditingController();
  bool hasChanged = false;

  @override
  void initState() {
    super.initState();
    selectedRating = widget.currentRating;
    impressionsController.text = widget.initialImpressions ?? '';
    profitController.text = widget.initialProfit ?? '';
    impressionsController.addListener(_onChanged);
    profitController.addListener(_onChanged);
  }

  void _onChanged() {
    final hasNewText = impressionsController.text.trim() !=
        (widget.initialImpressions ?? '').trim();
    final hasNewProfit =
        profitController.text.trim() != (widget.initialProfit ?? '').trim();
    final ratingChanged = selectedRating != widget.currentRating;
    setState(() {
      hasChanged = hasNewText || hasNewProfit || ratingChanged;
    });
  }

  void onSave() {
    final updatedRating = selectedRating;
    final impressions = impressionsController.text.trim();
    final profit = profitController.text.trim().isEmpty
        ? null
        : profitController.text.trim();

    Navigator.pop(context, {
      'rating': updatedRating,
      'impressions': impressions,
      'profit': profit,
    });
  }

  void onDelete() {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Delete an assessment?'),
        content: const Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: Text(
            'You will not be able to restore the assessment data you have entered',
          ),
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          CupertinoDialogAction(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop({'delete': true});
            },
            isDestructiveAction: true,
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  Future<bool> _onWillPop() async {
    if (!hasChanged) return true;

    final result = await showCupertinoDialog<bool>(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: const Text('Are you sure you want to come out?'),
        content: const Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: Text('Your progress will not be saved'),
        ),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Stay'),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Leave'),
          ),
        ],
      ),
    );

    return result ?? false;
  }

  @override
  void dispose() {
    impressionsController.dispose();
    profitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profitText = profitController.text.trim();
    final showDollar = profitText.isNotEmpty;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: ColorM.background,
        appBar: AppBar(
          backgroundColor: ColorM.background,
          elevation: 0,
          iconTheme: const IconThemeData(color: ColorM.white),
          title: Text(
            'Edit assessment',
            style: TextStyle(
              color: ColorM.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: [
            IconButton(
              onPressed: onDelete,
              icon: SvgPicture.asset(
                'assets/icons/dele.svg',
                width: 24.w,
                height: 24.w,
                color: ColorM.white,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF252B30),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    widget.name,
                    style: TextStyle(
                      color: ColorM.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                TextField(
                  controller: impressionsController,
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
                  style: TextStyle(color: ColorM.white, fontSize: 16.sp),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixText:
                        profitController.text.trim().isNotEmpty ? '\$ ' : null,
                    prefixStyle: TextStyle(
                      color: ColorM.white,
                      fontSize: 16.sp,
                    ),
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
                SizedBox(height: 32.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildOption(
                      icon: 'assets/icons/good.svg',
                      label: 'Great!',
                      selected: selectedRating == true,
                      value: true,
                    ),
                    _buildOption(
                      icon: 'assets/icons/bad.svg',
                      label: 'Badly',
                      selected: selectedRating == false,
                      value: false,
                    ),
                  ],
                ),
                SizedBox(height: 32.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: hasChanged &&
                            impressionsController.text.trim().isNotEmpty
                        ? onSave
                        : null,
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
      ),
    );
  }

  Widget _buildOption({
    required String icon,
    required String label,
    required bool selected,
    required bool value,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedRating = value;
          _onChanged();
        });
      },
      child: Column(
        children: [
          SvgPicture.asset(
            icon,
            width: selected ? 76.w : 66.w,
            height: selected ? 76.w : 66.w,
            color: selected ? ColorM.blue : const Color(0xFF2F4B63),
          ),
          SizedBox(height: 12.h),
          Text(
            label,
            style: TextStyle(
              color: ColorM.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
