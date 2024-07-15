import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_finder/config/router/app_routes.dart';

import 'package:job_finder/config/theme/themedata.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit (
      designSize: Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: getApplicationTheme(),
          initialRoute: AppRoute.loginviewRoute,
          // home: Proximity(),
            builder: EasyLoading.init(),
          routes: AppRoute.getApplicationRoute(),
        );
      },
    );
  }
}
