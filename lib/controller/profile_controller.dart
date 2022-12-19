import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class ProfileController extends GetxController {
  var profileImg = ''.obs;
  var profileImgLink = '';
  var isLoading = false.obs;
  var nameController = TextEditingController();
  var passController = TextEditingController();
  changeImage(context) async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
      );

      if (image == null) return;
      profileImg.value = image.path;
    } on PlatformException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  uploadImage() async {
    var filename = basename(profileImg.value);
    var destination = 'images/${currentUser!.uid}/$filename';
    Reference ref = FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(File(profileImg.value));
    profileImgLink = await ref.getDownloadURL();
  }

  updateProfile({name, password, imgUrl}) async {
    var storeData = firestore.collection(userController).doc(currentUser!.uid);
    await storeData.set(
        {'name': name, 'password': password, 'imageUrl': imgUrl},
        SetOptions(merge: true));
    isLoading(false);
  }
}
