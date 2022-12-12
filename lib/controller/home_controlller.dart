import 'package:get/get.dart';

class HomeController extends GetxController {
  int _currentNavIndex = 0;

  int get currentNavIndex => _currentNavIndex;

  void setBottomIndex(int val) {
    _currentNavIndex = val;
    update();
  }
}
