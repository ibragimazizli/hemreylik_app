import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final String text;
  const SubmitButton({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
      width: 320,
      height: 60,
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}