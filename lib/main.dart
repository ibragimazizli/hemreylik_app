import 'package:flutter/material.dart';
import 'package:hemreyliyin_sesi/infrastructure/provider/api_provider.dart';
import 'package:hemreyliyin_sesi/screens/first_screen.dart';
import 'package:hemreyliyin_sesi/screens/wrapper.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ApiProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AuthWrapper(),
      ),
    ),
  );
}
