import 'package:flutter/material.dart';

class UsageInfoWidget extends StatelessWidget {
  final String icon;
  final String text;
  const UsageInfoWidget({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: SizedBox(
            width: 24,
            height: 24,
            child: Image.asset(icon),
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        Center(
          child: SizedBox(
            width: 280,
            height: 65,
            child: Center(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
