import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:slash/network/remote/api_manager.dart';

import '../product-details.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const String routeName = "HomeScreen";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black12,
        appBar: AppBar(
            backgroundColor: Colors.black12,
            title: Text("Slash.",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.bold)),
            centerTitle: true),
        body: Column(children: [
          FutureBuilder(
            future: ApiManager.getProducts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Text("${snapshot.error}" ?? "");
              }
              var products = snapshot.data?.data ?? [];
              return Expanded(
                  child: GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 40,
                    mainAxisSpacing: 40),
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetails(products[index].id!),));
                        // Navigator.pushNamed(context, ProductDetails.routeName,
                        //     arguments: products[index].id);
                      },
                      /////////////////////////////////////////////////////////////////////////////////////
                      child: Column(
                        children: [
                          Expanded(
                              child: CachedNetworkImage(
                            imageUrl: products[index]
                                    .productVariations?[0]
                                    .productVarientImages!
                                    .first
                                    .imagePath ??
                                "",
                            imageBuilder: (context, imageProvider) {
                              return Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                        image: imageProvider, fit: BoxFit.cover)),
                              );
                            },
                            placeholder: (context, url) =>
                                Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          )),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                    "${products[index].brands?.brandName ?? ""} - ${products[index].name}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18
                                    ),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis),
                              ),
                              CachedNetworkImage(
                                height: 30,
                                width: 30,
                                imageUrl:
                                    products[index].brands?.brandLogoImagePath ??
                                        "",
                                imageBuilder: (context, imageProvider) {
                                  return Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover)),
                                  );
                                },
                                placeholder: (context, url) =>
                                    Center(child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              )
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  "EGP ${products[index].productVariations?.first.price}",
                                  style: TextStyle(
                                    color: Colors.white,
                                  )),
                              Icon(Icons.favorite_border, color: Colors.white),
                              Icon(Icons.pedal_bike_rounded, color: Colors.white)
                            ],
                          )
                        ],
                      ));
      
                  // Text(movies[index].title ?? "");
                },
                itemCount: products.length,
              ));
            },
          )
        ]),
      ),
    );
  }
}
