import 'dart:io';

import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

/// 转换
class Convert {
  // 阿里图片尺寸调整
  static String aliImageResize(
    String url, {
    double width = 300,
    double? maxHeight,
  }) {
    var crop = '';
    int iWidth = width.toInt();
    int? iMaxHeight = maxHeight?.toInt();

    if (maxHeight != null) {
      crop = '/crop,h_$iMaxHeight,g_center';
    }
    return '$url?x-oss-process=image/resize,w_$iWidth,m_lfit$crop';
  }
}

/// 获取文档目录
Future<Directory> localfileDir() async {
  Directory? tempDir;
  if (GetPlatform.isAndroid) {
    tempDir = await getApplicationDocumentsDirectory();
  } else {
    tempDir = await getLibraryDirectory();
  }
  return tempDir;
}
