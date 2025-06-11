import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meeti_success_in_every_word_201_t/m/color_m.dart';
import 'package:meeti_success_in_every_word_201_t/m/onb_m.dart';
import 'package:meeti_success_in_every_word_201_t/m/sceen_prov.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            lazy: false,
            create: (_) => ScenrioProvaider(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Meeti',
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              backgroundColor: ColorM.background,
            ),
            scaffoldBackgroundColor: ColorM.background,
            // fontFamily: '-_- ??',
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            splashFactory: NoSplash.splashFactory,
          ),
          home: const MOnBoDi(),
        ),
      ),
    );
  }
}
