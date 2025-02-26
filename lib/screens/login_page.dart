import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _mobileController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Wellbeing Clinic")),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black12),
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          constraints: BoxConstraints(maxWidth: 400),
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Mobile number input field
              TextField(
                controller: _mobileController,
                decoration: const InputDecoration(
                  labelText: "Enter Mobile No.",
                  hintText: "Mobile Number",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 32),
              // Button to check mobile number
              ElevatedButton(
                onPressed: _isLoading ? null : _checkMobileNumber,
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Check Mobile Number"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Check if the mobile number exists in the Firestore database
  Future<void> _checkMobileNumber() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final mobileNumber = _mobileController.text;

      // Check if the mobile number exists in the Firestore database
      var userSnapshot = await FirebaseFirestore.instance
          .collection('user')
          .where('mobile_no', isEqualTo: mobileNumber)
          .get();

      if (userSnapshot.docs.isEmpty) {
        // If mobile number is not registered, show error message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('This mobile number is not registered')),
        );
      } else {
        // If the user exists, check if their profile is completed
        var userDoc = userSnapshot.docs.first;
        if (userDoc['name'] == '' ||
            userDoc['gender'] == '' ||
            userDoc['age'] == '' ||
            userDoc['email'] == '') {
          // If the profile is incomplete, show the update dialog
          _showUpdateDialog(userDoc, mobileNumber);
        } else {
          // If profile is complete, go to main page
          Navigator.pushReplacementNamed(
            context,
            '/tests',
            arguments: {'mobile_no': mobileNumber},
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  // Show a dialog to update the user details if missing
  void _showUpdateDialog(QueryDocumentSnapshot userDoc, String mobileNumber) {
    final _nameController = TextEditingController(text: userDoc['name']);
    final _emailController = TextEditingController(text: userDoc['email']);
    final _genderController = TextEditingController(text: userDoc['gender']);
    final _ageController =
        TextEditingController(text: userDoc['age'].toString());

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Update Your Details"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                // Name Field
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: "Name"),
                ),

                // Gender Dropdown
                DropdownButtonFormField<String>(
                  value: _genderController.text.isNotEmpty
                      ? _genderController.text
                      : 'Male', // Default value
                  onChanged: (String? newValue) {
                    setState(() {
                      _genderController.text = newValue!;
                    });
                  },
                  items: ['Male', 'Female']
                      .map((gender) => DropdownMenuItem(
                            value: gender,
                            child: Text(gender),
                          ))
                      .toList(),
                  decoration: const InputDecoration(labelText: 'Gender'),
                ),

                // Age Field
                TextField(
                  controller: _ageController,
                  decoration: const InputDecoration(labelText: "Age"),
                  keyboardType: TextInputType.number,
                ),

                // Email Field
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: "Email"),
                ),
              ],
            ),
          ),
          actions: [
            // Cancel Button
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),

            // Submit Button to update details
            ElevatedButton(
              onPressed: () async {
                // Get updated data
                String name = _nameController.text;
                String gender = _genderController.text;
                String age = _ageController.text;
                String email = _emailController.text;

                // Update the user's details in Firestore
                try {
                  await FirebaseFirestore.instance
                      .collection('user')
                      .doc(userDoc.id)
                      .update({
                    'name': name,
                    'gender': gender,
                    'age': age,
                    'email': email,
                  });

                  // Show success message
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('User details updated successfully')),
                  );

                  // Navigate to the main page
                  Navigator.pushReplacementNamed(
                    context,
                    '/tests',
                    arguments: {'mobile_no': mobileNumber},
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to update details: $e')),
                  );
                }
              },
              child: const Text("Submit"),
            ),
          ],
        );
      },
    );
  }
}
