import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../controllers/weather_controller.dart';
import '../models/weather_data_model.dart';

// weather list card in grid view
class WeatherList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    WeatherController weatherController =Provider.of<WeatherController>(context);

    return RefreshIndicator(

      onRefresh: () async {

        // on refresh get updated data
        weatherController.fetchWeatherForCities(
          cities: cities,
          showError: (errorMessage) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(errorMessage),
              ),
            );
          },
        );

      },

      child: GridView.builder(

        physics: BouncingScrollPhysics(),

        padding: EdgeInsets.all(8.0),

        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Set the number of items in each row
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),

        itemCount: weatherController.weatherList.length,

        itemBuilder: (context, index) {
          Weather weather = weatherController.weatherList[index];

          return WeatherCard(
            weatherIcon: "${weather.icon}",
            temperature: weather.temp as double,
            location: weather.city as String,
            description: weather.description as String,
          );

        },
      ),
    );
  }
}

// weather card
class WeatherCard extends StatelessWidget {
  final String weatherIcon;
  final double temperature;
  final String location;
  final String description;

  WeatherCard({
    required this.weatherIcon,
    required this.temperature,
    required this.location,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    String icon =
        'https://api.openweathermap.org/img/w/$weatherIcon.png'; // => to get icon from open weather
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      margin: EdgeInsets.all(0.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            AnimatedContainer(
              duration: Duration(seconds: 1),
              curve: Curves.easeInOutBack,
              child: Image.network(
                icon,
                width: 72.0,
                height: 72.0,
                color: _getIconColor(),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              '$temperature°C',
              style: TextStyle(
                fontSize: 18.0,
                color: _getTemperatureColor(),
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              location,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              description,
              style: TextStyle(
                fontSize: 14.0,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getIconColor() {
    // Change icon color based on temperature
    if (temperature < 10) {
      return Colors.blue;
    } else if (temperature < 25) {
      return Colors.yellow;
    } else {
      return Colors.orange;
    }
  }

  Color _getTemperatureColor() {
    // Change text color based on temperature
    if (temperature < 10) {
      return Colors.blue;
    } else if (temperature < 25) {
      return Colors.black;
    } else {
      return Colors.red;
    }
  }
}
