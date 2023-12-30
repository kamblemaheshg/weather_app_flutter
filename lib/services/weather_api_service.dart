import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_data_model.dart';

class WeatherService {

  static const String apiKey =  'c40f63374482c9e5b4bfff011f1b8374'; //  API key
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5/weather'; //  API endpoint

  Future<Map<String, Weather>> getWeatherForCities(List<String> cities) async {

    Map<String, Weather> weatherData = {};

    for (String city in cities) {
      try {
        final response =
            await http.get(Uri.parse('$baseUrl?q=$city&appid=$apiKey'));

        if (response.statusCode == 200) {

          final decodedBody = json.decode(response.body);

          // kelvin to degree
          double kelvin = decodedBody['main']['temp'] as double;
          double degree = kelvin - 273.15;
          degree = double.parse(degree.toStringAsFixed(2));

          weatherData[city] = Weather(
            main: decodedBody['weather'][0]['main'],
            icon: decodedBody['weather'][0]['icon'],
            description: decodedBody['weather'][0]['description'],
            temp: degree,
          );

        } else {
          // Handle API errors
          throw Exception(
              'Error fetching weather for $city: ${response.statusCode}');
        }
      } catch (error) {
        print('Error fetching weather for $city: $error');
        rethrow;
      }
    }

    return weatherData;
  }
}
