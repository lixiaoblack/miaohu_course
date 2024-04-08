import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:miaohu_course/common/index.dart';

import 'index.dart';

class DownloadPage extends GetView<DownloadController> {
  const DownloadPage({super.key});

  // 主视图
  Widget _buildView() {
    return ListView.builder(
      padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 30.h),
      controller: controller.scrollController,
      itemCount: controller.downloadFileList.length,
      itemBuilder: _itemBuilder,
    );
  }

  Widget _itemBuilder(content, index) {
    return Container(
      height: 60.h,
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(10.h),
      decoration: BoxDecoration(
          color: const Color(0x66C4B3FF),
          borderRadius: BorderRadius.circular(10.h)),
      child: <Widget>[
        TextWidget.body1(
          controller.downloadFileList[index].name,
          weight: FontWeight.w500,
        ),
        <Widget>[
          Container(
            width: 220.w,
            height: 8.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.h),
                color: const Color(0xFF5C5673),
                border: Border.all(color: const Color(0xFF8B81A6), width: 1.h)),
            child: [
              Container(
                height: 8.h,
                width: (217 * controller.downloadFileList[index].progress).w,
                decoration: BoxDecoration(
                    color: const Color(0xFF76E8B5),
                    borderRadius: BorderRadius.circular(4.h)),
              ),
            ].toRow(mainAxisSize: MainAxisSize.min),
          ),
          SizedBox(
            width: 20.w,
          ),
          TextWidget.body2(
            "${(controller.downloadFileList[index].progress * 100).toStringAsFixed(2)}%",
            color: Colors.blue,
          )
        ].toRow()
      ]
          .toColumn(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround)
          .height(50.h),
    ).onTap(() {
      controller.onTapItem(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DownloadController>(
      init: DownloadController(),
      id: "download",
      builder: (_) {
        return Scaffold(
            body: SafeArea(
              child: _buildView(),
            ),
            floatingActionButton: IconButton(
                    color: Colors.white,
                    onPressed: () {
                      controller.onclickDownloadFile();
                    },
                    icon: const Icon(Icons.download))
                .backgroundColor(const Color(0xFF9982FF))
                .clipOval());
      },
    );
  }
}
