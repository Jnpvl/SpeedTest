import 'package:flutter_internet_speed_test/flutter_internet_speed_test.dart';

class SpeedTestManager {
  final FlutterInternetSpeedTest _internetSpeedTest = FlutterInternetSpeedTest()
    ..enableLog();

  Future<void> startSpeedTest({
    required Function() onStarted,
    required Function(TestResult download, TestResult upload) onCompleted,
    required Function(double percent, TestResult data) onProgress,
    required Function(String errorMessage, String speedTestError) onError,
    required Function() onDefaultServerSelectionInProgress,
    required Function(Client? client) onDefaultServerSelectionDone,
    required Function(TestResult data) onDownloadComplete,
    required Function(TestResult data) onUploadComplete,
    required Function() onCancel,
  }) async {
    await _internetSpeedTest.startTesting(
      onStarted: onStarted,
      onCompleted: onCompleted,
      onProgress: onProgress,
      onError: onError,
      onDefaultServerSelectionInProgress: onDefaultServerSelectionInProgress,
      onDefaultServerSelectionDone: onDefaultServerSelectionDone,
      onDownloadComplete: onDownloadComplete,
      onUploadComplete: onUploadComplete,
      onCancel: onCancel,
    );
  }

  void cancelSpeedTest() {
    _internetSpeedTest.cancelTest();
  }
}
