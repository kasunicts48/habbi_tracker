import 'package:flutter/material.dart';
import 'package:habbi_tracker/constants/colors.dart';
import 'package:habbi_tracker/constants/description.dart';
import 'package:habbi_tracker/services/auth.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // ref for the AuthService class
  final AuthServices _authServices = AuthServices();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: bgBlack,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: bgBlack,
          foregroundColor: Colors.white,
          actions: [
            IconButton(
              onPressed: () async {
                await _authServices.signOut();
              },
              style: ButtonStyle(
                foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
              ),
              icon: const Icon(Icons.logout),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              children: [
                const Text(
                  "Home",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w800),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: textLight,
                      fontSize: 10,
                      fontWeight: FontWeight.w300),
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: Image.asset(
                    'assets/images/android-logo.png',
                    height: 250,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
