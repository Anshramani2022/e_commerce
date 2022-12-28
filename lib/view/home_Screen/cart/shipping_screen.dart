import 'package:emart_app/Widget_common/commonButton.dart';
import 'package:emart_app/Widget_common/common_textfield.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/view/home_Screen/cart/payment_method.dart';
import 'package:get/get.dart';

<<<<<<< HEAD
import 'component/cart_controller.dart';
=======
import '../../../controller/cart_controller.dart';
>>>>>>> origin/master

class ShippingDetails extends StatelessWidget {
  const ShippingDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Shipping info"
            .text
            .size(18)
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: commonButton(
            title: "Countinue",
            color: redColor,
            onPress: () {
              if (controller.addressController.text.isEmpty &&
                  controller.cityController.text.isEmpty &&
                  controller.stateController.text.isEmpty &&
                  controller.postelcodeController.text.isEmpty &&
                  controller.phoneController.text.isEmpty) {
                VxToast.show(context, msg: "Please Fill The Form");
              } else {
                Get.to(() => const PaymentMehtods());
              }
            },
            textColor: whiteColor),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              customTextField(
                hint: "Address",
                isPass: false,
                title: "Address",
                controller: controller.addressController,
              ),
              customTextField(
                hint: "City",
                isPass: false,
                title: "City",
                controller: controller.cityController,
              ),
              customTextField(
                hint: "State",
                isPass: false,
                title: "State",
                controller: controller.stateController,
              ),
              customTextField(
                  hint: "Postel Code",
                  isPass: false,
                  title: "Postel Code",
                  controller: controller.postelcodeController,
                  inputFormatter: 6,
                  keyboardType: TextInputType.number),
              customTextField(
                  hint: "Phone",
                  isPass: false,
                  title: "Phone",
                  controller: controller.phoneController,
                  inputFormatter: 10,
                  keyboardType: TextInputType.number),
            ],
          ),
        ),
      ),
    );
  }
}
