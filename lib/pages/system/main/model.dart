class MainTabModel {
  late String tabName;
  late String tabImg;
  late String tabImgActivated;
  late bool isDefault;

  MainTabModel(
      {required this.tabName,
      required this.tabImg,
      required this.tabImgActivated,
      required this.isDefault});

  MainTabModel.fromJson(Map<String, dynamic> json) {
    tabName = json['tabName'];
    tabImg = json['tabImg'];
    tabImgActivated = json['tabImgActivated'];
    isDefault = json['isDefault'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tabName'] = tabName;
    data['tabImg'] = tabImg;
    data['tabImgActivated'] = tabImgActivated;
    data['isDefault'] = isDefault;
    return data;
  }
}
