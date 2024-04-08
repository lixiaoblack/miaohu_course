import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miaohu_course/common/index.dart';

import 'index.dart';

class ShowdownloadPage extends GetView<ShowdownloadController> {
  const ShowdownloadPage({super.key});

  // 主视图
  Widget _buildView() {
    return controller.filterDbData != null
        ? ListView(
            children: _randerListViewItem(),
          )
        : const Center(
            child: Text("查询出错"),
          );
  }

  List<Widget> _randerListViewItem() {
    List<Widget> list = [];

    for (String item in controller.filterDbData!.zipFiles) {
      if (!item.endsWith('.svga')) {
        list.add(ImageWidget.file(DBService.to.path + item));
      }
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShowdownloadController>(
      init: ShowdownloadController(),
      id: "showdownload",
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
              title:
                  Text(controller.data != null ? controller.data!.name : '')),
          body: SafeArea(
            child: _buildView(),
          ),
        );
      },
    );
  }
}
