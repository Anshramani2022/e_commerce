import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controller/auth_controller.dart';
import 'package:emart_app/view/auth_screen/login_screen.dart';
import 'package:get/get.dart';

import '../../../Widget_common/bg_widget.dart';
import 'component/details_cart.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      body: SafeArea(
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
                  )).onTap(() {}),
            ),
            //user detail section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Image.asset(
                    imgProfile2,
                    fit: BoxFit.cover,
                    width: 115,
                  ).box.roundedFull.clip(Clip.antiAlias).make(),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      "Dummy User".text.fontFamily(semibold).white.make(),
                      currentUser!.email!.text.white.make(),
                    ],
                  )),
                  OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: whiteColor)),
                      onPressed: () async {
                        await Get.put(AuthController()).signoutMethod(context);
                        Get.to(() => const LoginScreen());
                      },
                      child: "Log out".text.fontFamily(semibold).white.make())
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
                    number: "00"),
                detailsCart(
                    width: context.screenWidth / 3.4,
                    title: "In your wishlist",
                    number: "32"),
                detailsCart(
                    width: context.screenWidth / 3.4,
                    title: "Your Order",
                    number: "675"),
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
      ),
    ));
  }
}
