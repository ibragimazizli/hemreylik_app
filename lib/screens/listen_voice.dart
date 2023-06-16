// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:audio_waveforms/audio_waveforms.dart';

import 'package:flutter/material.dart';
import 'package:hermeyliyin_sesi/screens/project_end_page.dart';

class ListenVoice extends StatefulWidget {
  ListenVoice({super.key, required this.path, required this.time});
  final String path;
  final String? time;
  @override
  State<ListenVoice> createState() => _ListenVoiceState();
}

class _ListenVoiceState extends State<ListenVoice> {
  PlayerController controller = PlayerController(); // Initialise
  void _extractWave(path) async {
    await controller.preparePlayer(
      path: path,
      shouldExtractWaveform: true,
      noOfSamples: 100,
      volume: 1.0,
    );
  }

  @override
  void initState() {
    _extractWave(widget.path);
    // controller.
    _stopped();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool? isListening;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Səsi dinlə",
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
                  height: 250,
                  child: Image.asset(
                    'assets/images/Voice.png',
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    // top: 15.0,
                    left: 15,
                    right: 15,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        "Səsini dinlə",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "00:00",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          widget.time!,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    AudioFileWaveforms(
                      size: Size(MediaQuery.of(context).size.width, 100.0),
                      playerController: controller,
                      enableSeekGesture: true,
                      waveformType: WaveformType.long,
                      waveformData: const [],
                      playerWaveStyle: const PlayerWaveStyle(
                        showTop: true,
                        showBottom: true,
                        showSeekLine: true,
                        seekLineColor: Colors.red,
                        fixedWaveColor: Colors.redAccent,
                        liveWaveColor: Colors.red,
                        spacing: 8,
                      ),
                    ),
                    // SizedBox(
                    //   width: double.infinity,
                    //   child: Image.asset("assets/images/Group 27.png"),
                    // ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: _seekBackward,
                          child: Image.asset("assets/icons/back.png"),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        GestureDetector(
                          onTap: _listenAudio,
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: const BoxDecoration(
                                color: Colors.red,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100))),
                            child: Center(
                              child: isListening == true
                                  ? const Icon(
                                      Icons.pause,
                                      color: Colors.white,
                                      size: 35,
                                    )
                                  : const Icon(
                                      Icons.play_arrow_sharp,
                                      color: Colors.white,
                                      size: 35,
                                    ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        GestureDetector(
                          onTap: _seekForward,
                          child: Image.asset("assets/icons/forward.png"),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ProjectEndPage(),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(249, 57, 57, 1),
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
                      width: double.infinity,
                      height: 60,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Center(
                              child: Text(
                                "Səsini bizə göndər",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: Image.asset("assets/icons/send.png"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 0, 0, 0),
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
                      width: double.infinity,
                      height: 60,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Center(
                              child: Text(
                                "Səsini yenidən yaz",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: Image.asset("assets/icons/mic.png"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ));
  }

  void _listenAudio() async {
    if (!controller.playerState.isPlaying) {
      await controller.startPlayer(finishMode: FinishMode.loop);
      setState(() {
        isListening = true;
      });
      debugPrint("Listening");
    } else {
      controller.pausePlayer();
      controller.setRefresh(true);
      debugPrint("stopped");
      setState(() {
        isListening = false;
      });
    }
  }

  _stopped() async {
    controller.onCompletion.listen((event) {
      debugPrint("player stopped");

      controller.startPlayer(finishMode: FinishMode.stop);
      setState(() {
        isListening = false;
      });
    });
  }

  void _seekBackward() async {
    await controller.seekTo(5000);
  }

  void _seekForward() async {
    await controller.seekTo(-5000);
  }
}
