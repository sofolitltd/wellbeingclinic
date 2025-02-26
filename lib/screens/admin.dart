import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:universal_html/html.dart' as html;

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('user');
  List<String> selectedTests = [];
  final List<Map<String, dynamic>> availableTests = [
    {'name': 'SocialAnxiety', 'id': '1', 'result': ''},
    {'name': 'SelfEsteem', 'id': '2', 'result': ''},
    {'name': 'DarkTriad', 'id': '3', 'result': ''},
    {'name': 'InternetAddiction', 'id': '4', 'result': ''},
    {'name': 'DAS', 'id': '5', 'result': ''},
    {'name': 'Wellbeing', 'id': '6', 'result': ''},
    {'name': 'Insomnia', 'id': '7', 'result': ''},
  ];

  Future<void> _addUser() async {
    if (_nameController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        selectedTests.isEmpty) {
      return;
    }

    QuerySnapshot querySnapshot =
        await usersCollection.orderBy('token', descending: true).limit(1).get();
    int newToken = querySnapshot.docs.isNotEmpty
        ? (querySnapshot.docs.first['token'] as int) + 1
        : 1;

    // Create a list of test maps
    List<Map<String, dynamic>> tests = selectedTests.map((testName) {
      // Find the test details from availableTests
      var test = availableTests.firstWhere((t) => t['name'] == testName);
      return {
        'id': test['id'],
        'name': test['name'],
        'result': '', // Initially empty result
      };
    }).toList();

    await usersCollection.add({
      'token': newToken,
      'name': _nameController.text,
      'age': '',
      'gender': '',
      'email': '',
      'mobile_no': _phoneController.text,
      'tests': tests, // Store the list of tests
    });

    setState(() {
      _nameController.clear();
      _phoneController.clear();
      selectedTests.clear();
    });
    Navigator.pop(context);
  }

  Future<void> _deleteUser(String userId) async {
    // Show a confirmation dialog before deleting
    bool? confirmDelete = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text('Are you sure you want to delete this user?'),
          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.pop(context, false), // If user clicks "No"
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () =>
                  Navigator.pop(context, true), // If user clicks "Yes"
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );

    // If the user confirms deletion, delete the user
    if (confirmDelete == true) {
      await usersCollection.doc(userId).delete();
    }
  }

  Future<void> _editUser(String userId, String name, String phone,
      List<Map<String, dynamic>> tests) async {
    // Set the values in the controllers and selected tests list just once
    _nameController.text = name;
    _phoneController.text = phone;

    // Ensure selectedTests is a list of test names for the UI
    selectedTests = List.from(tests.map((test) => test['name']));

    // Show the dialog with pre-filled data
    _showAddUserDialog(userId);
  }

  void _showAddUserDialog([String? userId]) {
    // Clear the controllers before opening the dialog for adding a new user
    if (userId == null) {
      _nameController.clear();
      _phoneController.clear();
      selectedTests.clear(); // Clear selected tests as well
    }

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(userId == null ? 'Add User' : 'Edit User'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),

                  TextField(
                    controller: _phoneController,
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 16),
                  const Text('Assign Tests:'),
                  const SizedBox(height: 8),

                  //
                  Wrap(
                    spacing: 5,
                    runSpacing: 5,
                    children: availableTests.map((test) {
                      return FilterChip(
                        label: Text(test['name']),
                        selected: selectedTests.contains(test['name']),
                        selectedColor: Colors.blue.withOpacity(0.5),
                        onSelected: (selected) {
                          setState(() {
                            if (selected) {
                              selectedTests.add(test['name']);
                            } else {
                              selectedTests.remove(test['name']);
                            }
                          });
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),

              //
              actions: [
                OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),

                //
                ElevatedButton(
                  onPressed: () async {
                    if (userId == null) {
                      await _addUser(); // Adding new user
                    } else {
                      // Map selectedTests to the correct structure before updating
                      List<Map<String, dynamic>> updatedTests =
                          selectedTests.map((testName) {
                        var test = availableTests
                            .firstWhere((t) => t['name'] == testName);
                        return {
                          'id': test['id'],
                          'name': test['name'],
                          'result': '', // Initially empty result
                        };
                      }).toList();

                      await usersCollection.doc(userId).update({
                        'name': _nameController.text,
                        'mobile_no': _phoneController.text,
                        'tests': updatedTests,
                      }).then((v) {
                        Navigator.pop(context);
                      });
                    }
                  },
                  child: Text(userId == null ? 'Add' : 'Update'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Management')),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Responsive Search Field
                Flexible(
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints(maxWidth: 400), // Max width of 400
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        labelText: 'Search by Serial, Name or Phone Number',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                  ),
                ),

                const SizedBox(width: 16), // Spacing between search and button

                // Add User Button
                ElevatedButton(
                  onPressed: _showAddUserDialog,
                  child: const Text('Add User'),
                ),
              ],
            ),

            SizedBox(height: 24),
            //
            Expanded(
              child: StreamBuilder(
                stream: usersCollection
                    .orderBy('token', descending: true)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  var users = snapshot.data!.docs;

                  // Add the name search functionality
                  if (_searchController.text.isNotEmpty) {
                    users = users.where((doc) {
                      // Search by token, phone number, or name
                      return doc['token']
                              .toString()
                              .contains(_searchController.text) ||
                          doc['mobile_no']
                              .toString()
                              .contains(_searchController.text) ||
                          doc['name']
                              .toString()
                              .toLowerCase()
                              .contains(_searchController.text.toLowerCase());
                    }).toList();
                  }

                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Table(
                          columnWidths: const {
                            0: FixedColumnWidth(56), // Fixed width for Serial
                            1: IntrinsicColumnWidth(), // Fixed width for Serial
                            2: IntrinsicColumnWidth(flex: 1),
                            3: IntrinsicColumnWidth(flex: 6),
                            4: FixedColumnWidth(120), // Fixed width for Actions
                          },
                          border: TableBorder.all(
                              color: Colors.black12), // Optional border
                          children: [
                            // Table Header
                            TableRow(
                              decoration:
                                  BoxDecoration(color: Colors.blue.shade100),
                              children: const [
                                Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Center(child: Text('Serial'))),
                                Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text('Mobile')),
                                Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text('Name')),
                                Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text('Tests')),
                                Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text('Actions')),
                              ],
                            ),
                            // Table Rows from Data
                            ...users.map((doc) {
                              return TableRow(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Center(
                                        child: Text(doc['token'].toString())),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(doc['mobile_no']),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(doc['name']),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(
                                      (doc['tests'] as List)
                                          .asMap()
                                          .map((index, test) {
                                            // Check if the result is null or not and format accordingly
                                            String resultDisplay = test[
                                                            'result'] ==
                                                        null ||
                                                    test['result'].isEmpty
                                                ? '${test['id']}. '
                                                    '${test['name']}'
                                                : '${test['id']}. ${test['name']} : ${test['result']}'; // Show the name with a checkmark if result is not null

                                            return MapEntry(
                                              index,
                                              resultDisplay,
                                            );
                                          })
                                          .values
                                          .join(
                                              '   |   '), // Join each formatted test with a separator
                                    ),
                                  ),

                                  //
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.edit),
                                        onPressed: () => _editUser(
                                          doc.id,
                                          doc['name'],
                                          doc['mobile_no'],
                                          List<Map<String, dynamic>>.from(
                                              doc['tests']),
                                        ),
                                      ),

                                      //
                                      IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () => _deleteUser(doc.id),
                                      ),

                                      IconButton(
                                        icon: const Icon(Icons.picture_as_pdf),
                                        onPressed: () {
                                          // Extract tests from Firestore document
                                          List<Map<String, String>>
                                              testResults = [];

                                          // Assuming 'tests' is a list in Firestore, we iterate over it
                                          for (var test in doc['tests']) {
                                            // Ensure each test is a Map and extract 'name' and 'result'
                                            testResults.add({
                                              "test": test['name'] ??
                                                  'Unknown Test', // Use a default value if 'name' is null
                                              "result": test['result']
                                                      ?.toString() ??
                                                  "Pending", // Handle null results
                                            });
                                          }

                                          generateAndDownloadPDF(
                                            serial: doc['token'].toString(),
                                            name: doc['name'],
                                            age: doc['age']?.toString() ??
                                                'N/A', // Use 'N/A' if 'age' is null
                                            sex: doc['gender'] ??
                                                'N/A', // Default 'gender' to 'N/A'
                                            mobile: doc['mobile_no'],
                                            email: doc['email'] ??
                                                'N/A', // Default 'email' to 'N/A'
                                            testResults: testResults,
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            }),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

Future<void> generateAndDownloadPDF({
  required String serial,
  required String name,
  required String age,
  required String sex,
  required String mobile,
  required String email,
  required List<Map<String, String>> testResults,
}) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            // Top Section: Header
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('Serial: $serial',
                        style: pw.TextStyle(
                            fontSize: 12, fontWeight: pw.FontWeight.bold)),
                    pw.Text('Name: $name', style: pw.TextStyle(fontSize: 12)),
                    pw.Text('Age: $age', style: pw.TextStyle(fontSize: 12)),
                    pw.Text('Sex: $sex', style: pw.TextStyle(fontSize: 12)),
                    pw.Text('Mobile: $mobile',
                        style: pw.TextStyle(fontSize: 12)),
                    pw.Text('Email: $email', style: pw.TextStyle(fontSize: 12)),
                  ],
                ),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Text('Psychological Assessment Team',
                        style: pw.TextStyle(
                            fontSize: 14, fontWeight: pw.FontWeight.bold)),
                    pw.Text('Department of Psychology',
                        style: pw.TextStyle(fontSize: 12)),
                    pw.Text('University of Chittagong',
                        style: pw.TextStyle(fontSize: 12)),
                  ],
                ),
              ],
            ),
            pw.SizedBox(height: 20),

            // Second Section: Test Results Table
            pw.Table(
              border: pw.TableBorder.all(),
              columnWidths: {
                0: pw.FlexColumnWidth(2),
                1: pw.FlexColumnWidth(2),
              },
              children: [
                pw.TableRow(
                  children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8.0),
                      child: pw.Text('Test Name',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8.0),
                      child: pw.Text('Result',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    ),
                  ],
                ),
                ...testResults.map(
                  (test) => pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text(test['test']!),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text(test['result']!),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 30),

            // Spacer to push bottom section to the bottom
            pw.Expanded(child: pw.SizedBox(height: 0)),

            // Bottom Section
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('For Further Advice',
                        style: pw.TextStyle(fontSize: 12)),
                    pw.Text('VISIT',
                        style: pw.TextStyle(
                          fontSize: 12,
                          fontWeight: pw.FontWeight.bold,
                        )),
                    pw.Text('Counseling Unit',
                        style: pw.TextStyle(
                          fontSize: 14,
                          fontWeight: pw.FontWeight.bold,
                        )),
                    pw.Text('Chittagong University Medical Center, CU',
                        style: pw.TextStyle(
                          fontSize: 12,
                          fontWeight: pw.FontWeight.bold,
                        )),
                  ],
                ),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Text('Powered by: Wellbeing Clinic',
                        style: pw.TextStyle(
                            fontSize: 12, fontWeight: pw.FontWeight.bold)),
                    pw.Text('Developed by: sofolit.vercel.app',
                        style: pw.TextStyle(fontSize: 12)),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    ),
  );

  // Convert PDF to bytes
  Uint8List pdfBytes = await pdf.save();

  // Create a Blob and trigger download using `universal_html`
  final blob = html.Blob([pdfBytes], 'application/pdf');
  final url = html.Url.createObjectUrlFromBlob(blob);
  final anchor = html.AnchorElement(href: url)
    ..setAttribute(
        "download", "$serial.pdf") // Use the serial number as the filename
    ..click();

  // Cleanup
  html.Url.revokeObjectUrl(url);
}
