import 'package:flutter/material.dart';

class HesabYarat extends StatefulWidget {
  const HesabYarat({super.key});

  @override
  State<HesabYarat> createState() => _HesabYaratState();
}

class _HesabYaratState extends State<HesabYarat> {
  var tfDate = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text(
          "Hesab Yarat",
          style: TextStyle(color: Colors.black),
        )),
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: const [
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.black,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 15,
              right: 15,
            ),
            child: Column(
              children: [
                SizedBox(
                  width: 320,
                  height: 320,
                  child: Image.asset(
                    "assets/images/profile.png",
                    fit: BoxFit.contain,
                  ),
                ),
                const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: Text(
                        "Adınız",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[300],
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          // color: Color(0xFF34353C), // Kenarlık rengi
                          width: 1.0, // Kenarlık kalınlığı
                        ),
                        borderRadius: BorderRadius.circular(
                            10.0), // Kenarlık köşe yarıçapı
                      ),
                      // Diğer özellikler
                    ),
                  ),
                ),
                const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: Text(
                        "Soyadınız",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[300],
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xFF34353C), // Kenarlık rengi
                          width: 1.0, // Kenarlık kalınlığı
                        ),
                        borderRadius: BorderRadius.circular(
                            10.0), // Kenarlık köşe yarıçapı
                      ),
                      // Diğer özellikler
                    ),
                  ),
                ),
                const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: Text(
                        "Doğum tarixi",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: tfDate,
                    onTap: () {
                      // showDatePicker(
                      //     context: context,
                      //     initialDate: DateTime.now(),
                      //     firstDate: firstData,
                      //     lastDate: lastDate);
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[300],
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xFF34353C), // Kenarlık rengi
                          width: 1.0, // Kenarlık kalınlığı
                        ),
                        borderRadius: BorderRadius.circular(
                            10.0), // Kenarlık köşe yarıçapı
                      ),
                      // Diğer özellikler
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   // MaterialPageRoute(
                      //       // builder: (_) => const UsageScreen(),
                      //       ),
                      // );
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
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            "İndi başla",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
