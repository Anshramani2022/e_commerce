import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/controller/home_controlller.dart';
import 'package:get/get.dart';
import 'package:emart_app/consts/consts.dart';

class CartController extends GetxController {
  var totalP = 0.obs;

  //controller for shippingdetail
  var addressController = TextEditingController();
  var cityController = TextEditingController();
  var stateController = TextEditingController();
  var postelcodeController = TextEditingController();
  var phoneController = TextEditingController();

  late dynamic productSnapshot;

  var products = [];

  var placingOrder = false.obs;

  var paymentIndex = 0.obs;
  calculate(data) {
    totalP.value = 0;
    for (var i = 0; i < data.length; i++) {
      totalP.value = totalP.value + int.parse(data[i]['tprice'].toString());
    }
  }

  chnagePaymentIndex(index) {
    paymentIndex.value = index;
  }

  addPalceOrder({required orderPaymentMethod, required totalAmount}) async {
    placingOrder(true);
    await getProductDetails();
    await firestore.collection(orderCollection).doc().set({
      'order_by': currentUser!.uid,
      'order_date': FieldValue.serverTimestamp(),
      'order_code': "233981237",
      'order_by_email': currentUser!.email,
      'order_by_address': addressController.text,
      'order_by_state': stateController.text,
      'order_by_city': cityController.text,
      'order_by_phone': phoneController.text,
      'order_by_postelcode': postelcodeController.text,
      'shipping_method': "Home Delivery",
      'payment_method': orderPaymentMethod,
      'order_placed': true,
      'order_confirmed': false,
      'order_delivered': false,
      'order_on_delivery': false,
      'total_amount': totalAmount,
      'orders': FieldValue.arrayUnion(products)
    });
    placingOrder(false);
  }

  getProductDetails() {
    products.clear();
    for (int i = 0; i < productSnapshot.length; i++) {
      products.add({
        'color': productSnapshot[i]['color'],
        'img': productSnapshot[i]['img'],
        'qty': productSnapshot[i]['qty'],
        'title': productSnapshot[i]['title'],
        'vendor_id': productSnapshot[i]['vendor_id'],
        'tprice': productSnapshot[i]['tprice'],
        'sellerName': productSnapshot[i]['sellerName'],
      });
    }
  }

  clearCart() {
    for (int i = 0; i < productSnapshot.length; i++) {
      firestore.collection(cartCollection).doc(productSnapshot[i].id).delete();
    }
  }
}
