import 'package:flutter/material.dart';
import 'package:habbi_tracker/database/habit_database.dart';
import 'package:habbi_tracker/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:habbi_tracker/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // initialize databse
  await HabitDatabase.initialize();
  await HabitDatabase().saveFirstLaunchDate();

  runApp(MultiProvider(
    providers: [
      // habit provider
      ChangeNotifierProvider(create: (context) => HabitDatabase()),

      // theme provider
      ChangeNotifierProvider(create: (context) => ThemeProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
