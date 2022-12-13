import 'package:emart_app/consts/consts.dart';

typedef OnPress = Function();

Widget commonButton({color, textColor, String? title, OnPress? onPress}) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: color, padding: const EdgeInsets.all(10)),
      onPressed: onPress,
      child: title!.text.fontFamily(bold).color(textColor).make());
}
