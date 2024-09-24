import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msc/src/snapshots-screen/view/snapshot_screen_view.dart';
import 'package:screenshot/screenshot.dart';

void main() {
  runApp(const MyApp());
  Get.put(ScreenshotController());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ScreenshotScreenView(),
    );
  }
}
