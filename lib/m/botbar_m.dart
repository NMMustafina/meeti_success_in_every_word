import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meeti_success_in_every_word_201_t/m/color_m.dart';
import 'package:meeti_success_in_every_word_201_t/m/moti_m.dart';
import 'package:meeti_success_in_every_word_201_t/m_scr/profit.dart';
import 'package:meeti_success_in_every_word_201_t/m_scr/scenario.dart';
import 'package:meeti_success_in_every_word_201_t/m_scr/settinggs.dart';

class MBotomBar extends StatefulWidget {
  const MBotomBar({super.key, this.indexScr = 0});
  final int indexScr;

  @override
  State<MBotomBar> createState() => MBotomBarState();
}

class MBotomBarState extends State<MBotomBar> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.indexScr;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        height: 95.h,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration: BoxDecoration(
          color: ColorM.background,
          border: Border(
              top: BorderSide(
            color: Colors.white.withOpacity(0.1),
          )),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: buildNavItem(0, 'assets/icons/1.png')),
            Expanded(child: buildNavItem(1, 'assets/icons/2.png')),
            Expanded(child: buildNavItem(2, 'assets/icons/3.png')),
          ],
        ),
      ),
    );
  }

  Widget buildNavItem(int index, String iconPath) {
    bool isActive = _currentIndex == index;

    return MMotiBut(
      onPressed: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 19),
        color: Colors.white.withOpacity(0.0),
        child: Image.asset(
          iconPath,
          width: 32.w,
          height: 32.h,
          color: isActive ? ColorM.blue : const Color(0xFF727375),
        ),
      ),
    );
  }

  final _pages = <Widget>[
    const Scenario(),
    const Profit(),
    const Settinggs(),
  ];
}
