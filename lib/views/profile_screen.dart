import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/app_bar.dart';
import '../controllers/theme_controller.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarData(
        text: "Profile",
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50.0,
              backgroundImage: AssetImage('assets/personal/profile_image.jpg'),
            ),
            SizedBox(height: 20.0),
            Text(
              'Mahesh Kamble',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text('themaheshkamble@gmail.com'),
            SizedBox(height: 30.0),
            Switch(
              value: Provider.of<ThemeProvider>(context).isDarkMode,
              onChanged: (value) {
                Provider.of<ThemeProvider>(context, listen: false)
                    .toggleTheme();
              },
            ),
            SizedBox(height: 10.0),
            Text('Dark Mode'),
          ],
        ),
      ),
    );
  }
}
