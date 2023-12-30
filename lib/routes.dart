import 'package:flutter/material.dart';
import 'package:weather_app_flutter/views/profile_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String profile = '/profile';

  static final Map<String, WidgetBuilder> routes = {
    profile: (context) => ProfileScreen(),
  };
}
