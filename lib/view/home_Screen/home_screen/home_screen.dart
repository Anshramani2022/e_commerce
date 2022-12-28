import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/Widget_common/home_button.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controller/home_controlller.dart';
import 'package:emart_app/controller/product_controller.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/view/home_Screen/category/item_detail.dart';
import 'package:emart_app/view/home_Screen/home_screen/search_screen.dart';
import 'package:get/get.dart';

import '../component/featured_component.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ProductController());
    var controller = Get.find<HomeController>();

    return Container(
      padding: const EdgeInsets.all(13),
      color: lightGrey,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: 60,
              color: lightGrey,
              child: TextFormField(
                controller: controller.searchController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: Icon(Icons.search).onTap(() {
                      if (controller
                          .searchController.text.isNotEmptyAndNotNull) {
                        Get.to(() => SearchScreen(
                              title: controller.searchController.text,
                            ));
                      }
                    }),
                    filled: true,
                    fillColor: whiteColor,
                    hintText: searchAnything,
                    hintStyle: const TextStyle(
                      color: redColor,
                    )),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      height: 150,
                      enlargeCenterPage: true,
                      itemCount: brandList.length,
                      itemBuilder: (context, index) {
                        return Image.asset(brandList[index],
                                fit: BoxFit.fitWidth)
                            .box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(const EdgeInsets.symmetric(horizontal: 8))
                            .make();
                      },
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                          2,
                          (index) => homeButton(
                              width: context.screenWidth / 2.5,
                              height: context.screenHeight * 0.15,
                              icon: index == 0 ? icTodaysDeal : icFlashDeal,
                              title: index == 0 ? todayDeal : flashSale),
                        )),
                    VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      height: 150,
                      enlargeCenterPage: true,
                      itemCount: secondBrandList.length,
                      itemBuilder: (context, index) {
                        return Image.asset(secondBrandList[index],
                                fit: BoxFit.fitWidth)
                            .box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(const EdgeInsets.symmetric(horizontal: 8))
                            .make();
                      },
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                          3,
                          (index) => homeButton(
                              width: context.screenWidth / 3.5,
                              height: context.screenHeight * 0.15,
                              icon: index == 0
                                  ? icTopCategories
                                  : index == 1
                                      ? icBrands
                                      : icTopSeller,
                              title: index == 0
                                  ? topCategories
                                  : index == 1
                                      ? brand
                                      : topSeller),
                        )),
                    10.heightBox,
                    Align(
                        alignment: Alignment.centerLeft,
                        child: featuredCategories.text
                            .color(darkFontGrey)
                            .size(18)
                            .fontFamily(semibold)
                            .make()),
                    5.heightBox,
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                            3,
                            (index) => Column(
                                  children: [
                                    featuredButton(
                                        icon: featuredImg1[index],
                                        title: featuredTitle1[index]),
                                    10.heightBox,
                                    featuredButton(
                                        icon: featuredImg2[index],
                                        title: featuredTitle2[index]),
                                  ],
                                )).toList(),
                      ),
                    ),
                    10.heightBox,
                    Container(
                      padding: const EdgeInsets.all(12),
                      width: double.infinity,
                      decoration: const BoxDecoration(color: redColor),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          featuredProduct.text.white
                              .fontFamily(bold)
                              .size(18)
                              .make(),
                          10.heightBox,
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: StreamBuilder(
                              stream: FireStoreServices.getFeaturedProduct(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasData) {
                                  var featureddata = snapshot.data!.docs;
                                  return Row(
                                    children: List.generate(
                                        featureddata.length,
                                        (index) => Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Image.network(
                                                  featureddata[index]
                                                      ['p_images'][0],
                                                  width: 150,
                                                  height: 130,
                                                  fit: BoxFit.cover,
                                                ),
                                                10.heightBox,
                                                "${featureddata[index]['p_name']}"
                                                    .text
                                                    .color(darkFontGrey)
                                                    .fontFamily(semibold)
                                                    .make(),
                                                10.heightBox,
                                                "${featureddata[index]['p_prices']}"
                                                    .numCurrency
                                                    .text
                                                    .color(redColor)
                                                    .fontFamily(bold)
                                                    .size(16)
                                                    .make()
                                              ],
                                            )
                                                .box
                                                .white
                                                .margin(
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 4))
                                                .roundedSM
                                                .padding(
                                                    const EdgeInsets.all(8))
                                                .make()
                                                .onTap(() {
                                              Get.to(() => ItemDetails(
                                                    title:
                                                        "${featureddata[index]['p_name']}",
                                                    data: featureddata[index],
                                                  ));
                                            })),
                                  );
                                } else if (snapshot.data!.docs.isEmpty) {
                                  return "No Featured Product"
                                      .text
                                      .white
                                      .makeCentered();
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      valueColor:
                                          AlwaysStoppedAnimation(redColor),
                                    ),
                                  );
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    10.heightBox,
                    VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      height: 150,
                      enlargeCenterPage: true,
                      itemCount: secondBrandList.length,
                      itemBuilder: (context, index) {
                        return Image.asset(secondBrandList[index],
                                fit: BoxFit.fitWidth)
                            .box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(const EdgeInsets.symmetric(horizontal: 8))
                            .make();
                      },
                    ),
                    10.heightBox,
                    StreamBuilder(
                      stream: FireStoreServices.allProduct(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                              child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(redColor),
                          ));
                        } else {
                          var allproductdata = snapshot.data!.docs;
                          return GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: allproductdata.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 8,
                                    crossAxisSpacing: 8,
                                    mainAxisExtent: 300),
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    allproductdata[index]['p_images'][0],
                                    fit: BoxFit.cover,
                                  ).box.size(150, 150).make(),
                                  const Spacer(),
                                  "${allproductdata[index]['p_name']}"
                                      .text
                                      .color(darkFontGrey)
                                      .fontFamily(semibold)
                                      .make(),
                                  10.heightBox,
                                  "${allproductdata[index]['p_prices']}"
                                      .numCurrency
                                      .text
                                      .color(redColor)
                                      .fontFamily(bold)
                                      .size(16)
                                      .make()
                                ],
                              )
                                  .box
                                  .white
                                  .margin(
                                      const EdgeInsets.symmetric(horizontal: 4))
                                  .roundedSM
                                  .padding(const EdgeInsets.all(12))
                                  .make()
                                  .onTap(() {
                                Get.to(() => ItemDetails(
                                      title:
                                          "${allproductdata[index]['p_name']}",
                                      data: allproductdata[index],
                                    ));
                              });
                            },
                          );
                        }
                      },
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
