import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'index.dart';

class UserPage extends GetView<UserController> {
  const UserPage({Key? key}) : super(key: key);

  // 主视图
  Widget _buildView() {
    return const Center(
      child: Text("UserPage"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
      init: UserController(),
      id: "user",
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text("user")),
          body: SafeArea(
            child: _buildView(),
          ),
        );
      },
    );
  }
}
