
import 'package:flutter/material.dart';
import '../app_localizations.dart'; // Import localization class
import 'plant_screen.dart'; // For navigation to PlantScreen
import 'scan_screen.dart'; // For navigation to ScanScreen

class HomeScreen extends StatelessWidget {
  // List of plants
  final List<Map<String, String>> plants = [
    {"name": "MilkThistle", "image": "images/Home_Screen/Milk_thistle.jpg"},
    {"name": "Cheeseweed", "image": "images/Home_Screen/cheeseweed_img.jpg"},
    {"name": "Nettles", "image": "images/Home_Screen/Nettles_img.jpg"},
    {"name": "Ecballium", "image": "images/Home_Screen/Ecballium_img.jpg"},
    {"name": "Parsley", "image": "images/Home_Screen/parsley_home.jpg"},
    {"name": "Coriander", "image": "images/Home_Screen/Coriander_home.jpg"},
    {"name": "Oleander", "image": "images/Home_Screen/oleander_home.jpg"},
  ];

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var localizer = AppLocalizations.of(context)!; // Access localized strings

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4CAF50), // Green AppBar
        elevation: 0,
        title: Text(
          localizer.translate("appName"), // Fetch app name dynamically
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),

              // Explore Banner
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFF4CAF50), // Green background
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            localizer.translate("homeScreenTitle"), // "Explore New Plants!"
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            localizer.translate("homeScreenDates"), // "02 - 23 July"
                            style: const TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Image.asset(
                        'images/Home_Screen/topBar_chesseweed.jpg', // Placeholder image
                        height: 65,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Most Popular Section Title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(
                  localizer.translate("mostPopular"), // "Most Popular"
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Plant Cards
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: plants.length,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlantScreen(
                            plantName: localizer.translate(plants[index]["name"]!), // Fetch plant name
                            plantImage: plants[index]["image"]!,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                            child: Image.asset(
                              plants[index]["image"]!,
                              height: 120,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              localizer.translate(plants[index]["name"]!), // Fetch plant name dynamically
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PlantScreen(
                                    plantName: plants[index]["name"]!, // Fetch plant name
                                    plantImage: plants[index]["image"]!,
                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF4CAF50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            ),
                            child: Text(
                              localizer.translate("identifyNow"), // "Identify Now"
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),

      // Floating Action Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>  ScanScreen(),
            ),
          );
        },
        backgroundColor: const Color(0xFF4CAF50),
        child: const Icon(Icons.qr_code_scanner, color: Colors.white), // Scan icon
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // Bottom Navigation Bar
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 6,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.home, color: Color(0xFF4CAF50)),
              onPressed: () {
                // Home functionality
              },
            ),
            const SizedBox(width: 40), // Spacing for the FloatingActionButton
            IconButton(
              icon: const Icon(Icons.history, color: Color(0xFF4CAF50)),
              onPressed: () {
                print("History selected");
              },
            ),
          ],
        ),
      ),
    );
  }
}




