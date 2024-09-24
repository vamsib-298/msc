import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

class ScreenshotController extends GetxController {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Timer? _timer;

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  @override
  void onInit() {
    super.onInit();
    _startTimer();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  void _startTimer() {
    _timer = Timer(const Duration(minutes: 1), () async {
      await takeScreenshot();
      _startTimer(); // Restart the timer for next screenshot
    });
  }

  Future<void> takeScreenshot() async {
    try {
      // Capture the screenshot
      Uint8List? image = await _captureScreenshot();

      if (image != null) {
        // Save the screenshot to local storage
        await _saveScreenshotLocally(image);
      } else {
        print('Error capturing screenshot');
      }
    } catch (e) {
      print('Error taking screenshot: $e');
    }
  }

  Future<Uint8List?> _captureScreenshot() async {
    RenderRepaintBoundary boundary =
        _scaffoldKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    return await boundary.toImage(pixelRatio: 3.0)
        .then((image) => image.toByteData(format: ImageByteFormat.png))
        .then((byteData) => byteData!.buffer.asUint8List());
  }

  Future<void> _saveScreenshotLocally(Uint8List imageBytes) async {
    Directory? directory = await getExternalStorageDirectory();
    if (directory == null) {
      print('Failed to get external storage directory');
      return;
    }

    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    String filePath = '${directory.path}/screenshot_$timestamp.png';

    File file = File(filePath);
    await file.writeAsBytes(imageBytes);
  }
}
