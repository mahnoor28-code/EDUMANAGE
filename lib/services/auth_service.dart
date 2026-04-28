import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Stream listening to auth state changes
  Stream<User?> get user => _auth.authStateChanges();

  // Sign in with email & password
  Future<UserCredential?> signInWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  // Get user role from Firestore
  Future<String?> getUserRole(String uid) async {
    try {
      DocumentSnapshot doc = await _db.collection('users').doc(uid).get();
      if (doc.exists) {
        return doc.get('role') as String?; // 'admin', 'teacher', 'student'
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  // Register new user (for Admin to create teachers/students)
  Future<UserCredential?> registerUser(String email, String password, String role, String name) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      // Store additional details
      if (userCredential.user != null) {
        await _db.collection('users').doc(userCredential.user!.uid).set({
          'email': email,
          'role': role,
          'name': name,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }
      
      return userCredential;
    } on FirebaseAuthException catch (e) {
       throw Exception(e.message);
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
