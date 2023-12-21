// ignore_for_file: non_constant_identifier_names, avoid_function_literals_in_foreach_calls

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:slash/models/colors.dart';
import 'package:slash/models/details.dart';
import 'package:slash/models/materials.dart';
import 'package:slash/models/sizes.dart';

import 'network/remote/api_manager.dart';

class ProductDetails extends StatefulWidget {
  int id;

  ProductDetails(this.id, {super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  List<String> allImages = [];

  /////////////////////////////////////////color
  List<ColorModel> variationColorImg = []; /////////model in design
  List<String> ProductVarientColorImages = [];

  /////////////////////////////////////////size
  List<SizesModel> variationSizeImg = [];
  List<String> ProductVarientSizeImages = [];

  /////////////////////////////////////////material
  List<MaterialsModel> variationMaterialImg = [];
  List<String> ProductVarientMaterialImages = [];
  Details? details;
  int currentIndex = 0;
  int colorIndex = 0;
  bool availbleProFlag = false;

  @override
  void initState() {
    print(widget.id);
    initMethod();
    super.initState();
  }

  initMethod() async {
    details = await ApiManager.getDetails(widget.id);
    print(details!.data!.avaiableProperties![0].values![0].value);
  }

  Future<List<ColorModel>> initColorMethod() async {
    variationColorImg = [];
    details = await ApiManager.getDetails(widget.id);
    if (details!.data!.avaiableProperties != null &&
        details!.data!.avaiableProperties!.isNotEmpty) {
      details!.data!.avaiableProperties!.forEach((element) {
        if (element.property == "Color") {
          element.values!.forEach((element) {
            int id = element.id!;
            String colorCode = element.value!;
            details!.data!.variations!.forEach((element) {
              if (element.id == id) {
                ProductVarientColorImages = [];
                element.productVarientImages!.forEach((element) {
                  ProductVarientColorImages.add(element.imagePath!);
                  /////////////////////////////////////////////////////////
                  // allImages.add(element.imagePath!);
                });
                variationColorImg
                    .add(ColorModel(id, colorCode, ProductVarientColorImages));
              }
            });
          });
        }
      });
    } else {
      availbleProFlag = true;
    }
    return variationColorImg;
  }

  Future<List<MaterialsModel>> initMaterialMethod() async {
    variationMaterialImg = [];
    details = await ApiManager.getDetails(widget.id);
    if (details!.data!.avaiableProperties != null &&
        details!.data!.avaiableProperties!.isNotEmpty) {
      details!.data!.avaiableProperties!.forEach((element) {
        if (element.property == "Materials") {
          element.values!.forEach((element) {
            int id = element.id!;
            String materialName = element.value!;
            details!.data!.variations!.forEach((element) {
              if (element.id == id) {
                ProductVarientMaterialImages = [];
                element.productVarientImages!.forEach((element) {
                  ProductVarientMaterialImages.add(element.imagePath!);
                  /////////////////////////////////////////////////////////
                  allImages.add(element.imagePath!);
                });
                variationMaterialImg.add(MaterialsModel(
                    id, materialName, ProductVarientMaterialImages));
              }
            });
          });
        }
      });
    }
    return variationMaterialImg;
  }

  Future<List<SizesModel>> initSizeMethod() async {
    variationSizeImg = [];
    details = await ApiManager.getDetails(widget.id);
    if (details!.data!.avaiableProperties != null &&
        details!.data!.avaiableProperties!.isNotEmpty) {
      details!.data!.avaiableProperties!.forEach((element) {
        if (element.property == "Size") {
          element.values!.forEach((element) {
            int id = element.id!;
            String sizeName = element.value!;
            details!.data!.variations!.forEach((element) {
              if (element.id == id) {
                ProductVarientSizeImages = [];
                element.productVarientImages!.forEach((element) {
                  ProductVarientSizeImages.add(element.imagePath!);
                  /////////////////////////////////////////////////////////
                  allImages.add(element.imagePath!);
                });
                variationSizeImg
                    .add(SizesModel(id, sizeName, ProductVarientSizeImages));
              }
            });
          });
        }
      });
    }
    return variationSizeImg;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black12,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            "product details",
            style: TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.w400,
            ),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  FutureBuilder(
                    future: ApiManager.getDetails(widget.id),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting)
                        return Center(child: CircularProgressIndicator());
                      if (snapshot.hasError)
                        return Text("${snapshot.data!.message!}");

                      /////////////////////////////////////////////////////////
                      //var details = snapshot.data?.data ?? [];

                      var brandImg = snapshot.data!.data!.brandImage;
                      var brandname = snapshot.data!.data!.brandName;
                      var productname = snapshot.data!.data!.name;
                      var description = snapshot.data!.data!.description;
                      var price = snapshot.data!.data!.variations!.first.price;

                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text("${productname}",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16)),
                                    Text("EGP ${price}",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16))
                                  ],
                                ),
                                Column(
                                  children: [
                                    CachedNetworkImage(
                                      height: 30,
                                      width: 30,
                                      imageUrl: brandImg ?? "",
                                      imageBuilder: (context, imageProvider) {
                                        return Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover)),
                                        );
                                      },
                                      placeholder: (context, url) => Center(
                                          child: CircularProgressIndicator()),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                    Text("$brandname",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18))
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Description",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18)),
                                  Text(description ?? "",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16)),
                                ]),
                          ),
                        ],
                      );
                    },
                  )
                ],
              ),

              ///////////////////////////////////////////////////////////////////////////////
              ///////////////////////////////////////////////////////////////////////////////
              ///////////////////////////////////////////////////////////////////////////////
              if (availbleProFlag)
                ListView(
                  physics: const BouncingScrollPhysics(),
                  children: details!.data!.variations!
                      .map(
                        (e) => SizedBox(
                          height: 100,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: e.productVarientImages!
                                  .map(
                                    (e) => SizedBox(
                                      width: 100,
                                      height: 100,
                                      child: Image.network(
                                        "${e.imagePath}.jpg",
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              if (!availbleProFlag)
                FutureBuilder(
                    future: initColorMethod(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<ColorModel> listC = snapshot.data!;
                        return listC.isNotEmpty
                            ? Column(
                                children: [
                                  Image(
                                    fit: BoxFit.fill,
                                    height: 300,
                                    width: double.infinity,
                                    image: NetworkImage(
                                      "${listC[colorIndex].variationImgs[currentIndex]}.jpg", //////currentIndex==0
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: listC
                                        .toSet()
                                        .toList()[colorIndex]
                                        .variationImgs
                                        .toSet()
                                        .toList()
                                        .asMap()
                                        .entries
                                        .map(
                                      (e) {
                                        int idx = e.key;
                                        return InkWell(
                                          onTap: () {
                                            setState(() {
                                              currentIndex = idx;
                                            });
                                          },
                                          child: Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            child: Image(
                                              image: NetworkImage(
                                                "${e.value}.jpg",
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ).toList(),
                                  ),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: listC
                                          .toSet()
                                          .toList()
                                          .asMap()
                                          .entries
                                          .toSet()
                                          .toList()
                                          .map(
                                            (e) => InkWell(
                                              onTap: () {
                                                print(listC);
                                                setState(() {
                                                  colorIndex = e.key;
                                                });
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: CircleAvatar(
                                                  radius: 25,
                                                  backgroundColor: Color(
                                                    int.parse(
                                                        "0xFF${e.value.colorCode.replaceAll("#", "")}"),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                          .toList()
                                          .toSet()
                                          .toList(),
                                    ),
                                  ),
                                ],
                              )
                            : Container();
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }),

              // FutureBuilder(
              //     future: initSizeMethod(),
              //     builder: (context, snapshot) {
              //       if (snapshot.hasData) {
              //         List<SizesModel> listC = snapshot.data!;
              //         return Row(
              //           children: listC.isNotEmpty
              //               ? listC[0]
              //                   .variationImgs
              //                   .map(
              //                     (e) => Image(image: NetworkImage("$e.jpg")),
              //                   )
              //                   .toList()
              //               : [],
              //         );
              //       }
              //       return const Center(
              //         child: CircularProgressIndicator(),
              //       );
              //     }),

              // FutureBuilder(
              //     future: initMaterialMethod(),
              //     builder: (context, snapshot) {
              //       if (snapshot.hasData) {
              //         List<MaterialsModel> listC = snapshot.data!;
              //         print("hhhhhhhhhhhhhhhhhhhhhhh${listC[0].variationImgs}");
              //         return Column(
              //           children: listC[0]
              //               .variationImgs
              //               .map(
              //                 (e) => Image(image: NetworkImage("$e.jpg")),
              //               )
              //               .toList(),
              //
              //           // Expanded(
              //           //   child: ListView.builder(
              //           //     itemBuilder: (context, index) {
              //           //       return Text((variationColorImg.isNotEmpty)
              //           //           ? "${variationColorImg[index].variationImgs[0]}++++"
              //           //           : "empty");
              //           //     },
              //           //     itemCount: variationColorImg.length,
              //           //   ),
              //           // ),
              //           // const Text("hello"),
              //           // Expanded(
              //           //   child: ListView.builder(
              //           //     itemBuilder: (context, index) {
              //           //       return Text((allImages.isNotEmpty)
              //           //           ? "$index = ${allImages[index]}++++"
              //           //           : "empty");
              //           //     },
              //           //     itemCount: variationColorImg.length,
              //           //   ),
              //           // )
              //           //],
              //
              //           // ///////model to widget
              //           // ////0 is index of 1st index in value //63 in color
              //           //
              //           // children: (variationColorImg.isNotEmpty)
              //           //     ? variationColorImg[1]
              //           //         .variationImgs
              //           //         .map((e) => Image.network(e))
              //           //         .toList()
              //           //     : []
              //         );
              //       }
              //       return const Center(
              //         child: CircularProgressIndicator(),
              //       );
              //     }),
            ],
          ),
        ));
  }
}
