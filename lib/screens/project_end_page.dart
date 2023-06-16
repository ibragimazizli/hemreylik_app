import 'package:flutter/material.dart';
import 'package:hermeyliyin_sesi/screens/home_screen.dart';

class ProjectEndPage extends StatefulWidget {
  const ProjectEndPage({super.key});

  @override
  State<ProjectEndPage> createState() => _ProjectEndPageState();
}

class _ProjectEndPageState extends State<ProjectEndPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: double.infinity,
              height: 320,
              child: Image.asset("assets/images/projectend.png"),
            ),
            const Text(
              "İştirakınız üçün təşəkkürlər !",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const HomeScreen(),
                    ),
                  );
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
                    padding: EdgeInsets.all(10.0),
                    child: Center(
                      child: Text(
                        "Səsini bizə göndər",
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
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                children: [
                  Text(
                    "Tərəfdaşlarımız",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 200,
              child: ListView.builder(
                itemCount: 4,
                scrollDirection: Axis.horizontal,
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
                        "assets/images/terefdash.png",
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
