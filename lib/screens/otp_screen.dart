// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:hermeyliyin_sesi/screens/home_screen.dart';
import 'package:hermeyliyin_sesi/screens/info_screen.dart';
import 'package:hermeyliyin_sesi/widgets/bottom_elements.dart';
import 'dart:async';

import 'package:hermeyliyin_sesi/widgets/c_button.dart';

import '../widgets/otp_boxes.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  int _countdownTime = 60;
  Timer? _timer;
  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());
  final List<TextEditingController> _controllers = List.generate(
    4,
    (index) => TextEditingController(),
  );

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdownTime > 0) {
          _countdownTime--;
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  void _resendOTP() {
    // Logic for resending OTP
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
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
                  'assets/images/otp.png',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 35.0),
                    child: Text(
                      "Telefon nömrəsini yoxlamaq üçün\n4 rəqəmli kod alacaqsınız.",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OtpBoxes(
                    controllers: _controllers,
                    focusNodes: _focusNodes,
                    index: 0,
                  ),
                  const SizedBox(width: 10),
                  OtpBoxes(
                    controllers: _controllers,
                    focusNodes: _focusNodes,
                    index: 1,
                  ),
                  const SizedBox(width: 10),
                  OtpBoxes(
                    controllers: _controllers,
                    focusNodes: _focusNodes,
                    index: 2,
                  ),
                  const SizedBox(width: 10),
                  OtpBoxes(
                    controllers: _controllers,
                    focusNodes: _focusNodes,
                    index: 3,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SubmitButton(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const InfoScreen()));
                },
                text: "Kodu təsdiqlə",
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: _countdownTime == 0 ? _resendOTP : null,
                child: Text(
                  'Kodu yenidən tələb edin $_countdownTime ',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              const BottomElements(),
            ],
          ),
        ),
      ),
    );
  }
}
