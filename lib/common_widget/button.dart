import 'package:cartify_app/consts/consts.dart';

Widget btn(onpress,color,textcolor,String title){
return ElevatedButton(
  style: ElevatedButton.styleFrom(
    primary: color,
    padding: EdgeInsets.all(11),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(3),
  )
  ),
  onPressed: onpress, child: title.text.color(textcolor).fontFamily(bold).make());
}