import 'package:adidas/models/user_model.dart';
import 'package:adidas/providers/auth_provider.dart';
import 'package:adidas/screens/home_screen/main_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../screens/auth_screen/signin_page.dart';
import '../utils/custom_navigators.dart';

class AuthController {
  CollectionReference users = FirebaseFirestore.instance.collection("Users");

  Future<void> listenAuthState(BuildContext context) async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        Logger().e('User is currently signed out!');
        CustomNavigators.goTo(context, const SignInPage());
      } else {
        Provider.of<AuthProvider>(context, listen: false).setUser(user);
        Logger().i('User is signed in!');
        fetchUserData(user.uid).then((value) {
          if (value != null) {
            Provider.of<AuthProvider>(context, listen: false)
                .setUserModel(value, context, value.name);
            CustomNavigators.goTo(context, const MainScreen());
          } else {
            Provider.of<AuthProvider>(context, listen: false).setUserModel(
                UserModel(
                    email: user.uid,
                    image:
                        "https://i.pinimg.com/236x/47/5a/86/475a86177aeedacf8dc7f5e2b4eff61f.jpg",
                    name: "",
                    uid: user.uid , 
                    favorite: []
                    ),
                context,
                "");
            CustomNavigators.goTo(context, const MainScreen());
          }
        });
      }
    });
  }

  Future<bool> createAccount(
      {required String email,
      required String password,
      required String name}) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user != null) {
        UserModel model = UserModel(
            email: email,
            image:
                "https://i.pinimg.com/236x/47/5a/86/475a86177aeedacf8dc7f5e2b4eff61f.jpg",
            name: name,
            uid: credential.user!.uid , 
            favorite: []
            );
        addUserData(model);
      }

      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Logger().e('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Logger().e('The account already exists for that email.');
      }
      return false;
    } catch (e) {
      Logger().e(e);
      return false;
    }
  }

  Future<void> signOutUser() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<bool> signInWithPassword(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Logger().e('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Logger().e('Wrong password provided for that user.');
      }
      return false;
    }
  }

  Future<void> sendpasswordResetEmail(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  Future<void> addUserData(UserModel user) async {
    try {
      await users.doc(user.uid).set(user.toJson());
      Logger().f("User Data Added");
    } catch (e) {
      Logger().e(e);
    }
  }

  Future<UserModel?> fetchUserData(String uid) async {
    try {
      DocumentSnapshot snapshot = await users.doc(uid).get();
      return UserModel.fromJson(snapshot.data() as Map<String, dynamic>);
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

  Future<void> updateUser(Map<String, dynamic> data, String uid) async {
    try {
      await users.doc(uid).update(data);
      Logger().f("User Updated");
    } catch (e) {
      Logger().e(e);
    }
  }

  Future<void> updateFavorite(String uid , List<String> items) async {
    try {
      await users.doc(uid).update({
        "favorite": items
      });
    } catch (e) {
      Logger().e(e);
    }
  }
}
