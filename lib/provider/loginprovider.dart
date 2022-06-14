// ignore_for_file: avoid_print
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project/model/mountain.dart';
import 'package:project/model/user.dart';

class LoginProvider extends ChangeNotifier {
  // ignore: prefer_final_fields
  FirebaseAuth _auth = FirebaseAuth.instance;
  User? get user => _auth.currentUser;
  Future<void> googleLogin() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return;
      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      // Once signed in, return the UserCredential
      final _result =
          await FirebaseAuth.instance.signInWithCredential(credential);
      if (_result.additionalUserInfo!.isNewUser) {
        await createUser(_result);
      }
      await loadMoutains();
      await loadUser(_result);

      print(_mountains.length);

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  List<Mountain> _mountains = [];
  List<Mountain> get mountains => _mountains;

  AppUser? _currentUser;
  AppUser? get currentUser => _currentUser;

  Future<void> loadMoutains() async {
    await FirebaseFirestore.instance
        .collection('mountain')
        .get()
        .then((QuerySnapshot snapshot) {
      for (var doc in snapshot.docs) {
        _mountains.add(Mountain(
          name: doc['name'] as String,
          url: doc['url'] as String,
          lat: doc['lat'], 
          lng: doc['lng'],
          detail: doc['detail'] as String,
          video: doc['video'] as String,
        ));
      }
    });
  }

  Future<void> loadUser(UserCredential result) async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(result.user!.uid)
        .get()
        .then((DocumentSnapshot snapshot) {
      _currentUser = AppUser(
          name: snapshot['name'] as String,
          status: snapshot['status'] as String);
    });
  }

  Future<void> createUser(UserCredential result) async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(result.user!.uid)
        .set(<String, dynamic>{
      'uid': result.user!.uid,
      'name': result.user!.displayName,
      'status': "I promise to take the test honestly before God",
    });
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
    _mountains = [];
    notifyListeners();
  }
}
