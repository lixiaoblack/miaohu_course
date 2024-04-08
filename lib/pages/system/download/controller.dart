import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:miaohu_course/common/index.dart';
import 'package:miaohu_course/pages/system/download/model.dart';
import 'package:path_provider/path_provider.dart';

class DownloadController extends GetxController {
  DownloadController();

  List<DownloadItemModel> downloadFileList = [
    DownloadItemModel(
        id: 1,
        name: "图片1",
        path: 'https://miaohu-oss-cdn.miaohu123.com/course/1.zip',
        isDownload: false,
        progress: 0.0,
        savePath: '',
        zipFiles: []),
    DownloadItemModel(
        id: 2,
        name: "图片2",
        path: 'https://miaohu-oss-cdn.miaohu123.com/course/2.zip',
        isDownload: false,
        progress: 0.0,
        savePath: '',
        zipFiles: []),
    DownloadItemModel(
        id: 3,
        name: "svga",
        path: 'https://miaohu-oss-cdn.miaohu123.com/course/3.zip',
        isDownload: false,
        progress: 0.0,
        savePath: '',
        zipFiles: []),
  ];
  ScrollController scrollController = ScrollController();

  Future _initData() async {
    // 获取当前存储的数据
    List<DownloadItemModel> list = await DBService.to
        .getFileData(downloadFileList.map((e) => e.id).toList());

    for (var item in downloadFileList) {
      if (list.indexWhere((element) => element.id == item.id) > -1) {
        item.isDownload = true;
        item.progress = 1;
      }
    }
    update(["download"]);
  }

  void onTap() {}

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  Future onclickDownloadFile() async {
    // 先检查当前的数据有没有下载
    List<DownloadItemModel> filterList =
        downloadFileList.where((element) => !element.isDownload).toList();
    if (filterList.isNotEmpty) {
      // 准备下载
      for (var item in filterList) {
        downloadFile(item);
      }
    }
  }

  // 下载文件
  Future downloadFile(DownloadItemModel data) async {
    var dir = await localfileDir();
    String path = dir.path;

    // 获取文件类型，也就是最后的后缀
    List<String> urlList = data.path.split('.');
    String fileType = urlList[urlList.length - 1];
    String filePath = "$path/download/${data.id}.$fileType";
    Dio dio = Dio();
    try {
      dio.download(data.path, filePath, onReceiveProgress: (count, total) {
        downloadProgressCallBack(count, total, data.id.toString(), filePath);
      });
    } on DioError catch (e) {
      print(e);
    }
  }

  // 下载进度监听
  downloadProgressCallBack(
    count,
    total,
    String id,
    String filePath,
  ) async {
    // 修改进度条
    downloadFileList
        .firstWhere((element) => element.id == int.parse(id))
        .progress = count / total;
    update(["download"]);
    if (count == total) {
      downloadFileList
          .firstWhere((element) => element.id == int.parse(id))
          .isDownload = true;
      update(["download"]);
      if (filePath.endsWith('zip')) {
        unzipFiles(filePath, id);
      }
    }
  }

  // 解压文件
  Future unzipFiles(url, String id) async {
    // 获取到文件路径
    var dir = await localfileDir();
    String documentPath = dir.path;
    // 拿到文件的存储路径
    String savePath = "$documentPath/download";

    // 从磁盘读取zip文件
    List<int> bytes = File(url).readAsBytesSync();

    // 解码zip文件
    try {
      Archive archive = ZipDecoder().decodeBytes(bytes);
      String res = '';
      List<String> pathFiles = [];
      // 将解码的文件解压缩到磁盘
      for (ArchiveFile file in archive) {
        if (file.isFile) {
          List<int> tempData = file.content;
          File f = File("$savePath/${file.name}")
            ..createSync(recursive: true)
            ..writeAsBytesSync(tempData);
          if (!f.path.contains('MACOSX')) {
            String clipFile = f.path.substring(dir.path.length);

            // myLog(f.path)；
            pathFiles.add(clipFile);
            res = clipFile;
          }
        } else {
          Directory("$savePath/${file.name}").create(recursive: true);
        }
      }
      //整理数据, 通知数据库存储
      List<DownloadItemModel> filterList = downloadFileList
          .where((element) => element.id.toString() == id)
          .toList();
      if (filterList.isNotEmpty) {
        DownloadItemModel data = filterList.first;
        data.savePath = res;
        data.zipFiles = pathFiles;
        DBService.to.saveFileData(data);
      }
    } catch (e) {
      print(e);
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

  // 点击选中下载完成的页面
  onTapItem(int index) {
    if (downloadFileList[index].isDownload) {
      // 执行代码
      Get.toNamed(RouteNames.showDownload,
          arguments: {"data": downloadFileList[index]});
    }
  }
}
