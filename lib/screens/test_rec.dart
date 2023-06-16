import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'listen_voice.dart';

class TestRecordPage extends StatefulWidget {
  const TestRecordPage({super.key});

  @override
  State<TestRecordPage> createState() => _TestRecordPageState();
}

class _TestRecordPageState extends State<TestRecordPage> {
  late final RecorderController recorderController;
  PlayerController controller = PlayerController(); // Initialise

  String? path;
  String? musicFile;
  bool isRecording = false;
  bool isRecordingCompleted = false;
  bool isLoading = true;
  late Directory appDirectory;

  @override
  void initState() {
    super.initState();
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

  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      musicFile = result.files.single.path;
      setState(() {});
    } else {
      debugPrint("File not picked");
    }
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
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
              ),
            ),
          ],
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 320,
                  height: 300,
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
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      recorderController.elapsedDuration.inSeconds.toString(),
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
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
                            waveformData: [],
                            playerWaveStyle: const PlayerWaveStyle(
                              showTop: true,
                              showBottom: true,
                              seekLineThickness: 3,
                              showSeekLine: true,
                              seekLineColor: Colors.red,
                              fixedWaveColor: Colors.redAccent,
                              liveWaveColor: Colors.red,
                              spacing: 8,
                            ),
                          ),
                        ],
                      )
                    : AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        child: isRecording
                            ? AudioWaveforms(
                                enableGesture: true,
                                size:
                                    Size(MediaQuery.of(context).size.width, 60),
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
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 15),
                              )
                            : SizedBox(
                                width: 360,
                                height: 139,
                                child: Image.asset(
                                  'assets/images/no sound.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),

                // recording
                !isRecording
                    ? Row(
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
                                    color: Colors.black,
                                  ),
                                )
                              : const SizedBox(),
                          const SizedBox(width: 16),
                        ],
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 80.0, left: 48),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
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
                            isRecording
                                ? Padding(
                                    padding: const EdgeInsets.only(left: 18.0),
                                    child: GestureDetector(
                                      onTap: _stopRec,
                                      child: Image.asset(
                                          "assets/icons/cancel.png"),
                                    ),
                                  )
                                : const SizedBox(),
                            const SizedBox(width: 16),
                          ],
                        ),
                      ),

                // bottom container
                const SizedBox(
                  height: 40,
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
    }
  }

  void _pauseRec() async {
    if (isRecording) {
      recorderController.pause();
    }
  }

  void _refreshWave() {
    if (isRecording) recorderController.refresh();
  }

  void _extractWave(path) async {
    await controller.preparePlayer(
      path: path,
      shouldExtractWaveform: true,
      noOfSamples: 100,
      volume: 1.0,
    );
  }

  void _listenAudio() async {
    !controller.playerState.isPlaying
        ? await controller.startPlayer(finishMode: FinishMode.stop)
        : controller.pausePlayer(); // Start audio player
  }

  void _pausePlater() async {
    await controller.pausePlayer();
  }
}
