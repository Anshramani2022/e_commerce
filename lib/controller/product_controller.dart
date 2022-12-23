import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/model/category_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  var quentity = 0.obs;
  var colorIndex = 0.obs;
  var totalPrice = 0.obs;
  var subCat = [];
  getSubCategory(title) async {
    subCat.clear();
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var decode = categoryModelFromJson(data);
    var filter =
        decode.categories.where((element) => element.name == title).toList();

    for (var e in filter[0].subcategory) {
      subCat.add(e);
    }
  }

  chageColorIndex(index) {
    colorIndex = index;
  }

  quentityIncrease({totalQuentity}) {
    if (quentity.value < totalQuentity) {
      quentity.value++;
    }
  }

  quentityDecrease() {
    if (quentity.value > 0) {
      quentity.value--;
    }
  }

  totalMoney(price) {
    totalPrice.value = price * quentity.value;
  }

  addToCart({title, img, sellerName, color, qty, tprice, context}) async {
    await firestore.collection(cartCollection).doc().set({
      "title": title,
      "img": img,
      "sellerName": sellerName,
      "color": color,
      "qty": qty,
      "tprice": tprice,
      "added_by": currentUser!.uid
    }).catchError((e) {
      VxToast.show(context, msg: e.toString());
    });
  }

  resetValue() {
    totalPrice.value = 0;
    quentity.value = 0;
    colorIndex.value = 0;
  }
}
