import 'package:flutter/material.dart';

import '../widgets/c_button.dart';
import '../widgets/input_box.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                height: 16,
              ),
              const SubmitButton(
                text: "Daxil ol",
              ),
              const SizedBox(
                height: 200,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
