import 'package:emart_app/Widget_common/bg_widget.dart';
import 'package:emart_app/consts/consts.dart';

class CategoryDetail extends StatelessWidget {
  final String? title;
  const CategoryDetail({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BgWidget(
        child: Scaffold(
      appBar: AppBar(
        title: title!.text.white.fontFamily(bold).make(),
      ),
    ));
  }
}
