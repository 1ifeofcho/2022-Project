import 'package:flutter/material.dart';
import 'package:project/service/location.dart';
import 'package:project/service/network.dart';
import 'package:weather_icons/weather_icons.dart';

const apiKey = 'c1c5516b51ed005596c134301917d4a4';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Object getWeatherIcon(int condition) {
    if (condition < 300) {
      return const BoxedIcon(WeatherIcons.thunderstorm,
          size: 80); // Thunder Storm
    } else if (condition < 400) {
      return const BoxedIcon(WeatherIcons.showers, size: 100); // Drizzle Rain
    } else if (condition < 600) {
      return const BoxedIcon(WeatherIcons.rain, size: 100); // Rain
    } else if (condition < 700) {
      return const BoxedIcon(WeatherIcons.snow, size: 100); //Snow
    } else if (condition < 800) {
      return const BoxedIcon(WeatherIcons.fog, size: 100); //Fog
    } else if (condition == 800) {
      return const BoxedIcon(WeatherIcons.day_sunny, size: 100); //Clear Sky
    } else if (condition <= 804) {
      return const BoxedIcon(WeatherIcons.cloudy, size: 100); // cloudy
    } else {
      return Icons.not_accessible; // Not available
    }
  }

  String getMessage(int condition) {
    if (condition < 300) {
      return "Maybe Stay Home Today.. "; // Thunder Storm
    } else if (condition < 400) {
      return "Do not forget to take your rain coat"; // Drizzle Rain
    } else if (condition < 600) {
      return "Watch your steps while you hike!!"; // Rain
    } else if (condition < 700) {
      return "Snowing? Just stay home !"; //Snow
    } else if (condition < 800) {
      return "Foggy day but why not?"; //Fog
    } else if (condition == 800) {
      return "Great day to hike !! "; //Clear Sky
    } else if (condition <= 804) {
      return "Gloomy mood, so why not hike ? "; // cloudy
    } else {
      return "Weather Error.. "; // Not available
    }
  }
}
