import 'package:cartify_app/consts/consts.dart';

Widget profiledetailbtn({width,String? count,String? title}){
  return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  count!.text.fontFamily(bold).size(16).color(darkFontGrey).make(),
                  5.heightBox,
                  title!.text.color(darkFontGrey).align(TextAlign.center).makeCentered(),
                ],
              ).box.white.rounded.height(80).width(width).padding(EdgeInsets.all(4)).make();
}