import 'package:flutter/widgets.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:miaohu_course/common/utils/index.dart';

class WebviewController extends GetxController {
  WebviewController();
  GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? webViewController;

  InAppWebViewSettings settings = InAppWebViewSettings(
      clearCache: true,
      cacheEnabled: false,
      mediaPlaybackRequiresUserGesture: false,
      allowsInlineMediaPlayback: true,
      iframeAllow: "camera; microphone",
      iframeAllowFullscreen: true);

  String title = 'webview';

  int progress = 0;

  _initData() {
    update(["webview"]);
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

  void setProgress(int index) {
    progress = index;
    update(["webview"]);
  }

  Future setWebViewController(InAppWebViewController controller) async {
    webViewController = controller;

    controller.addJavaScriptHandler(
        handlerName: "clickEvent",
        callback: (args) async {
          if (args[0]["data"] != null) {
            showToastView(args[0]["data"]);
          }
        });
    controller.addJavaScriptHandler(
        handlerName: "reload",
        callback: (args) async {
          controller.reload();
        });
    controller.addJavaScriptHandler(
        handlerName: "changeTtile",
        callback: (args) async {
          if (args[0]["data"] != null) {
            title = args[0]["data"];
            update(["webview"]);
          }
        });

    controller.addJavaScriptHandler(
        handlerName: "getText",
        callback: (args) async {
          return "这是APP返回的消息";
        });
  }

  Future onloadFunction(InAppWebViewController webViewcontroller) async {
    var source = GetPlatform.isAndroid
        ? "window.top.localStorage.setItem('H5_key','111111')"
        : "window.localStorage.setItem('H5_key','1111111')";
    await webViewcontroller.evaluateJavascript(
      source: source,
    );
  }
}
