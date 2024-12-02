import 'dart:ffi';
import 'dart:io';
import 'package:bestloop_app/sound_services/player_isolate.dart';
import 'package:coast_audio/coast_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

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
  static void changeLoop(String assetPath) {
    loopSoundPath = assetPath;
  }

  static Future<void> playLoop() async {
    print("yes i was called.");
    File fileToPlay = await getAssetFile(loopSoundPath);
    AudioPlayer plr = AudioPlayer(
      context: AudioDeviceContext(backends: [AudioDeviceBackend.aaudio]),
      bufferDuration: const AudioTime(0.1),
      decoder: WavAudioDecoder(
        dataSource: AudioFileDataSource(
          file: fileToPlay, 
          mode: FileMode.read,
        )
      ),
    );
    plr.play();
  }
  static Future<void> pauseLoop() async {
    print("yes i was called.");
    File fileToPlay = await getAssetFile("audio/dg.wav");
    AudioPlayer plr = AudioPlayer(
      context: AudioDeviceContext(backends: [AudioDeviceBackend.aaudio]),
      bufferDuration: const AudioTime(0.1),
      decoder: WavAudioDecoder(
        dataSource: AudioFileDataSource(
          file: fileToPlay, 
          mode: FileMode.read,
        )
      ),
    );
    plr.play();
  }
}