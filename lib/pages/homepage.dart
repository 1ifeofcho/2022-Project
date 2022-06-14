import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:project/pages/city.dart';
import 'package:project/pages/detail.dart';
import 'package:project/provider/loginprovider.dart';
import 'package:project/service/weather.dart';
import 'package:project/widget/color.dart';
import 'package:project/widget/largetext.dart';
import 'package:project/widget/smalltext.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherModel weather = WeatherModel();
  late int temperature;
  // ignore: prefer_typing_uninitialized_variables
  late var weatherIcon;
  late String cityName;
  late String weatherMessage;
  // ignore: prefer_typing_uninitialized_variables
  var weatherData;

  static const colorizeColors = [
    Colors.purple,
    Colors.blue,
    Colors.yellow,
    Colors.red,
  ];

  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    weatherData = await WeatherModel().getLocationWeather();
    updateUI(weatherData);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = const Icon(Icons.not_accessible);
        weatherMessage = 'Unable to get weather data';
        cityName = '';
        return;
      }
      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      var condition = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);
      weatherMessage = weather.getMessage(condition);
      cityName = weatherData['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(
      builder: (context, provider, _) => Scaffold(
        body: ListView(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height:150,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(width: 20.0, height: 100.0),
                            LargeText(text: provider.currentUser!.name, color: AppColor.darkTeal, size: 40),
                            const SizedBox(width: 20.0, height: 100.0),
                            DefaultTextStyle(
                              style: TextStyle(
                                fontSize: 40.0,
                                fontFamily: 'Horizon',
                                color: AppColor.darkTeal,
                              ),
                              child: AnimatedTextKit(
                                animatedTexts: [
                                  RotateAnimatedText('Are'),
                                  RotateAnimatedText('You'),
                                  RotateAnimatedText('Ready'),
                                  RotateAnimatedText('To'),
                                  RotateAnimatedText('Hike!'),
                                ],
                                totalRepeatCount: 4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
                padding:
                    const EdgeInsets.only(top: 16.0, left: 20.0, right: 16.0),
                child: LargeText(
                    text: "Explore With Us", color: AppColor.norTeal)),
            Container(
              padding: const EdgeInsets.only(left: 20),
              height: 200,
              width: double.maxFinite,
              child: ListView.builder(
                itemCount: provider.mountains.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, index) {
                  return Stack(
                    children: [
                      Container(
                        width: 300,
                        height: 200,
                        margin: const EdgeInsets.only(right: 15, top: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          image: DecorationImage(
                              image:
                                  NetworkImage(provider.mountains[index].url),
                              fit: BoxFit.cover),
                        ),
                      ),
                      Positioned(
                        top: 160,
                        left: 20,
                        child: SmallText(
                          text: provider.mountains[index].name,
                          color: Colors.white70,
                        ),
                      ),
                      Positioned(
                        top: 160,
                        right: 20,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return DetailPage(
                                      mountain: provider.mountains[index]);
                                },
                              ),
                            );
                          },
                          child: SmallText(
                            text: "More",
                            color: Colors.white70,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 16.0, left: 20.0, right: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LargeText(text: "Check Weather", color: AppColor.norTeal),
                  IconButton(
                      onPressed: () async {
                        var typedName = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return CityScreen();
                            },
                          ),
                        );
                        if (typedName != null) {
                          var weatherData =
                              await weather.getCityWeather(typedName);
                          updateUI(weatherData);
                        }
                      },
                      icon: Icon(
                        Icons.search,
                        color: AppColor.norTeal,
                      ))
                ],
              ),
            ),
            weatherData == null
                ? const Center(
                    child: CircularProgressIndicator(
                    color: Colors.white,
                  ))
                : Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Stack(
                      children: [
                        Center(
                          child: Container(
                            width: 400,
                            height: 200,
                            decoration: BoxDecoration(
                              color: AppColor.light.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: 20,
                          child: weatherIcon,
                        ),
                        Positioned(
                          top: 50,
                          right: 20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SmallText(
                                text: '$temperature°',
                                size: 40,
                                color: AppColor.darkTeal,
                              ),
                              const SizedBox(height: 30),
                              SmallText(
                                text: cityName,
                                size: 18,
                                color: AppColor.darkTeal,
                              ),
                              const SizedBox(height: 10),
                              SmallText(text: weatherMessage),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}


// Flexible(
//               child: GridView.builder(
//                 padding: const EdgeInsets.all(16.0),
//                 physics: const AlwaysScrollableScrollPhysics(),
//                 itemCount: provider.mountains.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   return Card(
//                     clipBehavior: Clip.antiAlias,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         AspectRatio(
//                           aspectRatio: 18 / 11,
//                           child: Image.network(
//                             provider.mountains[index].url,
//                             fit: BoxFit.fitWidth,
//                           ),
//                         ),
//                         Expanded(
//                           child: Padding(
//                             padding: const EdgeInsets.fromLTRB(
//                                 16.0, 12.0, 16.0, 8.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: <Widget>[
//                                 Text(
//                                   provider.mountains[index].name,
//                                   style: const TextStyle(
//                                       fontWeight: FontWeight.bold),
//                                   maxLines: 1,
//                                 ),
//                                 const SizedBox(height: 4.0),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 1,
//                   childAspectRatio: 8.0 / 9.0,
//                 ),
//               ),
//             ),