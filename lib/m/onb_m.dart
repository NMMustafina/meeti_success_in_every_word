import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meeti_success_in_every_word_201_t/m/botbar_m.dart';
import 'package:meeti_success_in_every_word_201_t/m/color_m.dart';
import 'package:meeti_success_in_every_word_201_t/m/moti_m.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MOnBoDi extends StatefulWidget {
  const MOnBoDi({super.key});

  @override
  State<MOnBoDi> createState() => _MOnBoDiState();
}

class _MOnBoDiState extends State<MOnBoDi> {
  final PageController _controller = PageController();
  int introIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorM.background,
      body: Stack(
        children: [
          PageView(
            physics: const ClampingScrollPhysics(),
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                introIndex = index;
              });
            },
            children: const [
              OnWid(
                image: '1',
              ),
              OnWid(
                image: '2',
              ),
              OnWid(
                image: '3',
              ),
            ],
          ),
          SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: SmoothPageIndicator(
                    controller: _controller,
                    count: 3,
                    effect: const SlideEffect(
                      dotColor: Colors.grey,
                      activeDotColor: Colors.indigo,
                      dotWidth: 80,
                      dotHeight: 4,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 710.h),
            child: MMotiBut(
              onPressed: () {
                if (introIndex != 2) {
                  _controller.animateToPage(
                    introIndex + 1,
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.ease,
                  );
                } else {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MBotomBar(),
                    ),
                    (protected) => false,
                  );
                }
              },
              child: Container(
                height: 51,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: ColorM.blue,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Next',
                      style: TextStyle(
                        color: ColorM.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                        height: 1.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OnWid extends StatelessWidget {
  const OnWid({
    super.key,
    required this.image,
  });
  final String image;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Image.asset(
        'assets/images/on$image.png',
        height: 812.h,
        width: 305.w,
        fit: BoxFit.cover,
        // alignment: Alignment.bottomCenter,
      ),
    );
  }
}
