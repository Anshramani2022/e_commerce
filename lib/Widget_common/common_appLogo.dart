import 'package:emart_app/consts/consts.dart';

Widget appLogoWidget() {
  return Image.asset(icAppLogo)
      .box
      .white
      .size(95, 95)
      .padding(const EdgeInsets.all(8))
      .rounded
      .make();
}
