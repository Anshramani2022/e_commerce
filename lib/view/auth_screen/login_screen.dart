import 'package:emart_app/Widget_common/bg_widget.dart';
import 'package:emart_app/Widget_common/common_appLogo.dart';
import 'package:emart_app/consts/consts.dart';

import '../../Widget_common/commonButton.dart';
import '../../Widget_common/common_textfield.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BgWidget(
        child: Scaffold(
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.1).heightBox,
            appLogoWidget(),
            10.heightBox,
            "Log In To $appname".text.white.size(22).fontFamily(bold).make(),
            10.heightBox,
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
                CommonButton(
                        title: login,
                        color: redColor,
                        onPress: () {},
                        textColor: whiteColor)
                    .box
                    .width(context.screenWidth - 50)
                    .make(),
                5.heightBox,
                createNewAccount.text.color(fontGrey).make(),
                5.heightBox,
                CommonButton(
                        title: signup,
                        color: lightgolden,
                        onPress: () {},
                        textColor: redColor)
                    .box
                    .width(context.screenWidth - 50)
                    .make(),
                10.heightBox,
                loginwith.text.color(fontGrey).make(),
                5.heightBox,
              ],
            )
                .box
                .white
                .rounded
                .padding(const EdgeInsets.all(16))
                .width(context.screenWidth - 70)
                .make(),
          ],
        ),
      ),
    ));
  }
}
