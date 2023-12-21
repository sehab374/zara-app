import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:slash/models/colors.dart';
import 'package:slash/models/details.dart';
import 'package:slash/models/materials.dart';
import 'package:slash/models/sizes.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'network/remote/api_manager.dart';

class ProductDetails extends StatefulWidget {
  int id;

  ProductDetails(this.id);

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

  @override
  void initState() {
    super.initState();
    initColorMethod();
    initMaterialMethod();
    initSizeMethod();
  }

  void initColorMethod() async {
    int id = widget.id;
    Details details = await ApiManager.getDetails(id);
    //print("colors+++++++${details.data}");
    if (details.data!.avaiableProperties != null &&
        details.data!.avaiableProperties!.isNotEmpty) {
      details.data!.avaiableProperties!.forEach((element) {
        if (element.property == "Color") {
          element.values!.forEach((element) {
            int id = element.id!;
            String colorCode = element.value!;
            details.data!.variations!.forEach((element) {
              if (element.id == id) {
                ProductVarientColorImages = [];
                element.productVarientImages!.forEach((element) {
                  ProductVarientColorImages.add(element.imagePath!);
                  /////////////////////////////////////////////////////////
                  allImages.add(element.imagePath!);
                });
                variationColorImg
                    .add(ColorModel(id, colorCode, ProductVarientColorImages));
              }
            });
          });
        }
      });
    }

    print(
        "============================all images colors========================================");
    print("length is ${allImages.length}");
    allImages.forEach((element) {
      print(element);
    });

    print("print color-------------------------------------------------");
    print("variationColorImg ${variationColorImg}");
    variationColorImg.forEach((element) {
      print("new element-------------------------------------------------");
      print("element.colorCode = ${element.colorCode}");
      print("element.colorId = ${element.colorId}");

      print("element.variationImgs = ${element.variationImgs}");
    });
  }

  void initMaterialMethod() async {
    int id = widget.id;
    Details details = await ApiManager.getDetails(id);

    print("material++++++${details.data}");
    if (details.data!.avaiableProperties != null &&
        details.data!.avaiableProperties!.isNotEmpty) {
      details.data!.avaiableProperties!.forEach((element) {
        if (element.property == "Materials") {
          element.values!.forEach((element) {
            int id = element.id!;
            String materialName = element.value!;
            details.data!.variations!.forEach((element) {
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
    print(variationMaterialImg);
    variationMaterialImg.forEach((element) {
      print(element.materialsId);
    });

    print(
        "============================all images material========================================");

    print("length is ${allImages.length}");
    allImages.forEach((element) {
      print(element);
    });

    // variationMaterialImg.forEach((element) {
    //   element.variationImgs.forEach((element) {
    //     allImages.add(element);
    //   });
    // });
  }

  void initSizeMethod() async {
    int id = widget.id;
    Details details = await ApiManager.getDetails(id);

    print("size++++++${details.data}");
    if (details.data!.avaiableProperties != null &&
        details.data!.avaiableProperties!.isNotEmpty) {
      details.data!.avaiableProperties!.forEach((element) {
        if (element.property == "Size") {
          element.values!.forEach((element) {
            int id = element.id!;
            String sizeName = element.value!;
            details.data!.variations!.forEach((element) {
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
    print(variationSizeImg);
    variationSizeImg.forEach((element) {
      print(element.sizeName);
    });

    print(
        "============================all images size========================================");
    print("length is ${allImages.length}");

    allImages.forEach((element) {
      print(element);
    });

    // variationSizeImg.forEach((element) {
    //   element.variationImgs.forEach((element) {
    //     allImages.add(element);
    //   });
    // });
  }

  int currentIndex = 0;

  // List<Widget> images = [
  //   Image.asset("assets/images/test.jpg"),
  //   Image.asset("assets/images/test.jpg"),
  //   Image.asset("assets/images/test.jpg"),
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black12,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("product details",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w400)),
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: Column(
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
                    // Row(
                    //   children: [
                    //     ListView.builder(
                    //       itemBuilder: (context, index) {
                    //         return variationColorImg.isNotEmpty
                    //             ? Text(variationColorImg[index].colorCode)
                    //             : Text("hi");
                    //       },
                    //       itemCount: variationColorImg.length,
                    //     )
                    //   ],
                    // ),

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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Description",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18)),
                            Text(description ?? "",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16)),
                          ]),
                    ),

                    // Row(children: [
                    //   ListView.builder(itemBuilder: (context, index) {
                    //
                    //     return Container(child: Text(),
                    //       height: 50,
                    //       width: 50,);
                    //   },)
                    // ],)
                  ],
                );

                //   ListView.builder(itemBuilder: (context, index) {
                //   return Text(sources[index].name ?? "");
                // }, itemCount: sources.length,);
              },
            )

            // //////////////////////////////////////////////////////////////////
            // variationColorImg.isNotEmpty
            //     ? CachedNetworkImage(
            //         imageUrl: variationColorImg[0].variationImgs[0] ?? "",
            //         imageBuilder: (context, imageProvider) {
            //           return Container(
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(15),
            //                 image: DecorationImage(
            //                     image: imageProvider, fit: BoxFit.cover)),
            //           );
            //         },
            //         placeholder: (context, url) =>
            //             Center(child: CircularProgressIndicator()),
            //         errorWidget: (context, url, error) => Icon(Icons.error),
            //       )
            //     : Text("hello ")

            // Expanded(
            //   child: ListView.builder(
            //     itemBuilder: (context, index) {
            //       return Text((variationColorImg.isNotEmpty)
            //           ? "${variationColorImg[index].variationImgs[0]}++++"
            //           : "empty");
            //     },
            //     itemCount: variationColorImg.length,
            //   ),
            // )

            ///////////////////////////////////////////////////////////

            // Text("hello"),
            // Text("length${allImages.length}"),

            ///////////////////////////////////////////////////////////
            // Expanded(
            //   child: ListView.builder(
            //     itemBuilder: (context, index) {
            //       return Text((allImages.isNotEmpty)
            //           ? "${index} = ${allImages[index]}++++"
            //           : "empty");
            //     },
            //     itemCount: variationColorImg.length,
            //   ),
            // )
          ],

          // ///////model to widget
          // ////0 is index of 1st index in value //63 in color
          //
          // children: (variationColorImg.isNotEmpty)
          //     ? variationColorImg[1]
          //         .variationImgs
          //         .map((e) => Image.network(e))
          //         .toList()
          //     : []
        ));
  }
}
