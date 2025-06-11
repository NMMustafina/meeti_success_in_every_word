import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meeti_success_in_every_word_201_t/m/color_m.dart';
import 'package:meeti_success_in_every_word_201_t/m/dok_m.dart';
import 'package:meeti_success_in_every_word_201_t/m/moti_m.dart';
import 'package:meeti_success_in_every_word_201_t/m/pro_m.dart';

class Settinggs extends StatelessWidget {
  const Settinggs({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // centerTitle: false,
        title: Text(
          'Settings',
          style: TextStyle(
            color: ColorM.white,
            fontWeight: FontWeight.w500,
            fontSize: 28.sp,
            height: 1.sp,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 16),
            S(
              onPressed: () {
                lauchUrl(context, DokM.priPoli);
              },
              t: 'Privacy Policy',
            ),
            S(
              onPressed: () {
                lauchUrl(context, DokM.terOfUse);
              },
              t: 'Terms of Use',
            ),
            S(
              onPressed: () {
                lauchUrl(context, DokM.suprF);
              },
              t: 'Support',
            ),
          ],
        ),
      ),
    );
  }
}

class S extends StatelessWidget {
  const S({
    super.key,
    required this.onPressed,
    required this.t,
  });
  final Function() onPressed;

  final String t;

  @override
  Widget build(BuildContext context) {
    return MMotiBut(
      onPressed: onPressed,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        width: double.infinity,
        height: 56.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: const Color(0xFF252B30),
        ),
        child: Row(
          children: [
            const SizedBox(width: 16),
            Text(
              t,
              style: TextStyle(
                color: ColorM.white,
                fontWeight: FontWeight.w500,
                fontSize: 16.sp,
                height: 1.sp,
              ),
            ),
            // const Spacer(),
            // const Icon(
            //   Icons.arrow_forward_ios_rounded,
            //   color: ColorT.white,
            //   size: 28,
            // ),
            // const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}
