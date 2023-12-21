import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../../models/details.dart';
import '../../models/product.dart';

class ApiManager {
  static Future<Product> getProducts() async {
    try {
      final connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult != ConnectivityResult.mobile &&
          connectivityResult != ConnectivityResult.wifi) {
        throw Exception("No Internet Connection");
      }
      Uri url = Uri.https("slash-backend.onrender.com", "/product");
      Response response = await http.get(url);
      var jsonData = jsonDecode(response.body);
      Product data = Product.fromJson(jsonData);
      return data;
    } catch (error) {
      throw error;
    }
  }

  static Future<Details> getDetails(int productId) async {
    try {
      final connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult != ConnectivityResult.mobile &&
          connectivityResult != ConnectivityResult.wifi) {
        throw Exception("No Internet Connection");
      }
      Uri url =
          Uri.https("slash-backend.onrender.com", "/product/${productId}");
      Response response = await http.get(url);
      var jsonData = jsonDecode(response.body);
      Details data = Details.fromJson(jsonData);
      return data;
    } catch (error) {
      throw error;
    }
  }
}

//   Column(
//   children: [
//     Expanded(
//         child: CachedNetworkImage(
//           imageUrl: productImgPath,
//           imageBuilder: (context, imageProvider) {
//             return Container(
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(15),
//                   image: DecorationImage(
//                       image: imageProvider, fit: BoxFit.cover)),
//             );
//           },
//           placeholder: (context, url) =>
//               Center(child: CircularProgressIndicator()),
//           errorWidget: (context, url, error) =>
//               Icon(Icons.error),
//         )),
//
//
//     Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//             "${brandName} - ${productName}",
//             style: TextStyle(
//               color: Colors.white,
//             )),
//         CachedNetworkImage(
//           height: 30,
//           width: 30,
//           imageUrl:
//           brandImgPath,
//           imageBuilder: (context, imageProvider) {
//             return Container(
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(15),
//                   image: DecorationImage(
//                       image: imageProvider,
//                       fit: BoxFit.cover)),
//             );
//           },
//           placeholder: (context, url) =>
//               Center(child: CircularProgressIndicator()),
//           errorWidget: (context, url, error) =>
//               Icon(Icons.error),
//         )
//       ],
//     ),
//
//
//     Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//             "EGP ${price}",
//             style: TextStyle(
//               color: Colors.white,
//             )),
//         Icon(Icons.favorite_border, color: Colors.white),
//         Icon(Icons.pedal_bike_rounded, color: Colors.white)
//       ],
//     )
//
//
//   ],
// );
