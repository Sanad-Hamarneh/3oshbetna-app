import 'package:flutter/material.dart';
import '../app_localizations.dart'; // Import your localization class
import 'package:plantapp/ui/home_screen.dart';


class WelcomeScreen extends StatelessWidget {
  final Function(Locale) onChangeLanguage;

  const WelcomeScreen({super.key, required this.onChangeLanguage});

  @override
  Widget build(BuildContext context) {
    var localizer = AppLocalizations.of(context)!; // Fetch localized text

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.language, color: Colors.black),
            onPressed: () {
              final currentLocale = Localizations.localeOf(context);
              final newLocale = currentLocale.languageCode == 'en'
                  ? const Locale('ar', '')
                  : const Locale('en', '');
              onChangeLanguage(newLocale);
            },
          ),
        ],
      ),
      body: Material(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Image.asset(
              "images/Welcome_Screen/grass-logo-free-vector.jpg",
              fit: BoxFit.cover,
              scale: 1.3,
            ),
            const SizedBox(height: 5),
            // App Name
            Text(
              localizer.translate("appName"), // Fetch "appName" from JSON
              style: const TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                wordSpacing: 1,
                color: Color(0xFF4CAF50),
              ),
            ),
            const SizedBox(height: 20),
            // Description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Text(
                localizer.translate("welcomeSubtitle"), // Fetch "welcomeSubtitle" from JSON
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey.shade800,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 35),
            // Button
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      spreadRadius: 3,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    localizer.translate("buttonTap"), // Fetch "buttonTap" from JSON
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}





