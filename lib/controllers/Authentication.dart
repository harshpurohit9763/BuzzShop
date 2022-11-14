import 'dart:ffi';
import 'dart:io';

import 'package:buzz/constants.dart';
import 'package:buzz/screens/auth/Signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;

import '../screens/switchpage.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> firebaseUser;
  var isDealer = false.obs;
  bool isLoading = false;
  var savedImage = "";
  bool imageSelected = false;
  var dealerIdForLogin = 338265.toString();

  late Rx<GoogleSignInAccount?> googleSignInAccount;
  //
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    firebaseUser = Rx<User?>(auth.currentUser);
    //
    googleSignInAccount = Rx<GoogleSignInAccount?>(googleSign.currentUser);
    //

    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser, _setInitialScreen);

    googleSignInAccount.bindStream(googleSign.onCurrentUserChanged);
    ever(googleSignInAccount, _setInitialScreenGoogle);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => Signup());
    } else {
      Get.offAll(() => SwitchPage());
    }
  }

  _setInitialScreenGoogle(GoogleSignInAccount? googleSignInAccount) {
    if (googleSignInAccount == null) {
      Get.offAll(() => Signup());
    } else {
      Get.offAll(() => SwitchPage());
    }
  }

  void SignInWithGoogle() async {
    try {
      GoogleSignInAccount? googleSignInAccount = await googleSign.signIn();

      if (googleSignInAccount != null) {
        GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        await auth
            .signInWithCredential(credential)
            .catchError((onErr) => print(onErr));
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
      print(e.toString());
    }
  }

  void register(String email, password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (firebaseAuthException) {}
  }

  void login(String email, password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (firebaseAuthException) {}
  }

  void signOut() async {
    await auth.signOut();
  }

  Future uploadImageToStorage(
    XFile file,
  ) async {
    isLoading = true;
    try {
      String basename = p.basename(file.path);
      await FirebaseStorage.instance
          .ref()
          .child('UsersData/${auth.currentUser!.uid}/${basename.toString()}')
          .putFile(File(file.path))
          .then((taskSnapshot) {
        if (taskSnapshot.state == TaskState.success) {
          FirebaseStorage.instance
              .ref('UsersData/${auth.currentUser!.uid}/${basename.toString()}')
              .getDownloadURL()
              .then((url) async {
            //do something with url
            savedImage = url;

            isLoading = false;
            imageSelected = true;
            print(url);
            print(savedImage);
          });
        }
      });
    } catch (e) {
      print(e);
      return "";
    }
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }
}
