import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hemreyliyin_sesi/screens/home_screen.dart';

class AccountCreate extends StatefulWidget {
  const AccountCreate({super.key});

  @override
  State<AccountCreate> createState() => _AccountCreateState();
}

class _AccountCreateState extends State<AccountCreate> {
  var tfDate = TextEditingController();
  // DateTime? selectedDate;

  // Future<void> _selectDate(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(1900),
  //     lastDate: DateTime.now(),
  //   );
  //   if (picked != null && picked != selectedDate) {
  //     setState(() {
  //       selectedDate = picked;
  //       tfDate.text =
  //           picked.toString(); // Set the chosen date in the text field
  //     });
  //   }
  // }
  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked;
    if (Theme.of(context).platform == TargetPlatform.android) {
      // Show Android date picker
      picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor:
                  Colors.red, // Customize the color of the date picker
              colorScheme: const ColorScheme.light(
                primary: Colors.red, // Customize the color of the selected date
              ),
            ),
            child: child!,
          );
        },
      );
    } else if (Theme.of(context).platform == TargetPlatform.iOS) {
      // Show iOS date picker
      picked = await showModalBottomSheet<DateTime>(
        context: context,
        builder: (BuildContext builder) {
          DateTime? selectedDateTime;
          return SizedBox(
            height: 250,
            child: Column(
              children: [
                Expanded(
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: DateTime.now(),
                    minimumYear: 1900,
                    maximumYear: DateTime.now().year,
                    onDateTimeChanged: (DateTime newDateTime) {
                      selectedDateTime = newDateTime;
                    },
                  ),
                ),
                CupertinoButton(
                  child: const Text('Təsdiq Edin'),
                  onPressed: () {
                    setState(() {
                      selectedDate = selectedDateTime;
                    });
                    Navigator.of(context).pop(); // Close the bottom sheet
                  },
                ),
                const SizedBox(
                  height: 14,
                ),
              ],
            ),
          );
        },
      );
    }

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        tfDate.text =
            picked.toString(); // Set the chosen date in the text field
      });
    }
  }

  int selectedValue = 0;

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
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
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
                  height: 300,
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
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(235, 235, 235, 1),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const Center(
                        child: Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    )),
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
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(235, 235, 235, 1),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const Center(
                        child: Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    )),
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
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(235, 235, 235, 1),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "${selectedDate?.day.toString() ?? ""}.${selectedDate?.month.toString() ?? ""}.${selectedDate?.year.toString() ?? ""}",
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.calendar_month),
                          onPressed: () => _selectDate(context),
                        ),
                      ],
                    ),
                  ),
                ),
                const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: Text(
                        "Cinsiyyətiniz",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Radio<int>(
                            activeColor: Colors.red,
                            value: 0,
                            groupValue: selectedValue,
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value!;
                              });
                            },
                          ),
                          const Text('Kişi'),
                        ],
                      ),
                      Row(
                        children: [
                          Radio<int>(
                            activeColor: Colors.red,
                            value: 1,
                            groupValue: selectedValue,
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value!;
                              });
                            },
                          ),
                          const Text('Qadın'),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const HomeScreen()));
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
