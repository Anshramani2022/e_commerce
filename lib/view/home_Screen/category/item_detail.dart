import 'dart:developer';

import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controller/product_controller.dart';
import 'package:emart_app/view/chat_screen/chat_screen.dart';
import 'package:get/get.dart';

import '../../../Widget_common/commonButton.dart';

class ItemDetails extends StatelessWidget {
  final String? title;
  final dynamic data;
  const ItemDetails({Key? key, this.title, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();
    return WillPopScope(
      onWillPop: () async {
        controller.resetValue();
        return true;
      },
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              controller.resetValue();
              Get.back();
            },
          ),
          title:
              title!.text.fontFamily(bold).size(20).color(darkFontGrey).make(),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
            IconButton(
                onPressed: () {
                  if (controller.isFav.value) {
                    controller.removeFromWishList(data.id);
                    controller.isFav(false);
                  } else {
                    controller.addToWishList(data.id);
                    controller.isFav(true);
                  }
                },
                icon: const Icon(Icons.favorite_outlined)),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      VxSwiper.builder(
                        autoPlay: true,
                        height: 350,
                        itemCount: data['p_images'].length,
                        aspectRatio: 16 / 9,
                        viewportFraction: 1.0,
                        itemBuilder: (context, index) {
                          return Image.network(
                            data['p_images'][index],
                            width: double.infinity,
                            fit: BoxFit.fill,
                          );
                        },
                      ),
                      10.heightBox,
                      title!.text
                          .fontFamily(semibold)
                          .color(darkFontGrey)
                          .make(),
                      10.heightBox,
                      VxRating(
                        isSelectable: false,
                        value: double.parse(data['p_rating']),
                        onRatingUpdate: (value) {},
                        count: 5,
                        normalColor: textfieldGrey,
                        selectionColor: golden,
                        maxRating: 5,
                        size: 25,
                      ),
                      10.heightBox,
                      "${data['p_prices']}"
                          .numCurrency
                          .text
                          .fontFamily(bold)
                          .color(redColor)
                          .size(18)
                          .make(),
                      10.heightBox,
                      Row(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  "${data['p_seller']}"
                                      .text
                                      .fontFamily(semibold)
                                      .white
                                      .make(),
                                  5.heightBox,
                                  "${data['p_description']}"
                                      .text
                                      .size(14)
                                      .color(darkFontGrey)
                                      .fontFamily(semibold)
                                      .make()
                                ],
                              ),
                            ),
                          ),
                          CircleAvatar(
                              backgroundColor: Colors.white,
                              child: IconButton(
                                onPressed: () {
                                  Get.to(() => ChatScreen(), arguments: [
                                    data['p_seller'],
                                    data['vendor_id']
                                  ]);
                                },
                                icon: Icon(
                                  Icons.message_outlined,
                                  color: darkFontGrey,
                                ),
                              ))
                        ],
                      )
                          .box
                          .height(60)
                          .padding(const EdgeInsets.symmetric(horizontal: 16))
                          .color(textfieldGrey)
                          .make(),
                      20.heightBox,
                      Obx(
                        () => Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 120,
                                  child: "Color: "
                                      .text
                                      .color(textfieldGrey)
                                      .make(),
                                ),
                                Row(
                                  children: List.generate(
                                      data['p_color'].length,
                                      (index) => Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              VxBox()
                                                  .size(40, 40)
                                                  .roundedFull
                                                  .color(Color(data['p_color']
                                                          [index])
                                                      .withOpacity(1.0))
                                                  .margin(const EdgeInsets
                                                      .symmetric(horizontal: 4))
                                                  .make()
                                                  .onTap(() {
                                                controller
                                                    .chageColorIndex(index);
                                              }),
                                              Visibility(
                                                  visible: index ==
                                                      controller
                                                          .colorIndex.value,
                                                  child: const Icon(
                                                    Icons.done_outline,
                                                    color: Colors.white,
                                                  ))
                                            ],
                                          )),
                                )
                              ],
                            ).box.padding(const EdgeInsets.all(8)).make(),
                            Row(
                              children: [
                                SizedBox(
                                  width: 120,
                                  child: "Quentitty: "
                                      .text
                                      .color(textfieldGrey)
                                      .make(),
                                ),
                                Obx(
                                  () => Row(children: [
                                    IconButton(
                                      onPressed: () {
                                        controller.quentityDecrease();
                                        controller.totalMoney(
                                            int.parse(data['p_prices']));
                                      },
                                      icon: const Icon(Icons.remove),
                                    ),
                                    controller.quentity.value.text
                                        .size(16)
                                        .fontFamily(semibold)
                                        .color(darkFontGrey)
                                        .make(),
                                    IconButton(
                                      onPressed: () {
                                        controller.quentityIncrease(
                                            totalQuentity: int.parse(
                                                "${data['p_quentity']}"));
                                        controller.totalMoney(
                                            int.parse(data['p_prices']));
                                      },
                                      icon: const Icon(Icons.add),
                                    ),
                                    "${data["p_quentity"]} Available"
                                        .text
                                        .color(textfieldGrey)
                                        .make(),
                                  ]),
                                )
                              ],
                            ).box.padding(const EdgeInsets.all(8)).make(),
                            Row(
                              children: [
                                SizedBox(
                                  width: 120,
                                  child: "Total: "
                                      .text
                                      .color(textfieldGrey)
                                      .make(),
                                ),
                                '${controller.totalPrice.value}'
                                    .numCurrency
                                    .text
                                    .color(redColor)
                                    .size(16)
                                    .fontFamily(bold)
                                    .make(),
                              ],
                            ).box.padding(const EdgeInsets.all(8)).make(),
                          ],
                        ).box.shadowSm.white.make(),
                      ),
                      10.heightBox,
                      "Description"
                          .text
                          .color(darkFontGrey)
                          .fontFamily(semibold)
                          .make(),
                      10.heightBox,
                      "${data['p_description']}"
                          .text
                          .fontFamily(semibold)
                          .color(darkFontGrey)
                          .make(),
                      10.heightBox,
                      ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: List.generate(
                              itemDetailButtonList.length,
                              (index) => ListTile(
                                    title: itemDetailButtonList[index]
                                        .text
                                        .fontFamily(semibold)
                                        .color(darkFontGrey)
                                        .make(),
                                    trailing: const Icon(Icons.arrow_forward),
                                  ))),
                      20.heightBox,
                      productsMayYouLike.text
                          .size(16)
                          .fontFamily(bold)
                          .color(darkFontGrey)
                          .make(),
                      10.heightBox,
                      SingleChildScrollView(
                        //copy this widget from home screen featured Product
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                              6,
                              (index) => Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        imgP1,
                                        width: 150,
                                        fit: BoxFit.cover,
                                      ),
                                      10.heightBox,
                                      "Laptop 4GB/512ssd"
                                          .text
                                          .color(darkFontGrey)
                                          .fontFamily(semibold)
                                          .make(),
                                      10.heightBox,
                                      "\$600"
                                          .text
                                          .color(redColor)
                                          .fontFamily(bold)
                                          .size(16)
                                          .make()
                                    ],
                                  )
                                      .box
                                      .white
                                      .margin(const EdgeInsets.symmetric(
                                          horizontal: 4))
                                      .roundedSM
                                      .padding(const EdgeInsets.all(8))
                                      .make()),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 60,
              width: double.infinity,
              child: commonButton(
                  color: redColor,
                  onPress: () {
                    controller.addToCart(
                        color: data['p_color'][controller.colorIndex.value],
                        context: context,
                        title: data['p_name'],
                        img: data['p_images'][0],
                        qty: controller.quentity.value,
                        sellerName: data['p_seller'],
                        tprice: controller.totalPrice.value);
                    VxToast.show(context, msg: "Added To Cart");
                  },
                  textColor: whiteColor,
                  title: "Add To Cart"),
            )
          ],
        ),
      ),
    );
  }
}
