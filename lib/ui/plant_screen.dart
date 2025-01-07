
/*
import 'package:flutter/material.dart';
import 'package:plantapp/ui/cooking_recipes_screen.dart';
import '../app_localizations.dart';

class PlantScreen extends StatelessWidget {
  final String plantName;
  final String plantImage;

  PlantScreen({super.key, required this.plantName, required this.plantImage});

  @override
  Widget build(BuildContext context) {
    debugPrint('Building PlantScreen with plantName: $plantName, plantImage: $plantImage');
    
    var localizer = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF32C773),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            debugPrint('Back button pressed');
            Navigator.pop(context);
          },
        ),
        title: Text(
          localizer.translate("details") ?? "Details",
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Plant Image
              Container(
                margin: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    plantImage,
                    height: MediaQuery.of(context).size.height / 3,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Plant Details
              buildIconBoxWithArrow(
                context,
                icon: Icons.grass,
                title: localizer.translate(plantName) ?? plantName,
                subtitle: localizer.translate("${plantName}Desc") ?? "Description not available",
                nextPage: NextPage(
                  title: localizer.translate("${plantName}Desc") ?? "Description not available",
                ),
              ),
              buildIconBoxWithArrow(
                context,
                icon: Icons.warning_amber_rounded,
                title: localizer.translate("toxicity") ?? "Toxicity",
                subtitle: localizer.translate("${plantName}Toxicity") ?? "No toxicity data available",
                nextPage: NextPage(
                  title: localizer.translate("${plantName}Toxicity") ?? "No toxicity data available",
                ),
              ),
              buildIconBoxWithArrow(
                context,
                icon: Icons.health_and_safety,
                title: localizer.translate("benefits") ?? "Benefits",
                subtitle: localizer.translate("${plantName}Benefits") ?? "No benefits data available",
                nextPage: NextPage(
                  title: localizer.translate("${plantName}Benefits") ?? "No benefits data available",
                ),
              ),
              buildIconBoxWithArrow(
                context,
                icon: Icons.restaurant_menu,
                title: localizer.translate("cookingRecipes") ?? "Cooking Recipes",
                subtitle: localizer.translate("${plantName}Cooking") ?? "No cooking recipes available",
                nextPage: CookingRecipesScreen(plantName: plantName),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildIconBoxWithArrow(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? subtitle,
    required Widget nextPage,
  }) {
    debugPrint('Building icon box: $title');
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, size: 40, color: const Color(0xFF32C773)),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 5),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              debugPrint('Navigating to $title');
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => nextPage),
              );
            },
            child: const Icon(
              Icons.arrow_forward_ios,
              color: Color(0xFF32C773),
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}

class NextPage extends StatelessWidget {
  final String title;

  const NextPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    debugPrint('NextPage: $title');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF32C773),
        title: Text(title),
      ),
      body: Center(
        child: Text(
          title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}



*/




import 'package:flutter/material.dart';
import 'package:plantapp/ui/cooking_recipes_screen.dart';
import '../app_localizations.dart';

class PlantScreen extends StatelessWidget {
  final String plantName;
  final String plantImage;

  PlantScreen({super.key, required this.plantName, required this.plantImage});

  @override
  Widget build(BuildContext context) {
    debugPrint('Building PlantScreen with plantName: $plantName, plantImage: $plantImage');
    
    var localizer = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF32C773),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            debugPrint('Back button pressed');
            Navigator.pop(context);
          },
        ),
        title: Text(
          localizer.translate("details") ?? "Details",
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Plant Image
              Container(
                margin: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    plantImage,
                    height: MediaQuery.of(context).size.height / 3,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Plant Details
              buildIconBox(
                context,
                icon: Icons.grass,
                title: localizer.translate(plantName) ?? plantName,
                subtitle: localizer.translate("${plantName}Desc") ?? "Description not available",
              ),
              buildIconBox(
                context,
                icon: Icons.warning_amber_rounded,
                title: localizer.translate("toxicity") ?? "Toxicity",
                subtitle: localizer.translate("${plantName}Toxicity") ?? "No toxicity data available",
              ),
              buildIconBox(
                context,
                icon: Icons.health_and_safety,
                title: localizer.translate("benefits") ?? "Benefits",
                subtitle: localizer.translate("${plantName}Benefits") ?? "No benefits data available",
              ),
              buildIconBoxWithArrow(
                context,
                icon: Icons.restaurant_menu,
                title: localizer.translate("cookingRecipes") ?? "Cooking Recipes",
                subtitle: localizer.translate("${plantName}Cooking") ?? "No cooking recipes available",
                nextPage: CookingRecipesScreen(plantName: plantName),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildIconBox(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? subtitle,
  }) {
    debugPrint('Building icon box: $title');
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, size: 40, color: const Color(0xFF32C773)),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 5),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildIconBoxWithArrow(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? subtitle,
    required Widget nextPage,
  }) {
    debugPrint('Building icon box with arrow: $title');
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, size: 40, color: const Color(0xFF32C773)),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 5),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              debugPrint('Navigating to $title');
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => nextPage),
              );
            },
            child: const Icon(
              Icons.arrow_forward_ios,
              color: Color(0xFF32C773),
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}

class NextPage extends StatelessWidget {
  final String title;

  const NextPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    debugPrint('NextPage: $title');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF32C773),
        title: Text(title),
      ),
      body: Center(
        child: Text(
          title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

