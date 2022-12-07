import 'package:emart_app/consts/consts.dart';

Widget HomeButton({width, height, icon, String? title, onPress}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(icon, width: 26),
      10.heightBox,
      title!.text.color(darkFontGrey).fontFamily(semibold).make()
    ],
  ).box.rounded.white.size(width, height).make();
}
