import 'package:emart_app/controller/home_controlller.dart';
import 'package:emart_app/view/splash_screen/splash_screen.dart';
import 'package:get/get.dart';
import 'consts/consts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appname,
      theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.transparent,
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              iconTheme: IconThemeData(color: darkFontGrey)),
          fontFamily: regular),
      home: const SplashScreen(),
    );
  }

  HomeController controller = Get.put(HomeController());
}
