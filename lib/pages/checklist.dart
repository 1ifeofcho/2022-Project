import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project/widget/color.dart';
import 'package:project/widget/largetext.dart';
import 'package:project/widget/smalltext.dart';

class Checklist extends StatefulWidget {
  const Checklist({Key? key}) : super(key: key);

  @override
  State<Checklist> createState() => _ChecklistState();
}

class _ChecklistState extends State<Checklist> {
  bool ready = false;
  List<Map> selectChoices = [
    {'choice': 'Hiking Boots', "isChecked": false},
    {'choice': 'Sun Screen', "isChecked": false},
    {'choice': 'Rain Gear', "isChecked": false},
    {'choice': 'First Aid Kit', "isChecked": false},
    {'choice': 'Navigator', "isChecked": false},
  ];

  void areyouReady() {
    int flag = 0;
    for (int i = 0; i < selectChoices.length; i++) {
      if (selectChoices[i]['isChecked']) {
        flag++;
      }
      if (flag < selectChoices.length) {
        ready = false;
      } else if (flag == selectChoices.length) {
        ready = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  child: ready
                      ? Lottie.asset('assets/finish.json', fit: BoxFit.fill)
                      : Lottie.asset('assets/traveler.json', fit: BoxFit.fill),
                ),
              ),
            ),
            Positioned(
              top: 330,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 500,
                decoration: BoxDecoration(
                    color: AppColor.medTeal,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ready
                              ? LargeText(
                                  text: "You are ready to GO!!",
                                  color: AppColor.light)
                              : LargeText(
                                  text: "Any missing equiments ??",
                                  color: AppColor.light)
                        ],
                      ),
                      const SizedBox(height: 5),
                      Column(
                          children: selectChoices.map((choice) {
                        return CheckboxListTile(
                            tileColor: Colors.white,
                            activeColor: AppColor.light,
                            value: choice["isChecked"],
                            title: SmallText(
                                text: choice["choice"], color: AppColor.light),
                            onChanged: (newValue) {
                              setState(() {
                                choice["isChecked"] = newValue;
                                areyouReady();
                              });
                            });
                      }).toList()),
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
