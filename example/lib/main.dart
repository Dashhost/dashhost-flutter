import 'package:dashhost_flutter/dashhost_flutter.dart';
import 'package:flutter/material.dart';

void main() {
  // DashDevTools().enable();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dashhost Coded Example',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      DashRecorder().readyToCapture();
    });

    return Scaffold(
      appBar: AppBar(title: DashText("Dashhost Coded Example", dashTag: "h1")),
      body: Align(
        alignment: Alignment.center,
        child: Column(
          children: [
            DashMetaTag.title("Dashhost Coded Example"),
            DashMetaTag.description("Welcome to the Dashhost Flutter Coded Example"),
            DashMetaTag.image("https://placehold.co/1200x630"),
            DashMetaTag.keywords(['Dashhost', 'flutter', 'seo']),
            DashText("Welcome to the Dashhost Flutter Coded Example", dashTag: "h2"),
            DashBox(dashTag: "section", child: Column(mainAxisSize: MainAxisSize.min, children: [DashText("Hello World"), DashText("Foo Bar")])),
          ],
        ),
      ),
    );
  }
}
