import 'package:emart_app/Widget_common/bg_widget.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/view/home_Screen/category/item_detail.dart';
import 'package:get/get.dart';

class CategoryDetail extends StatelessWidget {
  final String? title;
  const CategoryDetail({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      appBar: AppBar(
        title: title!.text.white.fontFamily(bold).make(),
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    6,
                    (index) => "baby Frok"
                        .text
                        .fontFamily(semibold)
                        .color(darkFontGrey)
                        .size(12)
                        .makeCentered()
                        .box
                        .white
                        .size(120, 60)
                        .margin(const EdgeInsets.symmetric(horizontal: 4))
                        .rounded
                        .make(),
                  ),
                )),
            20.heightBox,
            Expanded(
                child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: 6,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 7,
                mainAxisExtent: 250,
              ),
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      imgP5,
                      height: 150,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                    "Laptop 4GB/512ssd"
                        .text
                        .color(darkFontGrey)
                        .fontFamily(semibold)
                        .make(),
                    "\$600"
                        .text
                        .color(redColor)
                        .fontFamily(bold)
                        .size(16)
                        .make()
                  ],
                )
                    .box
                    .white
                    .outerShadowSm
                    .margin(const EdgeInsets.symmetric(horizontal: 4))
                    .roundedSM
                    .padding(const EdgeInsets.all(9))
                    .make()
                    .onTap(() {
                  Get.to(() => const ItemDetails(
                        title: "Dummy Title",
                      ));
                });
              },
            ))
          ],
        ),
      ),
    ));
  }
}
