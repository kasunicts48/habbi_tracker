import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habbi_tracker/services/auth.dart';
import 'package:provider/provider.dart';

import '../theme/theme_provider.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    // ref for the AuthService class
    final AuthServices _authServices = AuthServices();
    return Drawer(
      // ignore: deprecated_member_use
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          Center(
            child: IconButton(
              onPressed: () async {
                await _authServices.signOut();
              },
              color: Theme.of(context).colorScheme.inversePrimary,
              icon: const Icon(Icons.logout),
            ),
          ),
          Center(
            child: CupertinoSwitch(
              value: Provider.of<ThemeProvider>(context).isDarkMode,
              onChanged: (value) =>
                  Provider.of<ThemeProvider>(context, listen: false)
                      .toggleTheme(),
            ),
          ),
        ],
      ),
    );
  }
}
