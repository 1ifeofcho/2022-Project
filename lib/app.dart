import 'package:flutter/material.dart';
import 'package:project/home.dart';
import 'package:project/pages/checklist.dart';
import 'package:project/pages/login.dart';
import 'package:project/pages/mainpage.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project',
      navigatorKey: navigatorKey,
      home: const Home(),
      theme: ThemeData(primarySwatch: Colors.teal),
      routes: {
        '/main': (context) => const MainPage(),
        '/login': (context) => const LoginPage(),
        '/checklist': (context) => const Checklist(),
      }
    );
  }
}
