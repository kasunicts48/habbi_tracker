import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:habbi_tracker/database/habit_database.dart';
import 'package:habbi_tracker/models/user_model.dart';
import 'package:habbi_tracker/screens/wrapper.dart';
import 'package:habbi_tracker/services/auth.dart';
import 'package:habbi_tracker/theme/theme_provider.dart';
import 'package:provider/provider.dart';

// import 'package:habbi_tracker/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

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
    return StreamProvider<UserModel?>.value(
      initialData: UserModel(uid: ""),
      value: AuthServices().user,
      child: MaterialApp(
        theme: Provider.of<ThemeProvider>(context).themeData,
        debugShowCheckedModeBanner: false,
        home: const Wrapper(),
      ),
    );
  }
}
