import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controller/auth_controller.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/view/auth_screen/login_screen.dart';
import 'package:emart_app/view/home_Screen/profile/edit_profle_screen.dart';
import 'package:get/get.dart';

import '../../../Widget_common/bg_widget.dart';
import '../../../controller/profile_controller.dart';
import 'component/details_cart.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return bgWidget(
        child: Scaffold(
            body: StreamBuilder(
      stream: FireStoreServices.getUser(currentUser!.uid),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
              child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(redColor),
          ));
        } else {
          var data = snapshot.data!.docs[0];
          log("======>$data");
          return SafeArea(
            child: Column(
              children: [
                //edit profile const e
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Align(
                      alignment: Alignment.topRight,
                      child: Icon(
                        Icons.edit,
                        color: whiteColor,
                      )).onTap(() {
                    controller.nameController.text = data['name'];
                    controller.passController.text = data['password'];

                    Get.to(() => EditScreen(data: data));
                  }),
                ),
                //user detail section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      data['imageUrl'] == ''
                          ? Image.asset(
                              imgProfile2,
                              fit: BoxFit.cover,
                              width: 115,
                            ).box.roundedFull.clip(Clip.antiAlias).make()
                          : Image.network(
                              data['imageUrl'],
                              fit: BoxFit.cover,
                              width: 115,
                            ).box.roundedFull.clip(Clip.antiAlias).make(),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          "${data['name']}"
                              .text
                              .fontFamily(semibold)
                              .white
                              .make(),
                          currentUser!.email!.text.white.make(),
                        ],
                      )),
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: whiteColor)),
                          onPressed: () async {
                            await Get.put(AuthController())
                                .signoutMethod(context);
                            Get.to(() => const LoginScreen());
                          },
                          child:
                              "Log out".text.fontFamily(semibold).white.make())
                    ],
                  ),
                ),
                // 20.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    detailsCart(
                        width: context.screenWidth / 3.4,
                        title: "In your cart",
                        number: data["cart_count"]),
                    detailsCart(
                        width: context.screenWidth / 3.4,
                        title: "In your wishlist",
                        number: data["wishlist_count"]),
                    detailsCart(
                        width: context.screenWidth / 3.4,
                        title: "Your Order",
                        number: data["order_count"]),
                  ],
                ),

                //Button section
                ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: Image.asset(
                              profileButtonsIcon[index],
                              width: 22,
                            ),
                            title: profileButtonsList[index]
                                .text
                                .color(darkFontGrey)
                                .fontFamily(semibold)
                                .make(),
                          );
                        },
                        separatorBuilder: (context, index) => const Divider(),
                        itemCount: profileButtonsList.length)
                    .box
                    .rounded
                    .margin(const EdgeInsets.all(12))
                    .white
                    .padding(const EdgeInsets.symmetric(horizontal: 16))
                    .shadowSm
                    .make()
                    .box
                    .color(redColor)
                    .make()
              ],
            ),
          );
        }
      },
    )));
  }
}
