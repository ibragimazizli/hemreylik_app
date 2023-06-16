import 'package:flutter/material.dart';

class BottomElements extends StatelessWidget {
  const BottomElements({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            color: Colors.red,
            size: 22,
          ),
          SizedBox(
            width: 12,
          ),
          Text(
            "Layihə haqqında",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(
            width: 35,
          ),
          Icon(
            Icons.help_outline,
            color: Colors.red,
            size: 22,
          ),
          SizedBox(
            width: 12,
          ),
          Text(
            "İştirak qaydaları",
            style: TextStyle(fontSize: 16),
          )
        ],
      ),
    );
  }
}
