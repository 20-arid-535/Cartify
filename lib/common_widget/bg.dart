import 'package:cartify_app/consts/consts.dart';

Widget bg({Widget? child}){
  return Container(
    decoration: BoxDecoration(
      image: DecorationImage(image: AssetImage(imgBackground),fit:BoxFit.fill)
    ),
    child: child,
  );
  
  }