import 'package:flutter/material.dart';
import '../models/weather_data_model.dart';
import '../services/weather_api_service.dart';

class WeatherController extends ChangeNotifier {

  List<Weather> _weatherList = [];
  bool _isLoading = false;
  WeatherService _weatherService = WeatherService();

  List<Weather> get weatherList => _weatherList;
  bool get isLoading => _isLoading;

  Future<void> fetchWeatherForCities({
    required List<String> cities,
    required Function(String) showError,
  }) async {
    try {

      _isLoading = true;
      _weatherList.clear();

      Map<String, Weather> weatherData =
          await _weatherService.getWeatherForCities(cities);

      print("weather data is : $weatherData");

      for (String city in cities) {
        _weatherList.add(
          Weather(
            city: city,
            main: weatherData[city]?.main,
            description: weatherData[city]?.description,
            icon: weatherData[city]?.icon,
            temp: weatherData[city]?.temp,
          ),
        );

      }

      notifyListeners();
    } catch (error) {

      print('Error fetching weather: $error');
      showError('Failed to fetch weather data. Please try again later.');

    } finally {

      _isLoading = false;
      notifyListeners();

    }
  }
}
