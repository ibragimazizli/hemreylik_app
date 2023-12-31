// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:hemreyliyin_sesi/widgets/usage_widgets.dart';

class UsageScreen extends StatelessWidget {
  final Function(int) onTabChanged;

  const UsageScreen({super.key, required this.onTabChanged});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "İştirak qaydaları",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
            ),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Column(
            children: [
              SizedBox(
                width: 320,
                height: 320,
                child: Image.asset(
                  'assets/images/usage.png',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                width: double.infinity,
                child: Column(children: [
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: UsageInfoWidget(
                      icon: "assets/icons/Headset.png",
                      text:
                          "Səsinizi yazmadan öncə audio qulaqcıqlarınızın və mikrofonun qoşulduğuna əmin olun.",
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: UsageInfoWidget(
                      icon: "assets/icons/Speaker 04.png",
                      text:
                          "Səsinizi qeyd edərkən yerləşdiyiniz məkanın sakit olması vacibdir.",
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: UsageInfoWidget(
                      icon: "assets/icons/Speaker 03.png",
                      text:
                          "Səsyazma zamanı Azərbaycan himni qulaqcıqlarınızda səslənəcək.",
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: UsageInfoWidget(
                      icon: "assets/icons/Message Text.png",
                      text:
                          "Səsyazma zamanı ekranda Azərbaycan himninin sözlərini görəcəksiniz. Göstərilən tempdə ifa etməyə çalışın.",
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                ),
                child: GestureDetector(
                  onTap: () {
                    onTabChanged(2);
                    // here goes record page
                  },
                  child: Container(
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
                    width: double.infinity,
                    height: 60,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Center(
                            child: Text(
                              "Səsini yaz",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            child: Image.asset("assets/icons/mic.png"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
