import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controller/home_controlller.dart';
import 'package:emart_app/view/home_Screen/account.dart';
import 'package:emart_app/view/home_Screen/cart.dart';
import 'package:emart_app/view/home_Screen/category/category.dart';
import 'package:emart_app/view/home_Screen/home_screen/home_screen.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());

    var navBody = [
      const HomeScreen(),
      const CategoryScreen(),
      const CartScreen(),
      const AccountScreen(),
    ];

    var navBarItem = [
      BottomNavigationBarItem(
          icon: Image.asset(
            icHome,
            width: 26,
          ),
          label: home),
      BottomNavigationBarItem(
          icon: Image.asset(
            icCategories,
            width: 26,
          ),
          label: category),
      BottomNavigationBarItem(
          icon: Image.asset(
            icCart,
            width: 26,
          ),
          label: cart),
      BottomNavigationBarItem(
          icon: Image.asset(
            icProfile,
            width: 26,
          ),
          label: account)
    ];
    return Scaffold(
      body: Column(
        children: [
          Obx(() => Expanded(
                child: navBody.elementAt(controller.currentNavIndex.value),
              )),
        ],
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.currentNavIndex.value,
          type: BottomNavigationBarType.fixed,
          backgroundColor: whiteColor,
          selectedItemColor: redColor,
          selectedLabelStyle: const TextStyle(fontFamily: semibold),
          items: navBarItem,
          onTap: (value) {
            controller.currentNavIndex.value = value;
          },
        ),
      ),
    );
  }
}
