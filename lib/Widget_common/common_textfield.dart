import 'package:emart_app/consts/consts.dart';

Widget customTextField({String? title, String? hint, controller}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title!.text.size(16).fontFamily(semibold).color(redColor).make(),
      10.heightBox,
      TextFormField(
        controller: controller,
        decoration: InputDecoration(
            hintStyle: TextStyle(fontFamily: semibold, color: textfieldGrey),
            filled: true,
            border: InputBorder.none,
            fillColor: lightGrey,
            isDense: true,
            hintText: hint,
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: redColor))),
      ),
      10.heightBox,
    ],
  );
}
