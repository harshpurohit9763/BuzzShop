import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'controllers/Authentication.dart';

const Color primaryColor = Color(0xFFF67952);
const Color bgColor = Color(0xFFFBFBFD);

const double defaultPadding = 16.0;
const double defaultBorderRadius = 12.0;

AuthController authController = AuthController.instance;
final Future<FirebaseApp> firebaseInitialization = Firebase.initializeApp();
FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
GoogleSignIn googleSign = GoogleSignIn();

TextEditingController email = TextEditingController();
TextEditingController password = TextEditingController();
TextEditingController dealerId = TextEditingController();
TextEditingController name = TextEditingController();
TextEditingController phone = TextEditingController();
