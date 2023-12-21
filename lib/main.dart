import 'package:flutter/material.dart';

import 'layout/home-screen.dart';
import 'product-details.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      //
      // initialRoute: HomeScreen.routeName,
      // routes: {
      //   HomeScreen.routeName: (context) => HomeScreen(),
      //   ProductDetails.routeName:(context) => ProductDetails()
      //
      // },
    );
  }
}
///////////////////////////////////////////////////////////////////
// for (int i = 0; i < details!.variations!.length; i++)
//   {
//     for (int j = 0; i < details.variations![i].productVarientImages!.length; j++)
//
//     //ProductVarientImages.add(details.variations[i].productVarientImages[j].imagePath);
//   }




// ///////////////////////////////////////////////////////////////////
// for (int i = 0; i < details!.avaiableProperties!.length; i++) {
//   if (details.avaiableProperties == []) {
//     sizesExist = false;
//     colorsExist = false;
//     materialsExist = false;
//     break;
//   }
//   if (details.avaiableProperties![i].property == "Materials") {
//     materialsExist = true;
//   }
//   if (details.avaiableProperties![i].property == "Color") {
//     colorsExist = true;
//   }
//   if (details.avaiableProperties![i].property == "Size") {
//     sizesExist = true;
//   }
// }
