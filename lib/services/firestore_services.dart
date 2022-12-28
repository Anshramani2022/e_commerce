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

  static subCategoryProduct(title) {
    return firestore
        .collection(productCollection)
        .where('p_subcategories', isEqualTo: title)
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

  static getAllOrders() {
    return firestore
        .collection(orderCollection)
        .where('order_by', isEqualTo: currentUser!.uid)
        .snapshots();
  }

  static getWishlist() {
    return firestore
        .collection(productCollection)
        .where('p_wishlist', arrayContains: currentUser!.uid)
        .snapshots();
  }

  static getAllMessage() {
    return firestore
        .collection(chatsCollection)
        .where('fromId', isEqualTo: currentUser!.uid)
        .snapshots();
  }

  static getCount() async {
    var res = await Future.wait([
      firestore
          .collection(cartCollection)
          .where('added_by', isEqualTo: currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
      firestore
          .collection(productCollection)
          .where('p_wishlist', arrayContains: currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
      firestore
          .collection(orderCollection)
          .where('order_by', isEqualTo: currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
    ]);
    return res;
  }

  static allProduct() {
    return firestore.collection(productCollection).snapshots();
  }

  //get featured product metod
  static getFeaturedProduct() {
    return firestore
        .collection(productCollection)
        .where('is_featured', isEqualTo: true)
        .get();
  }

  static searchProduct(title) {
    return firestore.collection(productCollection).get();
  }
}
