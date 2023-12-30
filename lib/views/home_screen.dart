import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_flutter/controllers/theme_controller.dart';
import '../components/app_bar.dart';
import '../components/weather_card.dart';
import '../constants.dart';
import '../controllers/weather_controller.dart';
import '../routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    WeatherController weatherController =
        Provider.of<WeatherController>(context, listen: false);

    // Fetch weather for cities when the app starts
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

    return Scaffold(
      appBar: AppBarData(text: "Dashboard", actions: [
        IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.profile);
            },
            icon: Icon(Icons.person))
      ]),
      body: Consumer<WeatherController>(
        builder: (context, weatherController, child) {
          if (weatherController.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return WeatherList();
          }
        },
      ),
    );
  }
}
