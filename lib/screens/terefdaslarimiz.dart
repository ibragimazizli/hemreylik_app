import 'package:flutter/material.dart';

class Terefdaslarimiz extends StatefulWidget {
  const Terefdaslarimiz({super.key});

  @override
  State<Terefdaslarimiz> createState() => _TerefdaslarimizState();
}

class _TerefdaslarimizState extends State<Terefdaslarimiz> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Tərəşdaşlarımız",style: TextStyle(color: Colors.black),)),
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: const [
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.black,
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              width: 320,
              height: 320,
              child: Image.asset("assets/photos/terefdaslarimiz.jpeg"),
            ),
           SizedBox(
              height: 300,
              child: GridView.builder(
gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,),
                itemCount: 4,
                itemBuilder: (context, index) => Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFF34353C),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 162,
                  width: 140,
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/photos/kapital.jpeg",
                        height: 80,
                        width: 80,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Kapital Bank",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
