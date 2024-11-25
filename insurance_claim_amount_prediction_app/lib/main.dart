import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Insurance Claims Amount Predictor',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const PredictionPage(),
    );
  }
}

class PredictionPage extends StatefulWidget {
  const PredictionPage({super.key});

  @override
  State<PredictionPage> createState() => _PredictionPageState();
}

class _PredictionPageState extends State<PredictionPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController incomeController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController specialtyController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  final TextEditingController maritalStatusController = TextEditingController();
  final TextEditingController employmentStatusController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController claimTypeController = TextEditingController();
  final TextEditingController submissionMethodController = TextEditingController();
  final TextEditingController diagnosisCodeController = TextEditingController();
  final TextEditingController procedureCodeController = TextEditingController();

  String predictionResult = "";
  bool isLoading = false;

  Future<void> predictClaim() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
      predictionResult = "";
    });

    try {
      final response = await http.post(
        Uri.parse('https://health-claims-amount-1.onrender.com/predict'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'PatientAge': int.parse(ageController.text),
          'PatientIncome': double.parse(incomeController.text),
          'PatientGender': genderController.text,
          'ProviderSpecialty': specialtyController.text,
          'ClaimStatus': statusController.text,
          'PatientMaritalStatus': maritalStatusController.text,
          'PatientEmploymentStatus': employmentStatusController.text,
          'ProviderLocation': locationController.text,
          'ClaimType': claimTypeController.text,
          'ClaimSubmissionMethod': submissionMethodController.text,
          'DiagnosisCode': diagnosisCodeController.text,
          'ProcedureCode': procedureCodeController.text,
        }),
      );

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        setState(() {
          predictionResult = 
              'Predicted Claim Amount: \$${result['predicted_claim_amount'].toStringAsFixed(2)}';
        });
      } else {
        setState(() {
          predictionResult = 'Error: Failed to get prediction';
        });
      }
    } catch (e) {
      setState(() {
        predictionResult = 'Error: $e';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget _buildTextField(TextEditingController controller, String label, String hint) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: const OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Insurance Claims Amount Predictor'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextField(ageController, 'Patient Age', 'Enter age'),
              _buildTextField(incomeController, 'Patient Income', 'Enter annual income'),
              _buildTextField(genderController, 'Patient Gender', 'M or F'),
              _buildTextField(specialtyController, 'Provider Specialty', 'Enter specialty'),
              _buildTextField(statusController, 'Claim Status', 'Enter status'),
              _buildTextField(maritalStatusController, 'Marital Status', 'Enter marital status'),
              _buildTextField(employmentStatusController, 'Employment Status', 'Enter employment status'),
              _buildTextField(locationController, 'Provider Location', 'Enter location'),
              _buildTextField(claimTypeController, 'Claim Type', 'Enter claim type'),
              _buildTextField(submissionMethodController, 'Submission Method', 'Enter submission method'),
              _buildTextField(diagnosisCodeController, 'Diagnosis Code', 'Enter diagnosis code'),
              _buildTextField(procedureCodeController, 'Procedure Code', 'Enter procedure code'),
              
              const SizedBox(height: 20),
              
              ElevatedButton(
                onPressed: isLoading ? null : predictClaim,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(isLoading ? 'Predicting...' : 'Predict Claim Amount'),
                ),
              ),
              
              const SizedBox(height: 20),
              
              if (predictionResult.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    predictionResult,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose all controllers
    ageController.dispose();
    incomeController.dispose();
    genderController.dispose();
    specialtyController.dispose();
    statusController.dispose();
    maritalStatusController.dispose();
    employmentStatusController.dispose();
    locationController.dispose();
    claimTypeController.dispose();
    submissionMethodController.dispose();
    diagnosisCodeController.dispose();
    procedureCodeController.dispose();
    super.dispose();
  }
}