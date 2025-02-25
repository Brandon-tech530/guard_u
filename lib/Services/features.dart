import 'dart:math';
import 'dart:isolate';
import 'package:flutter/foundation.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg;

class SafetyService {
  void startBackgroundServices() {
    configureBackgroundLocation();
    startAccelerometerInBackground();
    startForegroundService(); // Optional for keeping sensors alive
  }

  void configureBackgroundLocation() {
    bg.BackgroundGeolocation.onLocation((bg.Location location) {
      debugPrint(
          'Background GPS: ${location.coords.latitude}, ${location.coords.longitude}');
    });

    bg.BackgroundGeolocation.ready(bg.Config(
      desiredAccuracy: bg.Config.DESIRED_ACCURACY_HIGH,
      distanceFilter: 10.0,
      stopOnTerminate: false,
      startOnBoot: true,
    )).then((bg.State state) {
      if (!state.enabled) {
        bg.BackgroundGeolocation.start();
      }
    });
  }

  void startAccelerometerInBackground() {
    ReceivePort receivePort = ReceivePort();

    Isolate.spawn(startAccelerometerIsolate, receivePort.sendPort);

    receivePort.listen((message) {
      debugPrint('Accelerometer Alert: $message');
    });
  }

  void startForegroundService() {
    FlutterForegroundTask.startService(
      notificationTitle: 'Monitoring Safety',
      notificationText: 'Sensors and location monitoring active...',
      callback: startForegroundTaskCallback,
    );
  }
}

void startAccelerometerIsolate(SendPort sendPort) {
  accelerometerEventStream().listen((event) {
    double acceleration =
        sqrt(event.x * event.x + event.y * event.y + event.z * event.z);
    if (acceleration > 20) {
      sendPort.send('Sudden movement detected!');
    }
  });
}

void startForegroundTaskCallback() {
  debugPrint('Foreground task is running');
}
