import 'package:cartify_app/common_widget/exitdialog.dart';
import 'package:cartify_app/consts/consts.dart';
import 'package:cartify_app/controller/homecontroller.dart';
import 'package:cartify_app/views/cart_screen/cartscreen.dart';
import 'package:cartify_app/views/category_screen/categoryscreen.dart';
import 'package:cartify_app/views/home_screen/homescreen.dart';
import 'package:cartify_app/views/profile_screen/profilescreen.dart';

import 'package:get/get.dart';

class home extends StatelessWidget {
  home({super.key});
  var controller= Get.put(HomeController());
var navbaritem=[
BottomNavigationBarItem(icon: Image.asset(icHome,width:26),label: shome),
BottomNavigationBarItem(icon: Image.asset(icCategories,width:26),label: category),
BottomNavigationBarItem(icon: Image.asset(icCart,width:26),label: cart),
BottomNavigationBarItem(icon: Image.asset(icProfile,width:26),label: account),
];
var navbody=[
  HomeScreen(),
  CategoryScreen(),
  CartScreen(),
  ProfileScreen()
];
  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: () async {
        showDialog(
          barrierDismissible: false,
          context: context, builder: (context)=>exitDialog(context));
        return false;
      },
      child: Scaffold(
        body: Column(
          children: [
           Obx(() => Expanded(child: navbody.elementAt(controller.currentNavIndex.value))
        ),],
        ),
        bottomNavigationBar: Obx(()=> BottomNavigationBar(
            currentIndex: controller.currentNavIndex.value ,
            backgroundColor: whiteColor,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: redColor,
            selectedLabelStyle: TextStyle(fontFamily: bold),
            items: navbaritem,
            onTap: (value) {
              controller.currentNavIndex.value=value;
            },
            ),
        ),
      ),
    );
  }
}