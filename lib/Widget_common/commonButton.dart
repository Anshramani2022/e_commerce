import 'package:emart_app/consts/consts.dart';

Widget CommonButton({color, textColor, String? title, onPress}) {
  return ElevatedButton(
      style:
          ElevatedButton.styleFrom(primary: color, padding: EdgeInsets.all(10)),
      onPressed: () {
        onPress;
      },
      child: title!.text.fontFamily(bold).color(textColor).make());
}
