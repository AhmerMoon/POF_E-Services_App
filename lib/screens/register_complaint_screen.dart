// register_complaint_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pof_e_services/screens/home_screen.dart';
import 'package:pof_e_services/services/auth_service.dart';

class RegisterComplaintScreen extends StatefulWidget {
  const RegisterComplaintScreen({super.key});

  @override
  _RegisterComplaintScreenState createState() =>
      _RegisterComplaintScreenState();
}

class _RegisterComplaintScreenState extends State<RegisterComplaintScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  String? _selectedCategory;
  String? _selectedSubCategory;
  String? _selectedArea;
  String? _selectedBungalow;
  bool _showCamera = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  void _onCategoryChanged(String? newCategory) {
    setState(() {
      _selectedCategory = newCategory;
      _showCamera = newCategory == 'Station Engineer';
    });
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Register Complaint',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/bg.png"),
                fit: BoxFit.cover,
                opacity: 0.2,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  _buildDropdownField(
                    icon: Icons.category,
                    hintText: 'Category',
                    value: _selectedCategory,
                    onChanged: _onCategoryChanged,
                    items:
                        [
                          'Station Engineer',
                          'Telephone Internet',
                          'Water Supply',
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                  ),
                  const SizedBox(height: 20),
                  _buildDropdownField(
                    icon: Icons.category_outlined,
                    hintText: 'Sub Category',
                    value: _selectedSubCategory,
                    onChanged: (value) {
                      setState(() {
                        _selectedSubCategory = value;
                      });
                    },
                    items:
                        ['General', 'Specific'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                  ),
                  const SizedBox(height: 20),
                  _buildDropdownField(
                    icon: Icons.place_outlined,
                    hintText: 'Area/Road',
                    value: _selectedArea,
                    onChanged: (value) {
                      setState(() {
                        _selectedArea = value;
                      });
                    },
                    items:
                        ['A Area', 'B Area', 'C Area'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                  ),
                  const SizedBox(height: 20),
                  _buildDropdownField(
                    icon: Icons.home_work_outlined,
                    hintText: 'Bungalow/Quarter/Flat No.',
                    value: _selectedBungalow,
                    onChanged: (value) {
                      setState(() {
                        _selectedBungalow = value;
                      });
                    },
                    items:
                        ['1', '2', '3'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                  ),
                  const SizedBox(height: 20),
                  _buildDescriptionField(),
                  const SizedBox(height: 20),
                  if (_showCamera) _buildCameraWidget(),
                  if (_showCamera) const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed:
                        _isLoading
                            ? null
                            : () async {
                              if (_selectedCategory == null ||
                                  _selectedSubCategory == null ||
                                  _selectedArea == null ||
                                  _selectedBungalow == null ||
                                  _descriptionController.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Please fill all the fields before submitting.',
                                    ),
                                  ),
                                );
                                return;
                              }

                              setState(() {
                                _isLoading = true;
                              });

                              try {
                                Map<String, dynamic> complaintData = {
                                  'category': _selectedCategory,
                                  'subCategory': _selectedSubCategory,
                                  'area': _selectedArea,
                                  'bungalow': _selectedBungalow,
                                  'description': _descriptionController.text,
                                };

                                await authService.registerComplaint(
                                  complaintData,
                                );

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Complaint Submitted Successfully!',
                                    ),
                                  ),
                                );

                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeScreen(),
                                  ),
                                  (Route<dynamic> route) => false,
                                );
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Error submitting complaint: $e',
                                    ),
                                  ),
                                );
                              } finally {
                                setState(() {
                                  _isLoading = false;
                                });
                              }
                            },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      minimumSize: const Size(double.infinity, 60),
                    ),
                    child:
                        _isLoading
                            ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            )
                            : const Text(
                              'Submit',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownField({
    required IconData icon,
    required String hintText,
    String? value,
    required List<DropdownMenuItem<String>> items,
    ValueChanged<String?>? onChanged,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: DropdownButtonFormField<String>(
          value: value,
          onChanged: onChanged,
          items: items,
          icon: const Icon(Icons.arrow_drop_down, color: Colors.green),
          decoration: InputDecoration(
            hintText: hintText,
            border: InputBorder.none,
            prefixIcon: Icon(icon, color: Colors.green),
          ),
        ),
      ),
    );
  }

  Widget _buildDescriptionField() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: TextField(
          controller: _descriptionController,
          maxLines: 1,
          decoration: InputDecoration(
            hintText: 'Description',
            border: InputBorder.none,
            prefixIcon: const Icon(Icons.description, color: Colors.green),
          ),
        ),
      ),
    );
  }

  Widget _buildCameraWidget() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.camera_alt_outlined, size: 50, color: Colors.grey),
            SizedBox(height: 8),
            Text('Picture', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
