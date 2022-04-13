import 'package:flutter/material.dart';
import 'package:splign_p2m/profile/profile_screen.dart';
import 'package:theme_provider/theme_provider.dart';

class Theame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      child: ThemeConsumer(
        child: Builder(
          builder: (themeContext) => MaterialApp(
            theme: ThemeProvider.themeOf(themeContext).data,
            title: 'Material App',
            home: ProfileScreen(),
          ),
        ),
      ),
    );
  }
}
