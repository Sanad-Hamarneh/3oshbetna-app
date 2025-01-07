
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../app_localizations.dart'; // Import localization class
import 'plant_screen.dart'; // Import PlantScreen for navigation

class ScanScreen extends StatefulWidget {
  final List<Map<String, String>> plants = [
    {"name": "MilkThistle", "image": "images/Home_Screen/Milk_thistle.jpg"},
    {"name": "Cheeseweed", "image": "images/Home_Screen/cheeseweed_img.jpg"},
    {"name": "Nettles", "image": "images/Home_Screen/Nettles_img.jpg"},
    {"name": "Ecballium", "image": "images/Home_Screen/Ecballium_img.jpg"},
    {"name": "Parsley", "image": "images/Home_Screen/parsley_home.jpg"},
    {"name": "Coriander", "image": "images/Home_Screen/Coriander_home.jpg"},
    {"name": "Oleander", "image": "images/Home_Screen/oleander_home.jpg"},
  ];

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  List<dynamic>? _predictions;
  String _selectedModel = "model1Name";

  final List<Map<String, dynamic>> models = [
    {
      "name": "model1Name",
      "description": "model1Description",
      "icon": Icons.eco,
    },
    {
      "name": "model2Name",
      "description": "model2Description",
      "icon": Icons.nature_people,
    },
  ];

  Future<void> _uploadImage(File image) async {
    final uri = Uri.parse("http://192.168.0.34:5000/upload"); // Replace with your API URL
    var request = http.MultipartRequest('POST', uri);

    // Add selected model as a field
    request.fields['model'] = _selectedModel;

    // Attach the image file
    request.files.add(await http.MultipartFile.fromPath('image', image.path));

    try {
      // Send the request
      var response = await request.send();

      // Check response status
      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        var json = jsonDecode(responseData);

        setState(() {
          _predictions = json['predictions']; // Store predictions
        });
      } else {
        // Log error response for debugging
        var responseBody = await response.stream.bytesToString();
        print("Error Response: $responseBody");

        _showErrorSnackbar(
          "${AppLocalizations.of(context)!.translate('uploadFailed')} ${response.statusCode}: $responseBody",
        );
      }
    } catch (e) {
      print("Upload Error: $e");
      _showErrorSnackbar(AppLocalizations.of(context)!.translate("uploadError"));
    }
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 4),
      ),
    );
  }

  Future<void> _pickImage(BuildContext context, ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = pickedFile;
      });
      _uploadImage(File(_image!.path));
    }
  }

  void _resetScan() {
    setState(() {
      _image = null;
      _predictions = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    var localizer = AppLocalizations.of(context)!;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            localizer.translate("scanTitle"),
            style: const TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          elevation: 1,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Model Selection Section
              Text(
                localizer.translate("selectModel"),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: models.map((model) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedModel = model["name"]!;
                      });
                    },
                    child: Card(
                      elevation: 3,
                      color: _selectedModel == model["name"]
                          ? Colors.green[100]
                          : Colors.white,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            Icon(
                              model["icon"] as IconData,
                              size: 50,
                              color: Colors.green,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              localizer.translate(model["name"]!), // Localized
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              localizer.translate(model["description"]!), // Localized
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),

              // Image Preview Section
              _image == null
                  ? Container(
                      width: double.infinity,
                      height: 300,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          localizer.translate("noImageSelected"), // Localized
                          style: const TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ),
                    )
                  : Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                              File(_image!.path),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        if (_predictions != null && _predictions!.isNotEmpty)
                          Text(
                            _predictions![0]['confidence'] * 100 >= 85.0
                                ? localizer.translate("plants.${_predictions![0]['label']}")
                                : localizer.translate("unknown"),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                      ],
                    ),
              const SizedBox(height: 20),
              _predictions != null
                  ? Column(
                      children: [
                        for (var i = 0; i < _predictions!.take(3).length; i++)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    "${localizer.translate("plants.${_predictions![i]['label']}" ?? "unknown")}: ", // Localized plant name
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: LinearProgressIndicator(
                                    value: _predictions![i]['confidence'],
                                    backgroundColor: Colors.grey[300],
                                    color: Colors.green,
                                    minHeight: 8,
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    " ${(_predictions![i]['confidence'] * 100).toStringAsFixed(1)}%",
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        const SizedBox(height: 20),

                        // See Details Button
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  final predictedPlant = _predictions![0]['confidence'] * 100 >= 75.0
                                      ? widget.plants.firstWhere(
                                          (plant) =>
                                              plant['name']!.toLowerCase() ==
                                              _predictions![0]['label']
                                                  .toLowerCase(),
                                          orElse: () => {
                                            "name": localizer.translate("unknown"),
                                            "image": "images/Scan_Screen/unkown.jpg"
                                          },
                                        )
                                      : {
                                          "name": localizer.translate("unknown"),
                                          "image": "images/Scan_Screen/unkown.jpg"
                                        };
                                  return PlantScreen(
                                    plantName: predictedPlant['name']!,
                                    plantImage: predictedPlant['image']!,
                                  );
                                },
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green, // Changed button color
                          ),
                          child: Text(localizer.translate("seeDetails")),
                        ),
                        const SizedBox(height: 10),

                        // Retry Button
                        ElevatedButton(
                          onPressed: _resetScan,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          child: Text(localizer.translate("retryScan")),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        ElevatedButton.icon(
                          onPressed: () =>
                              _pickImage(context, ImageSource.camera),
                          icon: const Icon(Icons.camera_alt),
                          label: Text(localizer.translate("openCamera")),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            backgroundColor: Colors.green,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(localizer.translate("or")), // Localized
                        const SizedBox(height: 12),
                        ElevatedButton.icon(
                          onPressed: () =>
                              _pickImage(context, ImageSource.gallery),
                          icon: const Icon(Icons.photo_library),
                          label: Text(localizer.translate("chooseFromGallery")),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            backgroundColor: Colors.green,
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}



