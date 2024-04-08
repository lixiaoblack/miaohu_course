import 'dart:io';

import 'package:get/get.dart';
import 'package:miaohu_course/pages/system/download/model.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path_provider/path_provider.dart';

class DBService extends GetxService {
  static DBService get to => Get.find();

  Database? database;

  String path = '';

  // 礼物分区
  final downloadStore = intMapStoreFactory.store("download");

  @override
  void onInit() {
    //
    initDb();
    super.onInit();
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

  Future initDb() async {
    var dir = await localfileDir();
    path = dir.path;
    // myLog(dir);
    var dbPath = '${dir.path}/my_database.db';
    // 判断文件是否存在
    File dbFile = File(dbPath);
    bool exists = await dbFile.exists();
    if (!exists) {
      // 没有创建过DB，开始创建DB
      await dir.create(recursive: true);
    }

    DatabaseFactory dbFactory = databaseFactoryIo;
    // 初始化完成
    database = await dbFactory.openDatabase(dbPath);
  }

  // 存储下载数据
  Future saveFileData(DownloadItemModel data) async {
    if (database == null) {
      await initDb();
    }
    downloadStore.record(data.id).put(database!, data.toJson());
  }

  // 查找下载的数据
  Future getFileData(List<int> ids) async {
    if (database == null) {
      await initDb();
    }
    var map = await downloadStore.records(ids).get(database!);
    List<DownloadItemModel> list = [];
    if (map.isEmpty) {
      return null;
    } else {
      for (var element in map) {
        if (element != null) {
          DownloadItemModel info = DownloadItemModel.fromJson(element);
          list.add(info);
        }
      }

      return list;
    }
  }
}
