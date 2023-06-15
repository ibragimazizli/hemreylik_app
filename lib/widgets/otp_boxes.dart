import 'package:flutter/material.dart';

class OtpBoxes extends StatelessWidget {
  final List<FocusNode> focusNodes;
  final List<TextEditingController> controllers;
  final int index;
  const OtpBoxes({
    super.key,
    required this.focusNodes,
    required this.controllers, required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 68,
      height: 68,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1),
      ),
      child: Center(
        child: TextField(
          controller: controllers[index],
          focusNode: focusNodes[index],
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          maxLength: 1,
          style: const TextStyle(fontSize: 24),
          decoration: const InputDecoration(
            border: InputBorder.none,
            counterText: '',
          ),
          onChanged: (value) {
            if (value.isNotEmpty) {
              focusNodes[index].unfocus();
              if (index < 3) {
                focusNodes[index + 1].requestFocus();
              }
              if (index == 3) {
                // Perform verification or any other action
              }
            } else {
              if (index > 0) {
                focusNodes[index - 1].requestFocus();
              }
            }
          },
          autofillHints: const [AutofillHints.oneTimeCode],
        ),
      ),
    );
  }
}
