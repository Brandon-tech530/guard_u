import 'dart:math';
import 'dart:isolate';
import 'package:flutter/foundation.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg;

class SafetyService {
  // Speech-to-Text instance for voice recognition
  final stt.SpeechToText _speechToText = stt.SpeechToText();

  // Gemini AI model for analyzing speech
  final GenerativeModel _model = GenerativeModel(
    model: 'gemini-pro',
    apiKey: 'YOUR_GEMINI_API_KEY', // Replace with your Gemini API Key
  );

  // Bluetooth instance for scanning and connecting to IoT devices
  final FlutterBluePlus flutterBlue = FlutterBluePlus();

  /// Starts all background services for user safety.
  void startBackgroundServices() {
    configureBackgroundLocation();      // GPS tracking
    startAccelerometerInBackground();   // Movement detection in isolate
    startForegroundService();           // Keeps the app alive in the background
    startSpeechRecognition();           // Monitors voice for distress signals
    startBluetoothMonitoring();         // Monitors Bluetooth IoT devices
  }

  /// Configures background location tracking.
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
        bg.BackgroundGeolocation.start(); // Start location tracking
      }
    });
  }

  /// Launches accelerometer monitoring in a separate isolate.
  void startAccelerometerInBackground() {
    ReceivePort receivePort = ReceivePort();
    Isolate.spawn(startAccelerometerIsolate, receivePort.sendPort);

    receivePort.listen((message) {
      debugPrint('Accelerometer Alert: $message');
      sendSOS('Sudden movement detected!');
    });
  }

  /// Starts a foreground service to keep the app running in the background.
  void startForegroundService() {
    FlutterForegroundTask.startService(
      notificationTitle: 'Monitoring Safety',
      notificationText: 'Sensors and location monitoring active...',
      callback: startForegroundTaskCallback,
    );
  }

  /// Starts speech-to-text recognition to detect distress signals.
  Future<void> startSpeechRecognition() async {
    bool available = await _speechToText.initialize(
      onStatus: (status) => debugPrint('Speech status: $status'),
      onError: (error) => debugPrint('Speech error: $error'),
    );

    if (available) {
      _speechToText.listen(
        onResult: (result) async {
          debugPrint('Speech detected: ${result.recognizedWords}');
          await analyzeSpeechWithGemini(result.recognizedWords);

          if (!_speechToText.isListening) {
            startSpeechRecognition(); // Ensure continuous listening
          }
        },
      );
    } else {
      debugPrint('Speech recognition not available');
    }
  }

  /// Analyzes speech using Gemini AI to detect distress patterns.
  Future<void> analyzeSpeechWithGemini(String speech) async {
    try {
      final response = await _model.generateContent([
        Content.text(
            "Analyze if the following speech indicates distress, an emergency, or if someone is seeking help. Respond with 'distress' if there is concern, otherwise 'normal': $speech"),
      ]);

      final analysis = response.text?.toLowerCase();
      debugPrint('Gemini Analysis: $analysis');

      if (analysis == 'distress') {
        sendSOS('Voice distress signal detected!');
      }
    } catch (e) {
      debugPrint('Gemini Analysis Error: $e');
    }
  }

  /// Monitors for nearby Bluetooth IoT devices and their capabilities.
  void startBluetoothMonitoring() {
    // Scan for Bluetooth devices
    FlutterBluePlus.onScanResults.listen((results) {
      for (ScanResult r in results) {
        debugPrint("Device Found: ${r.device.remoteId}");
        if (r.device.platformName.isNotEmpty) {
          connectToBluetoothDevice(r.device);
        }
      }
    });
    FlutterBluePlus.startScan(timeout: const Duration(seconds: 10));
  }

  /// Connects to a Bluetooth device and checks for microphones or sensors.
  Future<void> connectToBluetoothDevice(BluetoothDevice device) async {
    try {
      await device.connect();
      debugPrint("Connected to: ${device.platformName}");

      List<BluetoothService> services = await device.discoverServices();
      for (var service in services) {
        for (var characteristic in service.characteristics) {
          // Check for microphone support (e.g., audio profile characteristic)
          if (characteristic.uuid.toString().contains("audio")) {
            debugPrint("Microphone detected on ${device.platformName}");
            startBluetoothSpeechMonitoring(device, characteristic);
          }

          // Listen for sensor data (e.g., movement or panic button)
          if (characteristic.properties.notify) {
            characteristic.setNotifyValue(true);
            characteristic.lastValueStream.listen((value) {
              debugPrint("IoT Data: $value");

              // If panic button is pressed (example condition)
              if (value.contains(1)) {
                sendSOS("Emergency alert from ${device.platformName}!");
              }
            });
          }
        }
      }
    } catch (e) {
      debugPrint("Bluetooth Error: $e");
    }
  }

  /// Starts monitoring for speech input through the IoT device's microphone.
  void startBluetoothSpeechMonitoring(BluetoothDevice device, BluetoothCharacteristic characteristic) async {
    characteristic.lastValueStream.listen((value) async {
      String speechData = String.fromCharCodes(value);
      debugPrint("Speech from ${device.platformName}: $speechData");

      await analyzeSpeechWithGemini(speechData);
    });
  }

  /// Sends an SOS alert (can be customized for emergency services or contacts).
  void sendSOS(String message) {
    debugPrint('🚨 SOS ALERT: $message');
    // Implement your SOS logic here (e.g., send message to emergency contacts)
  }
}

/// Background isolate to monitor accelerometer data.
void startAccelerometerIsolate(SendPort sendPort) {
  accelerometerEventStream().listen((event) {
    double acceleration =
        sqrt(event.x * event.x + event.y * event.y + event.z * event.z);

    if (acceleration > 20) {
      sendPort.send('Sudden movement detected!');
    }
  });
}

/// Callback function for the foreground service.
void startForegroundTaskCallback() {
  debugPrint('Foreground task is running');
}
