import 'package:flutter/material.dart';
import 'package:hemreyliyin_sesi/infrastructure/provider/api_provider.dart';
import 'package:hemreyliyin_sesi/models/register_model.dart';
import 'package:hemreyliyin_sesi/widgets/bottom_elements.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:hemreyliyin_sesi/widgets/c_button.dart';
import 'package:provider/provider.dart';

import '../models/otp_success.dart';
import '../widgets/otp_boxes.dart';
import 'account_create.dart';

class OTPScreen extends StatefulWidget {
  final String phoneNumber;
  const OTPScreen({super.key, required this.phoneNumber});

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

  late String otpCode;
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

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void storeData({required String token}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Storing a string value
    prefs.setString('token', token);
  }

  bool? showError = false;
  String message = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ApiProvider>(builder: (context, state, child) {
        return state.isLoading == true
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.red,
                ),
              )
            : Center(
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
                      const SizedBox(
                        height: 10,
                      ),
                      showError == true
                          ? Padding(
                              padding: const EdgeInsets.only(
                                left: 40.0,
                                top: 15,
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    message,
                                    style: const TextStyle(
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : SizedBox(),
                      const SizedBox(height: 15),
                      SubmitButton(
                        onTap: () async {
                          var combinedText = StringBuffer();
                          for (var element in _controllers) {
                            combinedText.write(element.text);
                          }

                          state
                              .registerUser(
                            phone: widget.phoneNumber,
                            code: combinedText.toString(),
                          )
                              .then((response) {
                            if (response is RegisterSuccessfulResponse) {
                              storeData(token: response.token);
                              print('Status: ${response.message}');
                              print('Token: ${response.token}');
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => AccountCreate(
                                            token: response.token,
                                            phone: widget.phoneNumber,
                                          )));
                            } else if (response is RegisterErrorResponse) {
                              setState(() {
                                showError = true;
                                message = response.message;
                              });
                              print('Error: ${response.message}');
                              print(
                                  'Phone errors: ${response.errors['phone']}');
                            } else {
                              setState(() {
                                showError = true;
                                message = response.message;
                              });
                              print("Error ${response.message}");
                            }
                          });
                        },
                        text: "Kodu təsdiqlə",
                      ),
                      const SizedBox(height: 20),
                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.all(8.0),
                          textStyle: const TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          _countdownTime == 0 ? startTimer() : null;
                          setState(() {
                            _countdownTime = 60;
                          });
                          // state.sendApiRequest(phone: widget.phoneNumber);
                          state
                              .sendApiRequest(phone: widget.phoneNumber)
                              .then((response) {
                            if (response is SuccessResponse) {
                              print('Status: ${response.status}');
                              print('Message: ${response.message}');
                            } else if (response is ErrorResponse) {
                              print('Error: ${response.message}');
                              print(
                                  'Phone errors: ${response.errors['phone']}');
                            }
                          });
                        },
                        child: Text(
                          _countdownTime != 0
                              ? 'Kodu yenidən tələb edin $_countdownTime'
                              : 'Kodu yenidən tələb edin',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.black,
                          // padding: const EdgeInsets.all(16.0),
                          textStyle: const TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Nömrəni dəyiş.',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      const BottomElements(),
                    ],
                  ),
                ),
              );
      }),
    );
  }
}
