import 'package:emart_app/consts/consts.dart';

class FireStoreServices {
  //get Users Data
  static getUser(uid) {
    return firestore
        .collection(userController)
        .where('id', isEqualTo: uid)
        .snapshots();
  }

  //get product according to categories
  static getProduct(category) {
    return firestore
        .collection(productCollection)
        .where('p_categories', isEqualTo: category)
        .snapshots();
  }
}
