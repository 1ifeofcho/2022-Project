// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:project/pages/checklist.dart';
import 'package:project/pages/compass.dart';
import 'package:project/pages/homepage.dart';
import 'package:project/pages/maps.dart';
import 'package:project/pages/mypage.dart';
import 'package:project/widget/color.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List pages = [
    HomePage(),
    Checklist(),
    MyMap(),
    Compass(),
    MyPage(),
  ];
  int currentPage = 0;
  void changePage(int index) {
    setState(() {
      currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentPage],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColor.darkTeal,
        unselectedItemColor: Colors.grey,
        currentIndex: currentPage,
        onTap: changePage,
        backgroundColor: AppColor.light,
        items: const [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.apps),
          ),
          BottomNavigationBarItem(
            label: "Self Check",
            icon: Icon(Icons.check),
          ),
          BottomNavigationBarItem(
            label: "Map",
            icon: Icon(Icons.map),
          ),
          BottomNavigationBarItem(
              label: "Compass", icon: Icon(Ionicons.compass)),
          BottomNavigationBarItem(
            label: "Exit",
            icon: Icon(Icons.exit_to_app),
          ),
        ],
      ),
    );
  }
}


// GridView.builder(
//           padding: const EdgeInsets.all(16.0),
//           physics: const AlwaysScrollableScrollPhysics(),
//           itemCount: provider.mountains.length,
//           itemBuilder: (BuildContext context, int index) {
//             return Card(
//               clipBehavior: Clip.antiAlias,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   AspectRatio(
//                     aspectRatio: 18 / 11,
//                     child: Image.network(
//                       provider.mountains[index].url,
//                       fit: BoxFit.fitWidth,
//                     ),
//                   ),
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           Text(
//                             provider.mountains[index].name,
//                             style: const TextStyle(fontWeight: FontWeight.bold),
//                             maxLines: 1,
//                           ),
//                           const SizedBox(height: 4.0),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 1,
//             childAspectRatio: 8.0 / 9.0,
//           ),
//         ),