import 'package:flutter/material.dart';
import 'package:project/provider/loginprovider.dart';
import 'package:project/widget/largetext.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/image.jpeg'), fit: BoxFit.cover)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              LargeText(text: "Are You Ready to Hike?", color: Colors.white),
              const SizedBox(height: 70),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(primary: Colors.teal.shade400),
                label: const Text('Google Login'),
                icon: const Icon(Icons.login),
                onPressed: () {
                  Provider.of<LoginProvider>(context, listen: false)
                      .googleLogin();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
