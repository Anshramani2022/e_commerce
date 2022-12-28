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

  //add to cart
  static getcart(uid) {
    return firestore
        .collection(cartCollection)
        .where("added_by", isEqualTo: uid)
        .snapshots();
  }

  //delete Cart item
  static deleteDocument(docId) {
    return firestore.collection(cartCollection).doc(docId).delete();
  }

  //get all messages
  static getMessage(docId) {
    return firestore
        .collection(chatsCollection)
        .doc(docId)
        .collection(messagesCollection)
        .orderBy('created_on', descending: false)
        .snapshots();
  }
}
