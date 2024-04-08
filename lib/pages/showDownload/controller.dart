import 'package:get/get.dart';
import 'package:miaohu_course/common/index.dart';
import 'package:miaohu_course/pages/index.dart';

class ShowdownloadController extends GetxController {
  ShowdownloadController();
  DownloadItemModel? data = Get.arguments?["data"];
  DownloadItemModel? filterDbData;

  _initData() async {
    if (data != null) {
      // 通过数据库查询获取数据
      List<DownloadItemModel> list = await DBService.to.getFileData([data!.id]);
      if (list.isNotEmpty) {
        filterDbData = list.first;
      }
    }
    update(["showdownload"]);
  }

  void onTap() {}

  @override
  void onReady() {
    super.onReady();
    _initData();
  }
}
