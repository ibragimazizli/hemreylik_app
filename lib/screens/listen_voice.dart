import 'package:audio_waveforms/audio_waveforms.dart';

import 'package:flutter/material.dart';

class ListenVoice extends StatefulWidget {
  const ListenVoice({super.key, required this.path});
  final String path;
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
    // TODO: implement initState
    _extractWave(widget.path);
    // controller.
    _stopped();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
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
                  height: 300,
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
                const SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      "te",
                      style: TextStyle(
                        fontSize: 16,
                      ),
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
                      waveformData: [],
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
                    const SizedBox(
                      height: 15,
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
              ],
            ),
          ),
        ));
  }

  void _listenAudio() async {
    if (!controller.playerState.isPlaying) {
      await controller.startPlayer(finishMode: FinishMode.stop);
      setState(() {
        isListening = true;
      });
    } else {
      controller.pausePlayer();
      controller.setRefresh(true);

      setState(() {
        isListening = false;
      });
    }
  }

  _stopped() async {
    controller.onCompletion.listen((event) {
      debugPrint("player stopped");

      controller.stopPlayer();
    });
  }

  void _seekBackward() async {
    await controller.seekTo(-5000);
  }

  void _seekForward() async {
    await controller.seekTo(5000);
  }
}
