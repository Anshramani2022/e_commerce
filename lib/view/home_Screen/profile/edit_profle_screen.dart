import 'dart:io';

import 'package:emart_app/consts/consts.dart';
import 'package:get/get.dart';

import '../../../Widget_common/bg_widget.dart';
import '../../../Widget_common/commonButton.dart';
import '../../../Widget_common/common_textfield.dart';
import '../../../controller/profile_controller.dart';

class EditScreen extends StatelessWidget {
  final dynamic data;
  const EditScreen({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();

    return bgWidget(
        child: Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Obx(
            () => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //if data and controller is empty
                data['imageUrl'] == '' && controller.profileImg.isEmpty
                    ? Image.asset(
                        imgProfile2,
                        fit: BoxFit.cover,
                        width: 115,
                      ).box.roundedFull.clip(Clip.antiAlias).make()
                    :
                    //if data is not empty but controller is empty
                    data['imageUrl'] != '' && controller.profileImg.isEmpty
                        ? Image.network(
                            data['imageUrl'],
                            fit: BoxFit.cover,
                            width: 115,
                          ).box.roundedFull.clip(Clip.antiAlias).make()
                        : Image.file(
                            File(controller.profileImg.value),
                            fit: BoxFit.cover,
                            width: 115,
                          ).box.roundedFull.clip(Clip.antiAlias).make(),
                10.heightBox,
                commonButton(
                  color: redColor,
                  title: "Edit",
                  textColor: whiteColor,
                  onPress: () {
                    FocusScope.of(context).unfocus();

                    controller.changeImage(context);
                  },
                ),
                const Divider(),
                20.heightBox,
                customTextField(
                    title: nameHint,
                    isPass: false,
                    hint: name,
                    controller: controller.nameController),
                customTextField(
                    title: password,
                    isPass: true,
                    hint: password,
                    controller: controller.passController),
                const Divider(),
                controller.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(redColor),
                      ))
                    : SizedBox(
                        width: context.screenWidth - 40,
                        child: commonButton(
                          color: redColor,
                          title: "Save",
                          textColor: whiteColor,
                          onPress: () async {
                            controller.isLoading(true);
                            await controller.uploadImage();
                            await controller.updateProfile(
                                imgUrl: controller.profileImgLink,
                                password: controller.passController.text,
                                name: controller.nameController.text);
                            VxToast.show(context, msg: "Profile Updated");
                          },
                        ),
                      ),
              ],
            )
                .box
                .shadowSm
                .white
                .padding(const EdgeInsets.all(16))
                .margin(const EdgeInsets.only(top: 50, left: 12, right: 12))
                .rounded
                .make(),
          ),
        ),
      ),
    ));
  }
}
