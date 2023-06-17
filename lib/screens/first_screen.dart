// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hemreyliyin_sesi/infrastructure/provider/api_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';

import '../models/otp_success.dart';
import '../widgets/bottom_elements.dart';
import '../widgets/c_button.dart';
import '../widgets/input_box.dart';
import 'otp_screen.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController controller = TextEditingController();
  String initialCountry = 'AZ';
  PhoneNumber number = PhoneNumber(isoCode: 'AZ');

  void getPhoneNumber(String phoneNumber) async {
    PhoneNumber number =
        await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'AZ');

    setState(() {
      this.number = number;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    requestMicrophonePermission();
    super.initState();
  }

  Future<void> requestMicrophonePermission() async {
    PermissionStatus status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
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

  String? full_num;
  bool isWrongNum = false;
  bool? showError = true;
  String error = "";
  @override
  Widget build(BuildContext context) {
    final myProv = Provider.of<ApiProvider>(context, listen: false);
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
                    padding: EdgeInsets.only(
                      top: 15.0,
                      left: 15,
                      right: 15,
                    ),
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
              Column(
                children: [
                  Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 15.0,
                        left: 15,
                        right: 15,
                      ),
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
                        width: double.infinity,
                        height: 60,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            InternationalPhoneNumberInput(
                              onInputChanged: (PhoneNumber number) {
                                setState(() {
                                  full_num = number.phoneNumber;
                                });
                              },
                              selectorConfig: const SelectorConfig(
                                trailingSpace: false,
                                setSelectorButtonAsPrefixIcon: true,
                                selectorType: PhoneInputSelectorType.DROPDOWN,
                              ),
                              ignoreBlank: false,
                              autoValidateMode: AutovalidateMode.disabled,
                              selectorTextStyle:
                                  const TextStyle(color: Colors.black),
                              initialValue: number,
                              textFieldController: controller,
                              formatInput: true,
                              keyboardType: TextInputType.phone,
                              inputBorder: InputBorder.none,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  showError == true
                      ? Padding(
                          padding: const EdgeInsets.only(
                            right: 15,
                            left: 15,
                          ),
                          child: Row(
                            children: [
                              Text(
                                error,
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        )
                      : SizedBox(),
                  SubmitButton(
                    onTap: () {
                      debugPrint(myProv.message);
                      if (controller.text.isNotEmpty) {
                        myProv
                            .sendApiRequest(phone: full_num.toString())
                            .then((response) {
                          if (response is SuccessResponse) {
                            if (full_num!.length == 13) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => OTPScreen(
                                            phoneNumber: full_num.toString(),
                                          )));
                            }
                            print('Status: ${response.status}');
                            print('Message: ${response.message}');
                          } else if (response is ErrorResponse) {
                            setState(() {
                              showError = true;
                              error = response.message;
                            });
                            print('Error: ${response.message}');
                            print('Phone errors: ${response.errors['phone']}');
                          }
                        });
                      }
// 994123456789
                    },
                    text: "Daxil ol",
                  ),
                ],
              ),
              const SizedBox(
                height: 200,
              ),
              const BottomElements(),
            ],
          ),
        ),
      ),
    );
  }
}
