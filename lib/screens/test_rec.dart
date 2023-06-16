import 'dart:async';
import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'listen_voice.dart';

class RecordPage extends StatefulWidget {
  final Function(int) onTabChanged;

  const RecordPage({super.key, required this.onTabChanged});

  @override
  State<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  late final RecorderController recorderController;
  PlayerController controller = PlayerController(); // Initialise

  String? path;
  String? musicFile;
  bool isRecording = false;
  bool isRecordingCompleted = false;
  bool isLoading = true;
  late Directory appDirectory;
  String? duration;
  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (_) {
      getDuration();
    });
    _getDir();
    _initialiseControllers();
  }

  void _getDir() async {
    appDirectory = await getApplicationDocumentsDirectory();
    path = "${appDirectory.path}/recording.m4a";
    isLoading = false;
    setState(() {});
  }

  void _initialiseControllers() {
    recorderController = RecorderController()
      ..androidEncoder = AndroidEncoder.aac
      ..androidOutputFormat = AndroidOutputFormat.mpeg4
      ..iosEncoder = IosEncoder.kAudioFormatMPEG4AAC
      ..sampleRate = 44100;
  }

  @override
  void dispose() {
    recorderController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "İştirak qaydaları",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 320,
                  height: 260,
                  child: Image.asset(
                    'assets/images/record.png',
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    top: 15.0,
                    left: 15,
                    right: 15,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        "    Azərbaycan himnini sən də oxu,\nhəmrəyliyin səsini bir yerdə yaradaq!",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      duration ?? "00:00:00",
                      // recorderController.elapsedDuration.toHHMMSS(),
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                recorderController.recorderState == RecorderState.stopped
                    ? Column(
                        children: [
                          AudioFileWaveforms(
                            size:
                                Size(MediaQuery.of(context).size.width, 100.0),
                            playerController: controller,
                            enableSeekGesture: false,
                            waveformType: WaveformType.long,
                            waveformData: const [],
                            playerWaveStyle: const PlayerWaveStyle(
                              showTop: true,
                              showBottom: true,
                              seekLineThickness: 3,
                              showSeekLine: true,
                              seekLineColor: Colors.red,
                              fixedWaveColor: Colors.redAccent,
                              liveWaveColor: Colors.red,
                            ),
                          ),
                        ],
                      )
                    : AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        child:
                            //  isRecording ?
                            AudioWaveforms(
                          enableGesture: true,
                          size: Size(MediaQuery.of(context).size.width, 60),
                          recorderController: recorderController,
                          waveStyle: const WaveStyle(
                            showDurationLabel: true,
                            durationTextPadding: 20,
                            durationStyle: TextStyle(color: Colors.black),
                            durationLinesColor: Colors.black,
                            waveColor: Colors.red,
                            extendWaveform: true,
                            showMiddleLine: false,
                          ),
                          padding: const EdgeInsets.only(left: 18),
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                        )
                        // : SizedBox(
                        //     width: 360,
                        //     height: 139,
                        //     child: Image.asset(
                        //       'assets/images/no sound.png',
                        //       fit: BoxFit.cover,
                        //     ),
                        //   ),
                        ),

                // recording
                !isRecording
                    ? Padding(
                        padding: const EdgeInsets.only(top: 20.0, left: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: _startOrStopRecording,
                              child: Image.asset("assets/icons/micro.png"),
                            ),
                            isRecording
                                ? IconButton(
                                    onPressed: _stopRec,
                                    icon: const Icon(
                                      Icons.refresh,
                                      color: Colors.red,
                                    ),
                                  )
                                : const SizedBox(),
                            const SizedBox(width: 10),
                          ],
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(
                          top: 70.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 18.0),
                              child: GestureDetector(
                                  onTap: _pauseRec,
                                  child:
                                      recorderController.recorderState.isPaused
                                          ? const Icon(
                                              Icons.play_circle_outline_sharp,
                                              color: Colors.red,
                                              size: 45,
                                            )
                                          : const Icon(
                                              Icons.pause_circle_outline,
                                              color: Colors.red,
                                              size: 45,
                                            )),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            GestureDetector(
                              onTap: _startOrStopRecording,
                              child: Container(
                                  height: 60,
                                  width: 60,
                                  decoration: const BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(100))),
                                  child: const Center(
                                    child: Icon(
                                      Icons.send,
                                      color: Colors.white,
                                    ),
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: GestureDetector(
                                onTap: _stopRec,
                                child: const Icon(
                                  Icons.cancel_outlined,
                                  color: Colors.red,
                                  size: 45,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                          ],
                        ),
                      ),

                // bottom container
                const SizedBox(
                  height: 15,
                ),
                isRecording
                    ? Center(
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromRGBO(51, 51, 51, 0.1),
                                  spreadRadius: 0,
                                  blurRadius: 4,
                                  offset: Offset(0, 0),
                                ),
                              ],
                            ),
                            width: 160,
                            height: 50,
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Səsiniz yazılır",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  Image.asset("assets/icons/micred.png"),
                                ],
                              ),
                            ))),
                      )
                    : const SizedBox()
              ],
            ),
          ),
        ));
  }

  _startOrStopRecording() async {
    try {
      if (isRecording) {
        recorderController.reset();

        final path = await recorderController.stop(false);

        if (path != null) {
          isRecordingCompleted = true;
          debugPrint(path);
          debugPrint("Recorded file size: ${File(path).lengthSync()}");
          _extractWave(path);
          // ignore: use_build_context_synchronously
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => ListenVoice(
                        time: duration.toString(),
                        path: path,
                      )));
        }
      } else {
        await recorderController.record(path: path!);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isRecording = !isRecording;
      });
    }
  }

  void _stopRec() async {
    if (isRecording) {
      recorderController.stop();
      setState(() {
        isRecording = !isRecording;
      });
    }
  }

  void _pauseRec() async {
    if (!recorderController.recorderState.isPaused) {
      recorderController.pause();
      debugPrint("sest");
    } else {
      recorderController.record();
      debugPrint("Test");
    }
  }

  void _extractWave(path) async {
    await controller.preparePlayer(
      path: path,
      shouldExtractWaveform: true,
      noOfSamples: 100,
      volume: 1.0,
    );
  }

  getDuration() {
    setState(() {
      duration = recorderController.elapsedDuration.toHHMMSS();
    });
  }
}
