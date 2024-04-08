import 'package:flutter/material.dart';
import 'package:miaohu_course/pages/index.dart';
import 'package:get/get.dart';

import 'index.dart';

// 路由 Pages
class RoutePages {
  static final RouteObserver<Route> observer = RouteObservers();
  static List<String> history = [];

  // 列表
  static List<GetPage> list = [
    // app 首页
    GetPage(
      name: RouteNames.main,
      page: () => const MainPage(),
      binding: MainBinding(),
    ),
    GetPage(
      name: RouteNames.systemLogin,
      page: () => const LoginPage(),
    ),
    GetPage(
      name: RouteNames.systemSplash,
      page: () => const SplashPage(),
    ),
    GetPage(
      name: RouteNames.systemDownload,
      page: () => const DownloadPage(),
    ),
    GetPage(
      name: RouteNames.showDownload,
      page: () => const ShowdownloadPage(),
    ),
  ];
}
