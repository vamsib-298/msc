import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';

class ScreenshotScreenView extends GetView<ScreenshotController> {
  const ScreenshotScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,

      appBar: AppBar(
        title: const Text('Screenshot Screen'),
      ),
      body: const Center(
        child: Text('App captures screenshots in the background'),
      ),
    );
  }
}
