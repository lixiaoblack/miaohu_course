class DownloadItemModel {
  late int id;
  late String name;
  late String path;
  late bool isDownload;
  late double progress;
  late String savePath;
  late List<dynamic> zipFiles;
  // 加载地址

  DownloadItemModel({
    required this.id,
    required this.name,
    required this.path,
    required this.isDownload,
    required this.progress,
    required this.savePath,
    required this.zipFiles,
  });

  DownloadItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    path = json['path'];
    isDownload = json['isDownload'];
    progress = json['progress'];
    savePath = json['savePath'];
    zipFiles = json['zipFiles'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['path'] = path;
    data['isDownload'] = isDownload;
    data['progress'] = progress;
    data['savePath'] = savePath;
    data['zipFiles'] = zipFiles;
    return data;
  }
}
