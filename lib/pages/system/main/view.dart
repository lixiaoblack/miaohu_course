import 'package:flutter/material.dart';
import 'package:miaohu_course/pages/index.dart';
import 'package:get/get.dart';

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
    return const Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      // 内容页
      body: DownloadPage(),
    );
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
