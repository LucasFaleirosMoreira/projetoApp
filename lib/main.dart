import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:frontend/view/principal_view.dart';


void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dropdown com SQLite',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(), // Use 'const' para otimização
    );
  }
}




