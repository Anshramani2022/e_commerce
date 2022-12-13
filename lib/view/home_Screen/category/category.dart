import 'package:emart_app/consts/consts.dart';
import 'package:get/get.dart';

import '../../../Widget_common/bg_widget.dart';
import 'category_detail.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BgWidget(
        child: Scaffold(
      appBar: AppBar(
        title: category.text.fontFamily(bold).white.make(),
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
          shrinkWrap: true,
          itemCount: 9,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisExtent: 200,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8),
          itemBuilder: (context, index) {
            return Column(
              children: [
                Image.asset(
                  categoryImages[index],
                  height: 120,
                  width: 200,
                  fit: BoxFit.cover,
                ),
                10.heightBox,
                categoriesList[index]
                    .text
                    .color(darkFontGrey)
                    .align(TextAlign.center)
                    .make(),
              ],
            )
                .box
                .rounded
                .white
                .clip(Clip.antiAlias)
                .outerShadowSm
                .make()
                .onTap(() {
              //to navigator
              Get.to(() => CategoryDetail(
                    title: categoriesList[index],
                  ));
            });
          },
        ),
      ),
    ));
  }
}
