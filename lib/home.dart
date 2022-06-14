import 'package:flutter/material.dart';
import 'package:project/pages/login.dart';
import 'package:project/pages/mainpage.dart';
import 'package:project/provider/loginprovider.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(builder: (context, provider, _) {
      if (provider.user != null) {
        return const MainPage();
      } else {
        return const LoginPage();
      }
    });
  }
}
