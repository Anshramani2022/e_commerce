import 'package:emart_app/Widget_common/bg_widget.dart';
import 'package:emart_app/Widget_common/common_appLogo.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:get/get.dart';

import '../../Widget_common/commonButton.dart';
import '../../Widget_common/common_textfield.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool? isChecked = false;
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
            "Join the $appname".text.white.size(22).fontFamily(bold).make(),
            15.heightBox,
            Column(
              children: [
                customTextField(hint: nameHint, title: name),
                customTextField(hint: emailHint, title: email),
                customTextField(hint: passwordHint, title: password),
                customTextField(title: retypePassword, hint: passwordHint),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () {}, child: forgetPass.text.make()),
                ),
                5.heightBox,
                Row(
                  children: [
                    Checkbox(
                      checkColor: redColor,
                      value: isChecked,
                      onChanged: (value) {
                        setState(() {
                          isChecked = value;
                        });
                      },
                    ),
                    10.widthBox,
                    Expanded(
                      child: RichText(
                          text: const TextSpan(children: [
                        TextSpan(
                            text: "I agree to the ",
                            style: TextStyle(
                                color: fontGrey, fontFamily: regular)),
                        TextSpan(
                            text: termAndCondition,
                            style: TextStyle(
                                color: redColor, fontFamily: regular)),
                        TextSpan(
                            text: " & ",
                            style: TextStyle(
                                color: redColor, fontFamily: regular)),
                        TextSpan(
                            text: privacyPolicy,
                            style: TextStyle(
                                color: redColor, fontFamily: regular)),
                      ])),
                    )
                  ],
                ),
                10.heightBox,
                commonButton(
                        title: signup,
                        color: isChecked == true ? redColor : lightGrey,
                        onPress: () {},
                        textColor: whiteColor)
                    .box
                    .width(context.screenWidth - 50)
                    .make(),
                10.heightBox,
                RichText(
                    text: const TextSpan(children: [
                  TextSpan(
                      text: "Already Have An Account? ",
                      style: TextStyle(fontFamily: bold, color: fontGrey)),
                  TextSpan(
                      text: "Log In",
                      style: TextStyle(fontFamily: bold, color: redColor))
                ])).onTap(() {
                  Get.back();
                })
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
