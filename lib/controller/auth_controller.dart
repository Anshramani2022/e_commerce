import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  Future<UserCredential?> loginMethod(
      {String? email, String? password, context}) async {
    UserCredential userCredential;

    try {
      await auth.signInWithEmailAndPassword(email: email!, password: password!);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return null;
  }

  Future<UserCredential?> signupMethod(
      {String? email, String? password, context}) async {
    UserCredential userCredential;

    try {
      await auth.createUserWithEmailAndPassword(
          email: email!, password: password!);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return null;
  }

  storeUserData({name, password, email}) async {
    DocumentReference store =
        await firestore.collection(userController).doc(currentUser!.uid);
    store.set(
        {"name": name, "password": password, "email": email, "imageUrl": ""});
  }

  signoutMethod(context) async {
    try {
      await auth.signOut();
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }
}