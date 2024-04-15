import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:miaohu_course/common/index.dart';
import 'package:miaohu_course/common/widgets/index.dart';
import 'package:url_launcher/url_launcher.dart';

import 'index.dart';

class WebviewPage extends GetView<WebviewController> {
  const WebviewPage({super.key});

  // 主视图
  Widget _buildView() {
    return Stack(
      children: [
        InAppWebView(
          key: controller.webViewKey,
          initialUrlRequest: URLRequest(
              url: WebUri(
                  "http://127.0.0.1:5500/lib/pages/webview/webview.html")),
          onWebViewCreated: (webViewcontroller) async {
            controller.setWebViewController(webViewcontroller);
            // controller.onloadFunction(webViewcontroller);

            print(await webViewcontroller.getUrl());
          },
          onLoadStop: (webViewcontroller, url) {
            controller.onloadFunction(webViewcontroller);
          },
          initialSettings: controller.settings,
          shouldOverrideUrlLoading: (controller, navigationAction) async {
            var uri = navigationAction.request.url!;

            if (![
              "http",
              "https",
              "file",
              "chrome",
              "data",
              "javascript",
              "about"
            ].contains(uri.scheme)) {
              if (await canLaunchUrl(uri)) {
                // Launch the App
                await launchUrl(
                  uri,
                );
                // and cancel the request
                return NavigationActionPolicy.CANCEL;
              }
            }

            return NavigationActionPolicy.ALLOW;
          },
          onProgressChanged: (webviewController, progress) {
            controller.setProgress(progress);
          },
          // initialOptions: ,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WebviewController>(
      init: WebviewController(),
      id: "webview",
      builder: (_) {
        return Scaffold(
            appBar: AppBar(title: Text(controller.title)),
            body: SafeArea(
              child: _buildView(),
            ),
            floatingActionButton: <Widget>[
              // TextButton(
              //         onPressed: () {},
              //         child: const TextWidget.body2(
              //           "加载页面",
              //           color: Colors.white,
              //           maxLines: 2,
              //           softWrap: true,
              //           textAlign: TextAlign.center,
              //           weight: FontWeight.w600,
              //         ))
              //     .width(40.h)
              //     .height(40.h)
              //     .backgroundColor(const Color(0xFF9982FF))
              //     .clipOval(),
              SizedBox(
                height: 10.h,
              ),
              IconButton(
                      color: Colors.white,
                      onPressed: () {
                        // controller.onclickDownloadFile();
                      },
                      icon: const Icon(Icons.replay_outlined))
                  .backgroundColor(const Color(0xFF9982FF))
                  .clipOval()
            ].toColumn().height(100.h).marginOnly(bottom: 50.h));
      },
    );
  }
}
