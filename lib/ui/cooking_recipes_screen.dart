import 'package:flutter/material.dart';
import '../app_localizations.dart';

class CookingRecipesScreen extends StatelessWidget {
  final String plantName;

  const CookingRecipesScreen({
    Key? key,
    required this.plantName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var localizer = AppLocalizations.of(context)!;

    // Fetch and validate the recipes data
    final recipesData = localizer.translate("recipes");
    if (recipesData is! List<dynamic>) {
      return _buildErrorScreen('Invalid recipes data');
    }

    final recipes = recipesData;

    // Normalize the plant name
    final normalizedPlantName = plantName.trim().toLowerCase();

    // Find the recipe matching the plant name
    final plantDetails = recipes.firstWhere(
      (recipe) => (recipe["name"] as String).toLowerCase() == normalizedPlantName,
      orElse: () => null,
    );

    if (plantDetails == null) {
      return _buildErrorScreen('Plant recipe not found for $normalizedPlantName');
    }

    final recipeName = plantDetails["cookingRecipesData"]?['name_ar'] ?? plantDetails["cookingRecipesData"]?['name'];
    if (recipeName == null || recipeName is! String || recipeName.trim().isEmpty) {
      return _buildErrorScreen(localizer.translate("recipeNameNotFound") ?? 'اسم الوصفة غير موجود');
    }

    final ingredients = plantDetails["cookingRecipesData"]?['ingredients'] ?? [];
    final steps = plantDetails["cookingRecipesData"]?['steps'] ?? [];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF32C773),
        title: Text(' ${localizer.translate("cookingRecipes")}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildRecipeImage(plantDetails["image"]),
            _buildRecipeTitle(recipeName, plantDetails),
            _buildRecipeTabs(ingredients, steps, localizer),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorScreen(String errorMessage) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF32C773),
        title: const Text('Error'),
      ),
      body: Center(
        child: Text(
          errorMessage,
          style: const TextStyle(color: Colors.red, fontSize: 20),
        ),
      ),
    );
  }

  Widget _buildRecipeImage(String? imagePath) {
    return Stack(
      children: [
        Container(
          height: 200,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imagePath != null && imagePath.isNotEmpty
                  ? AssetImage(imagePath)
                  : const AssetImage('assets/default_recipe_image.png'),
              fit: BoxFit.cover,
            ),
          ),
          foregroundDecoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black54, Colors.transparent],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ),
        Positioned(
          top: 20,
          right: 20,
          child: IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.white, size: 30),
            onPressed: () {
              // Add to favorite functionality
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRecipeTitle(String recipeName, Map<String, dynamic> plantDetails) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            recipeName,
            textDirection: TextDirection.rtl, // Added to support Arabic
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RecipeDetail(icon: Icons.access_time, text: plantDetails["time"] ?? 'N/A'),
              RecipeDetail(icon: Icons.list_alt, text: '${plantDetails["ingredientsCount"] ?? 0} '),
              RecipeDetail(icon: Icons.stairs, text: plantDetails["difficulty"] ?? 'Unknown'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecipeTabs(List<dynamic> ingredients, List<dynamic> steps, AppLocalizations localizer) {
    return DefaultTabController(
      length: 2,
      child: Builder(
        builder: (context) {
          return Column(
            children: [
              TabBar(
                labelColor: Colors.green,
                unselectedLabelColor: Colors.black54,
                indicatorColor: Colors.green,
                tabs: [
                  Tab(text: localizer.translate("ingredients") ?? "Ingredients"),
                  Tab(text: localizer.translate("directions") ?? "Directions"),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5, // Dynamic height
                child: TabBarView(
                  children: [
                    _buildIngredientsList(ingredients),
                    _buildStepsList(steps),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildIngredientsList(List<dynamic> ingredients) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ListView.separated(
        itemCount: ingredients.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          final ingredient = ingredients[index];
          if (ingredient is! String) {
            // Ensure the ingredient is a string
            return const Text('Invalid ingredient format');
          }
          return ListTile(
            leading: const Icon(
              Icons.check_circle_outline,
              size: 24,
              color: Colors.green,
            ),
            title: Text(
              ingredient,
              textDirection: TextDirection.rtl, // Added for Arabic
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStepsList(List<dynamic> steps) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ListView.separated(
        itemCount: steps.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          final step = steps[index];
          if (step is! Map<String, dynamic> || step["description"] is! String) {
            // Ensure the step is a map with a valid description
            return const Text('Invalid step format');
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                title: Text(
                  step["description"],
                  textDirection: TextDirection.rtl, // Added for Arabic
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              if (step["image"] != null && step["image"] is String && (step["image"] as String).isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Image.asset(
                    step["image"],
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class RecipeDetail extends StatelessWidget {
  final IconData icon;
  final String text;

  const RecipeDetail({Key? key, required this.icon, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.green),
        const SizedBox(width: 5),
        Text(
          text,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
























