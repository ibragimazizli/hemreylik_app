import 'package:flutter/material.dart';
import 'package:hemreyliyin_sesi/screens/first_screen.dart';
import 'package:hemreyliyin_sesi/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthWrapper extends StatelessWidget {
  AuthWrapper();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: isAuthenticated(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else {
          if (snapshot.hasData && snapshot.data == true) {
            return HomeScreen();
          } else {
            return InitialScreen();
          }
        }
      },
    );
  }

  Future<bool> isAuthenticated() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? authToken = prefs.getString('token');

    // Add your authentication logic here
    // For example, check if the authToken is valid and not expired

    return authToken != null;
  }
}
