import 'package:flutter/material.dart';

void main() => runApp(const StepperDemoApp());

class StepperDemoApp extends StatelessWidget {
  const StepperDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stepper Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const StepperScreen(),
    );
  }
}

class StepperScreen extends StatefulWidget {
  const StepperScreen({super.key});

  @override
  State<StepperScreen> createState() => _StepperScreenState();
}

class _StepperScreenState extends State<StepperScreen> {
  int _currentStep = 0;
  final Map<String, TextEditingController> _controllers = {
    'name': TextEditingController(),
    'email': TextEditingController(),
    'phone': TextEditingController(),
    'address': TextEditingController(),
  };

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stepper Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Stepper(
        currentStep: _currentStep,
        onStepContinue: _handleContinue,
        onStepCancel: _handleCancel,
        onStepTapped: (step) => setState(() => _currentStep = step),
        steps: _buildSteps(),
      ),
    );
  }

  List<Step> _buildSteps() => [
        _buildStep(
          title: 'Personal Info',
          index: 0,
          content: Column(children: [
            _buildTextField('name', 'Full Name'),
            _buildTextField('email', 'Email', type: TextInputType.emailAddress),
          ]),
        ),
        _buildStep(
          title: 'Contact Details',
          index: 1,
          content: Column(children: [
            _buildTextField('phone', 'Phone Number', type: TextInputType.phone),
            _buildTextField('address', 'Address'),
          ]),
        ),
        _buildStep(
          title: 'Confirmation',
          index: 2,
          content: _buildSummary(),
        ),
      ];

  Step _buildStep({
    required String title,
    required int index,
    required Widget content,
  }) {
    return Step(
      title: Text(title),
      content: content,
      isActive: _currentStep >= index,
      state: _currentStep > index ? StepState.complete : StepState.indexed,
    );
  }

  Widget _buildTextField(
    String key,
    String label, {
    TextInputType? type,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: _controllers[key],
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        keyboardType: type,
      ),
    );
  }

  Widget _buildSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Review your information:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        ..._controllers.entries.map(
          (e) => Text('${_formatLabel(e.key)}: ${e.value.text}'),
        ),
      ],
    );
  }

  String _formatLabel(String key) {
    return key[0].toUpperCase() + key.substring(1);
  }

  void _handleContinue() {
    if (_currentStep < 2) {
      setState(() => _currentStep++);
    } else {
      _showCompletionDialog();
    }
  }

  void _handleCancel() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    }
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Success!'),
        content: const Text('All steps completed.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _resetForm();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _resetForm() {
    setState(() {
      _currentStep = 0;
      for (var controller in _controllers.values) {
        controller.clear();
      }
    });
  }
}
