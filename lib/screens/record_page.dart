// ignore_for_file: avoid_print

import 'dart:io';


import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

class SoundRecordPage extends StatefulWidget {
  const SoundRecordPage({super.key});

  @override
  State<SoundRecordPage> createState() => _SoundRecordPageState();
}

class _SoundRecordPageState extends State<SoundRecordPage> {
  final recorder = FlutterSoundRecorder();

  bool isRecorderReady = false;
  Future record() async {
    if (!isRecorderReady) return;
    await recorder.startRecorder(
      toFile: "audio.aac",
      // audioSource: AudioSource.microphone,
    );
    // await controller.record(path: 'path'); // Record (path is optional)
  }

  Future stop() async {
    if (!isRecorderReady) return;
    final path = await recorder.stopRecorder();
    final audioFile = File(path!);
    print(audioFile);
  }

  Future initRecorder() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw "Permission not grantted";
    }

    await recorder.openRecorder();
    isRecorderReady = true;
    recorder.setSubscriptionDuration(const Duration(milliseconds: 500));
  }

  void disposerec() {
    recorder.closeRecorder();

    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState

    initRecorder();
    super.initState();
  }

  @override
  void dispose() {
    disposerec();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            recorder.isRecording == true
                ? ElevatedButton(
                    onPressed: () async {
                      await stop();
                      setState(() {});
                    },
                    child: const Text("Stop Recording"),
                  )
                : ElevatedButton(
                    onPressed: () async {
                      await record();
                      setState(() {});
                    },
                    child: const Text("Start Recording"),
                  ),
            StreamBuilder<RecordingDisposition>(
                stream: recorder.onProgress,
                builder: (context, snapshot) {
                  final duration = snapshot.hasData
                      ? snapshot.data!.duration
                      : Duration.zero;
                  String twoDigits(int n) => n.toString().padLeft(60);
                  final twoDigitMinutes =
                      twoDigits(duration.inMinutes.remainder(60));
                  final twoDigitSeconds =
                      twoDigits(duration.inSeconds.remainder(60));
                  return Column(
                    children: [
                      Text(twoDigitMinutes.toString()),
                      Text(twoDigitSeconds.toString()),
                    ],
                  );
                }),
          ],
        ),
      ),
    );
  }
}
