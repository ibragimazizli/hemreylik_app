import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../widgets/bottom_elements.dart';
import '../widgets/input_box.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    requestMicrophonePermission();
    // TODO: implement initState
    super.initState();
  }

  Future<void> requestMicrophonePermission() async {
    PermissionStatus status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Microphone Permission'),
          content: const Text(
              'Please grant microphone permission to use the voice recorder.'),
          actions: <Widget>[
            ElevatedButton(
                child: const Text('OK'),
                onPressed: () async {
                  await Permission.microphone.request();
                  await Permission.storage.request();
                  Navigator.of(context).pop();
                }),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 320,
                height: 320,
                child: Image.asset(
                  'assets/images/login_image.png',
                  fit: BoxFit.cover,
                ),
              ),
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 35.0),
                    child: Text(
                      "Telefon nömrəsini daxil edin",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.0),
                child: InputBox(),
              ),
              const SizedBox(
                height: 200,
              ),
              BottomElements(),
            ],
          ),
        ),
      ),
    );
  }
}
