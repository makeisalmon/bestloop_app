import 'dart:io';
import 'package:bestloop_app/sound_services/player_isolate.dart';
import 'package:coast_audio/coast_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:math';

Future<File> getAssetFile(String assetPath) async {
  // Load the asset into memory
  final byteData = await rootBundle.load(assetPath);

  // Get the temporary directory on the device
  final tempDir = await getTemporaryDirectory();

  // Create a file in the temporary directory
  final tempFile = File('${tempDir.path}/${assetPath.split('/').last}');

  // Write the asset data to the file
  await tempFile.writeAsBytes(byteData.buffer.asUint8List());

  return tempFile;
}

class LoopSoundService {
  static ValueNotifier<double> visualAmplitude = ValueNotifier<double>(0.0);
  static String loopSoundPath = "";
  static AudioPlayer? _audioPlayer;
  static bool isPlaying = false;

  static void changeLoop(String assetPath) {
    _audioPlayer?.pause();
    isPlaying = false;
    _audioPlayer = null;
    loopSoundPath = assetPath;
  }

  static Future<void> playLoop() async {
    if (_audioPlayer == null) {
      File fileToPlay = await getAssetFile(loopSoundPath);
      _audioPlayer = AudioPlayer(
        context: AudioDeviceContext(backends: [AudioDeviceBackend.aaudio]),
        bufferDuration: const AudioTime(0.08),
        decoder: WavAudioDecoder(
          dataSource: AudioFileDataSource(
            file: fileToPlay, 
            mode: FileMode.read,
          )
        ),
      );
    }
    _audioPlayer!.play();
    isPlaying = true;
  }
  static Future<void> pauseLoop() async {
    _audioPlayer?.pause();
    isPlaying = false;
  }
}

class AudioVisualizer {
  static double previousIntensity = 0.0; // Keeps track of the previous value for smoothing
  
  static double calculateVisualIntensity(List<int> buffer) {
    // Step 1: Convert to signed values (-128 to 127)
    List<int> samples = buffer.map((byte) => byte - 128).toList();

    // Step 2: Compute RMS
    double rms = sqrt(samples.map((s) => s * s).reduce((a, b) => a + b) / samples.length);

    // Step 3: Normalize RMS based on minimum and maximum RMS values
    const double minRMS = 103.2;
    const double maxRMS = 106.0;
    double normalizedRMS = ((maxRMS - rms) / (maxRMS - minRMS)).clamp(0.0, 1.5);

    // Step 4: Apply non-linear scaling for perceptual response
    double visualIntensity = pow(normalizedRMS, 0.5).toDouble();

    // Step 5: Smooth transitions (optional)
    // double alpha = 0.3; // Adjust alpha for desired smoothness
    // visualIntensity = alpha * previousIntensity + (1 - alpha) * visualIntensity;

    // Update previousIntensity
    previousIntensity = visualIntensity;

    // Debugging: Log values
    //print('RMS: $rms, Normalized RMS: $normalizedRMS, Visual Intensity: $visualIntensity');

    return visualIntensity;
  }
}