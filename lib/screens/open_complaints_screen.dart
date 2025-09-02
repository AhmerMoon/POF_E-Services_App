// open_complaint_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pof_e_services/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OpenComplaintsScreen extends StatelessWidget {
  const OpenComplaintsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    // The stream should now return only open complaints, filtered at the source.
    final Stream<QuerySnapshot> allComplaintsStream =
        authService.getOpenComplaints();

    return Scaffold(
      // ... (app bar and background)
      body: StreamBuilder<QuerySnapshot>(
        stream: allComplaintsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          // Add proper error and loading checks
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Since the stream is already filtered, we can use all documents.
          final openComplaints = snapshot.data!.docs;

          if (openComplaints.isEmpty) {
            return const Center(child: Text('No open complaints found.'));
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children:
                    openComplaints.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                      return _buildComplaintCard(document.id, data);
                    }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildComplaintCard(
    String documentId,
    Map<String, dynamic> complaint,
  ) {
    // Safely get the timestamp or provide a fallback if it's null
    final Timestamp? timestamp = complaint['timestamp'];

    // Use a null-aware check to get the date. If timestamp is null, use current time.
    DateTime date = timestamp?.toDate() ?? DateTime.now();

    return Card(
      margin: const EdgeInsets.only(bottom: 12.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          children: [
            // Green date container
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Text(
                    _getMonthAbbreviation(date.month),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    date.day.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    date.year.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            // Complaint details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    // Use the Firestore document ID as the unique complaint number
                    'Complaint No. ${complaint['category']}-${documentId}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    complaint['category'] ?? 'No category',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${complaint['area'] ?? ''} | ${complaint['bungalow'] ?? ''}',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    complaint['description'] ?? 'No description',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getMonthAbbreviation(int month) {
    const months = [
      'JAN',
      'FEB',
      'MAR',
      'APR',
      'MAY',
      'JUN',
      'JUL',
      'AUG',
      'SEP',
      'OCT',
      'NOV',
      'DEC',
    ];
    return months[month - 1];
  }
}
