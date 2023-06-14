// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class InputBox extends StatefulWidget {
  const InputBox({Key? key}) : super(key: key);

  @override
  State<InputBox> createState() => _InputBoxState();
}

class _InputBoxState extends State<InputBox> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController controller = TextEditingController();
  String initialCountry = 'AZ';
  PhoneNumber number = PhoneNumber(isoCode: 'AZ');

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
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
        width: 320,
        height: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            InternationalPhoneNumberInput(
              onInputChanged: (PhoneNumber number) {
                print(number.phoneNumber);
              },
              selectorConfig: const SelectorConfig(
                trailingSpace: false,
                setSelectorButtonAsPrefixIcon: true,
                selectorType: PhoneInputSelectorType.DROPDOWN,
              ),
              ignoreBlank: false,
              autoValidateMode: AutovalidateMode.disabled,
              selectorTextStyle: const TextStyle(color: Colors.black),
              initialValue: number,
              textFieldController: controller,
              formatInput: true,
              keyboardType: TextInputType.phone,
              inputBorder: InputBorder.none,
              onSaved: (PhoneNumber number) {
                print('On Saved: $number');
              },
            ),
          ],
        ),
      ),
    );
  }

  void getPhoneNumber(String phoneNumber) async {
    PhoneNumber number =
        await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'US');

    setState(() {
      this.number = number;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
