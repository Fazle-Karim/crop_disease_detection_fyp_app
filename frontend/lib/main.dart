import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FYP AI App',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? _image;
  String result = "";
  bool loading = false;
  
  // New variables for better UI
  String _prediction = "";
  double _confidence = 0.0;

  Future pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      setState(() {
        _image = File(picked.path);
        result = "";
        _prediction = "";
        _confidence = 0.0;
      });
    }
  }

  Future predict() async {
    if (_image == null) return;

    setState(() {
      loading = true;
    });

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse("http://10.0.2.2:8000/predict"), // Android emulator localhost
      );

      request.files.add(
        await http.MultipartFile.fromPath('file', _image!.path),
      );

      var response = await request.send();
      var responseData = await response.stream.bytesToString();
      var jsonData = json.decode(responseData);

      setState(() {
        loading = false;
        
        // Store prediction and confidence separately
        _prediction = jsonData['prediction'];
        _confidence = jsonData['confidence'].toDouble();
        
        // Also store for backward compatibility
        result = "Prediction: $_prediction\nConfidence: $_confidence%";
      });
    } catch (e) {
      setState(() {
        loading = false;
        result = "Error: $e";
      });
    }
  }

  // Helper function to get colors based on confidence
  List<Color> _getConfidenceColors(double confidence) {
    if (confidence >= 80) {
      return [Colors.green.shade400, Colors.green.shade600];
    } else if (confidence >= 60) {
      return [Colors.orange.shade400, Colors.orange.shade600];
    } else {
      return [Colors.red.shade400, Colors.red.shade600];
    }
  }
  
  // Helper function to get text color based on confidence
  Color _getConfidenceTextColor(double confidence) {
    if (confidence >= 80) {
      return Colors.green.shade700;
    } else if (confidence >= 60) {
      return Colors.orange.shade700;
    } else {
      return Colors.red.shade700;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("FYP AI Image Classifier")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Image display area
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: _image != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        _image!,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    )
                  : const Center(
                      child: Text("No image selected"),
                    ),
            ),

            const SizedBox(height: 20),

            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: pickImage,
                  child: const Text("Upload Image"),
                ),
                ElevatedButton(
                  onPressed: predict,
                  child: const Text("Predict"),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Results area with enhanced UI
            Expanded(
              child: SingleChildScrollView(
                child: loading
                    ? Column(
                        children: [
                          const CircularProgressIndicator(),
                          const SizedBox(height: 10),
                          const Text("Analyzing image..."),
                        ],
                      )
                    : result.isNotEmpty
                        ? Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Prediction
                                const Text(
                                  "PREDICTION",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _prediction,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                
                                const SizedBox(height: 16),
                                
                                // Confidence label
                                const Text(
                                  "CONFIDENCE",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                
                                // Confidence bar with color coding
                                Stack(
                                  children: [
                                    Container(
                                      height: 24,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    Container(
                                      height: 24,
                                      width: MediaQuery.of(context).size.width * 0.8 * (_confidence / 100),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        gradient: LinearGradient(
                                          colors: _getConfidenceColors(_confidence),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                
                                const SizedBox(height: 8),
                                
                                // Confidence percentage
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "0%",
                                      style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                                    ),
                                    Text(
                                      "${_confidence.toStringAsFixed(1)}%",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: _getConfidenceTextColor(_confidence),
                                      ),
                                    ),
                                    Text(
                                      "100%",
                                      style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        : const SizedBox.shrink(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}