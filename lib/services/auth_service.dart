// services/auth_service.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sign up with email and password and create a user document in Firestore.
  Future<User?> signUpWithEmailAndPassword(
    String email,
    String password,
    String name,
  ) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = result.user;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'name': name,
          'email': user.email,
        });
      }
      return user;
    } on FirebaseAuthException catch (e) {
      print('Firebase Auth Error: ${e.message}');
      return null;
    } catch (e) {
      print('Error signing up: $e');
      return null;
    }
  }

  // Sign in with email and password
  Future<User?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } on FirebaseAuthException catch (e) {
      print('Firebase Auth Error: ${e.message}');
      return null;
    } catch (e) {
      print('Error signing in: $e');
      return null;
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Get current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // Register a complaint
  Future<void> registerComplaint(Map<String, dynamic> complaintData) async {
    try {
      User? user = getCurrentUser();
      if (user != null) {
        // Add user details and status to the complaint data
        complaintData['userId'] = user.uid;
        complaintData['timestamp'] = FieldValue.serverTimestamp();
        complaintData['status'] = 'Opened';

        await _firestore.collection('complaints').add(complaintData);
      }
    } catch (e) {
      print('Error registering complaint: $e');
      rethrow;
    }
  }

  // Get open complaints for the current user.
  // NOTE: This query requires a composite index on `userId`, `status`, and `timestamp`.
  Stream<QuerySnapshot> getOpenComplaints() {
    User? user = getCurrentUser();
    if (user != null) {
      return _firestore
          .collection('complaints')
          .where('userId', isEqualTo: user.uid)
          .where('status', isEqualTo: 'Opened')
          .orderBy('timestamp', descending: true)
          .snapshots();
    }
    return const Stream.empty();
  }

  // Get closed complaints for the current user.
  // NOTE: This query requires a composite index on `userId`, `status`, and `timestamp`.
  Stream<QuerySnapshot> getClosedComplaints() {
    User? user = getCurrentUser();
    if (user != null) {
      return _firestore
          .collection('complaints')
          .where('userId', isEqualTo: user.uid)
          .where('status', isEqualTo: 'Closed')
          .orderBy('timestamp', descending: true)
          .snapshots();
    }
    return const Stream.empty();
  }
}
