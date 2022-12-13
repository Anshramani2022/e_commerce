import 'package:emart_app/Widget_common/bg_widget.dart';
import 'package:emart_app/Widget_common/common_appLogo.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/view/auth_screen/signup_Screen.dart';
import 'package:emart_app/view/home_Screen/home.dart';
import 'package:get/get.dart';

import '../../Widget_common/commonButton.dart';
import '../../Widget_common/common_textfield.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.1).heightBox,
            appLogoWidget(),
            10.heightBox,
            "Log In To $appname".text.white.size(22).fontFamily(bold).make(),
            15.heightBox,
            Column(
              children: [
                customTextField(hint: emailHint, title: email),
                customTextField(title: password, hint: passwordHint),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () {}, child: forgetPass.text.make()),
                ),
                5.heightBox,
                commonButton(
                        title: login,
                        color: redColor,
                        onPress: () {
                          Get.to(() => const Home());
                          // Get.to(() => Home());
                        },
                        textColor: whiteColor)
                    .box
                    .width(context.screenWidth - 50)
                    .make(),
                5.heightBox,
                createNewAccount.text.color(fontGrey).make(),
                5.heightBox,
                commonButton(
                  title: signup,
                  color: lightgolden,
                  onPress: () {
                    Get.to(() => const SignUpScreen());
                  },
                  textColor: redColor,
                ).box.width(context.screenWidth - 50).make(),
                10.heightBox,
                loginwith.text.color(fontGrey).make(),
                5.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                      3,
                      (index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundColor: lightGrey,
                              radius: 35,
                              child: Image.asset(
                                socialIconList[index],
                                width: 30,
                              ),
                            ),
                          )),
                )
              ],
            )
                .box
                .white
                .rounded
                .shadowSm
                .padding(const EdgeInsets.all(16))
                .width(context.screenWidth - 70)
                .make(),
          ],
        ),
      ),
    ));
  }
}
