import 'package:emart_app/consts/consts.dart';

class FireStoreServices {
  //get Users Data
  static getUser(uid) {
    return firestore
        .collection(userController)
        .where('id', isEqualTo: uid)
        .snapshots();
  }
}
