import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_flutter/routes.dart';
import 'package:weather_app_flutter/views/home_screen.dart';
import 'controllers/theme_controller.dart';
import 'controllers/weather_controller.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => WeatherController()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Weather App',
            theme: themeProvider.currentTheme,
            home: HomeScreen(),
            initialRoute: AppRoutes.home,
            routes: AppRoutes.routes,
          );
        },
      ),
    );
  }
}
