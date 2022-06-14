import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String cityName = "";
  final TextEditingController _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: ListView(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 20,
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: _nameController,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  decoration: const InputDecoration(hintText: "Search City"),
                ),
              ),
              Center(
                child: Container(
                    child: Lottie.asset('assets/earth.json', fit: BoxFit.fill)),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, _nameController.text);
                },
                child: const Text(
                  'Get Weather',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
