


import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; // Import this for localization
import 'app_localizations.dart'; // Custom localization delegate
import 'package:plantapp/ui/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('en', ''); // Default locale is English

  void _changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plant App',
      debugShowCheckedModeBanner: false,
      locale: _locale,
      supportedLocales: const [
        Locale('en', ''), // English
        Locale('ar', ''), // Arabic
      ],
      localizationsDelegates: const [
        AppLocalizationsDelegate(), // Custom Localization Delegate
        GlobalMaterialLocalizations.delegate, // For Material widgets
        GlobalWidgetsLocalizations.delegate, // For Widgets localization
        GlobalCupertinoLocalizations.delegate, // For Cupertino widgets
      ],
      home: WelcomeScreen(onChangeLanguage: _changeLanguage),
    );
  }
}
