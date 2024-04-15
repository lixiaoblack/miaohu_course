import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:miaohu_course/pages/index.dart';
import 'package:miaohu_course/pages/system/download/view.dart';
import 'package:miaohu_course/pages/system/main/model.dart';

class MainController extends GetxController {
  MainController();
  int currentIndex = 0;
  List<Widget> pages = <Widget>[
    const WebviewPage(),
    const DownloadPage(),
    const UserPage(),
  ];
  final PageController pageController = PageController();

  List<MainTabModel> mainTabs = <MainTabModel>[
    MainTabModel(
        tabName: "webview",
        tabImg:
            'https://miaohuapp-web.oss-cn-hangzhou.aliyuncs.com/beta/resources/main_tab/img/1688549054466833616.png',
        tabImgActivated:
            'https://miaohuapp-web.oss-cn-hangzhou.aliyuncs.com/beta/resources/main_tab/img_activated/1688549051061152900.png',
        isDefault: false),
    MainTabModel(
        tabName: "下载",
        tabImg:
            'https://miaohuapp-web.oss-cn-hangzhou.aliyuncs.com/beta/resources/main_tab/img/1688549041307537463.png',
        tabImgActivated:
            'https://miaohuapp-web.oss-cn-hangzhou.aliyuncs.com/beta/resources/main_tab/img_activated/1688549034218176064.png',
        isDefault: true),
    MainTabModel(
        tabName: "我",
        tabImg:
            'https://miaohuapp-web.oss-cn-hangzhou.aliyuncs.com/beta/resources/main_tab/img/1688549085949980932.png',
        tabImgActivated:
            'https://miaohuapp-web.oss-cn-hangzhou.aliyuncs.com/beta/resources/main_tab/img_activated/1688549082947472903.png',
        isDefault: false),
  ];

  void onTap() {}

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  @override
  void onReady() {
    //
    super.onReady();
  }

  @override
  void onClose() {
    //
    super.onClose();
  }

  // 导航栏切换
  void onIndexChanged(int index) {
    currentIndex = index;
    update(["main"]);
  }

  void setCurrentIndex(index) {
    currentIndex = index;
    pageController.jumpToPage(index);
    update(["main"]);
  }
}
