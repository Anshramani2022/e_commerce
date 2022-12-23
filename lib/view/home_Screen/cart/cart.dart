import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/Widget_common/commonButton.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controller/cart_controller.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: "Shopping cart"
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      body: StreamBuilder(
        stream: FireStoreServices.getcart(currentUser!.uid),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(redColor),
              ),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                "Cart Is Empty",
                style: TextStyle(
                    color: darkFontGrey, fontFamily: bold, fontSize: 18),
              ),
            );
          } else {
            var data = snapshot.data!.docs;
            controller.calculate(data);
            return Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                      child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Image.network("${data[index]['img']}"),
                        title:
                            "${data[index]['title']} (x${data[index]['qty']})"
                                .text
                                .size(16)
                                .fontFamily(semibold)
                                .make(),
                        subtitle: "${data[index]['tprice']}"
                            .numCurrency
                            .text
                            .color(redColor)
                            .fontFamily(semibold)
                            .make(),
                        trailing: IconButton(
                          onPressed: () {
                            FireStoreServices.deleteDocument(data[index].id);
                          },
                          icon: Icon(Icons.delete),
                          color: redColor,
                        ),
                      );
                    },
                  )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      "Total Price: "
                          .text
                          .fontFamily(semibold)
                          .color(darkFontGrey)
                          .make(),
                      Obx(() => "${controller.totalP.value}"
                          .text
                          .fontFamily(semibold)
                          .color(redColor)
                          .make()),
                    ],
                  )
                      .box
                      .padding(const EdgeInsets.all(12))
                      .color(lightgolden)
                      .width(context.screenWidth - 60)
                      .roundedSM
                      .make(),
                  10.heightBox,
                  SizedBox(
                      width: context.screenWidth - 60,
                      child: commonButton(
                        color: redColor,
                        textColor: whiteColor,
                        title: 'Procced to Ship',
                        onPress: () {},
                      ))
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
