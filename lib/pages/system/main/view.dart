import 'package:flutter/material.dart';
import 'package:miaohu_course/common/index.dart';
import 'package:miaohu_course/common/widgets/curvedNavigationBar/curved_navigation_bar.dart';
import 'package:miaohu_course/pages/index.dart';
import 'package:get/get.dart';
import 'package:miaohu_course/pages/system/main/model.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const _MainViewGetX();
  }
}

class _MainViewGetX extends GetView<MainController> {
  const _MainViewGetX({super.key});

  // 主视图
  Widget _buildView() {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      // 内容页
      // body: DownloadPage(),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller.pageController,
        onPageChanged: controller.onIndexChanged,
        children: controller.pages,
      ),
      bottomNavigationBar: CurvedNavigationBar(
          onTap: (index) {
            controller.setCurrentIndex(index);
          },
          letIndexChange: (index) => true,
          color: const Color(0xFFF2FAFC),
          buttonBackgroundColor: const Color(0xFFF2FAFC),
          backgroundColor: Colors.transparent,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 500),
          height: 60,
          items: _randerItem()),
    );
  }

  List<Widget> _randerItem() {
    List<Widget> list = [];
    for (var i = 0; i < controller.mainTabs.length; i++) {
      MainTabModel info = controller.mainTabs[i];
      list.add(Stack(
        clipBehavior: Clip.none,
        children: [
          ImageWidget.url(
            controller.currentIndex == i ? info.tabImgActivated : info.tabImg,
            width: 30,
            height: 30,
            fit: BoxFit.cover,
          ),
        ],
      ));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      // init: Get.find<MainController>(),
      id: "main",
      builder: (_) => _buildView(),
    );
  }
}
