// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'common/index.dart';
import 'global.dart';

Future<void> main() async {
  await Global.init();
  runApp(ScreenUtilInit(
    designSize: const Size(375, 812), // 设计稿中设备的尺寸(单位随意,建议dp,但在使用过程中必须保持一致)
    minTextAdapt: true,
    // splitScreenMode: false, // 支持分屏尺寸
    // minTextAdapt: false, // 是否根据宽度/高度中的最小值适配文字
    builder: (context, child) {
      return GetMaterialApp(
        title: 'Flutter Demo',

        // 文字方向
        // textDirection: TextDirection.rtl,

        // 样式
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,

        // 主题
        themeMode:
            ConfigService.to.isDarkModel ? ThemeMode.dark : ThemeMode.light,

        // 路由
        initialRoute: RouteNames.systemSplash,
        // initialRoute: RouteNames.stylesStylesIndex,
        getPages: RoutePages.list,
        navigatorObservers: [RoutePages.observer],

        // 多语言
        translations: Translation(), // 词典
        localizationsDelegates: Translation.localizationsDelegates, // 代理
        supportedLocales: Translation.supportedLocales, // 支持的语言种类
        locale: ConfigService.to.locale, // 当前语言种类
        fallbackLocale: Translation.fallbackLocale, // 默认语言种类
        builder: EasyLoading.init(),
        // builder
        // builder: (context, widget) {
        //   widget = EasyLoading.init()(context, widget); // EasyLoading 初始化
        //   // 不随系统字体缩放比例
        //   return MediaQuery(
        //     data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        //     child: widget,
        //   );
        // },
        debugShowCheckedModeBanner: false,
      );
    },
  ));
}
