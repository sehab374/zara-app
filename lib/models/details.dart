class Details {
  Data? data;
  String? message;
  int? statusCode;

  Details({this.data, this.message, this.statusCode});

  Details.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    data['statusCode'] = this.statusCode;
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? description;
  int? brandId;
  int? bostaSizeId;
  int? productRating;
  int? estimatedDaysPreparing;
  Null? sizeChart;
  SubCategory? subCategory;
  List<Variations>? variations;
  List<AvaiableProperties>? avaiableProperties;
  String? brandName;
  String? brandImage;

  Data(
      {this.id,
        this.name,
        this.description,
        this.brandId,
        this.bostaSizeId,
        this.productRating,
        this.estimatedDaysPreparing,
        this.sizeChart,
        this.subCategory,
        this.variations,
        this.avaiableProperties,
        this.brandName,
        this.brandImage});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    brandId = json['brand_id'];
    bostaSizeId = json['bosta_size_id'];
    productRating = json['product_rating'];
    estimatedDaysPreparing = json['estimated_days_preparing'];
    sizeChart = json['SizeChart'];
    subCategory = json['subCategory'] != null
        ? new SubCategory.fromJson(json['subCategory'])
        : null;
    if (json['variations'] != null) {
      variations = <Variations>[];
      json['variations'].forEach((v) {
        variations!.add(new Variations.fromJson(v));
      });
    }
    if (json['avaiableProperties'] != null) {
      avaiableProperties = <AvaiableProperties>[];
      json['avaiableProperties'].forEach((v) {
        avaiableProperties!.add(new AvaiableProperties.fromJson(v));
      });
    }
    brandName = json['brandName'];
    brandImage = json['brandImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['brand_id'] = this.brandId;
    data['bosta_size_id'] = this.bostaSizeId;
    data['product_rating'] = this.productRating;
    data['estimated_days_preparing'] = this.estimatedDaysPreparing;
    data['SizeChart'] = this.sizeChart;
    if (this.subCategory != null) {
      data['subCategory'] = this.subCategory!.toJson();
    }
    if (this.variations != null) {
      data['variations'] = this.variations!.map((v) => v.toJson()).toList();
    }
    if (this.avaiableProperties != null) {
      data['avaiableProperties'] =
          this.avaiableProperties!.map((v) => v.toJson()).toList();
    }
    data['brandName'] = this.brandName;
    data['brandImage'] = this.brandImage;
    return data;
  }
}

class SubCategory {
  int? id;
  String? name;

  SubCategory({this.id, this.name});

  SubCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Variations {
  int? id;
  int? price;
  int? quantity;
  bool? inStock;
  List<ProductVarientImages>? productVarientImages;
  List<ProductPropertiesValues>? productPropertiesValues;
  String? productStatus;
  bool? isDefault;
  int? productVariationStatusId;

  Variations(
      {this.id,
        this.price,
        this.quantity,
        this.inStock,
        this.productVarientImages,
        this.productPropertiesValues,
        this.productStatus,
        this.isDefault,
        this.productVariationStatusId});

  Variations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    quantity = json['quantity'];
    inStock = json['inStock'];
    if (json['ProductVarientImages'] != null) {
      productVarientImages = <ProductVarientImages>[];
      json['ProductVarientImages'].forEach((v) {
        productVarientImages!.add(new ProductVarientImages.fromJson(v));
      });
    }
    if (json['productPropertiesValues'] != null) {
      productPropertiesValues = <ProductPropertiesValues>[];
      json['productPropertiesValues'].forEach((v) {
        productPropertiesValues!.add(new ProductPropertiesValues.fromJson(v));
      });
    }
    productStatus = json['productStatus'];
    isDefault = json['isDefault'];
    productVariationStatusId = json['product_variation_status_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['inStock'] = this.inStock;
    if (this.productVarientImages != null) {
      data['ProductVarientImages'] =
          this.productVarientImages!.map((v) => v.toJson()).toList();
    }
    if (this.productPropertiesValues != null) {
      data['productPropertiesValues'] =
          this.productPropertiesValues!.map((v) => v.toJson()).toList();
    }
    data['productStatus'] = this.productStatus;
    data['isDefault'] = this.isDefault;
    data['product_variation_status_id'] = this.productVariationStatusId;
    return data;
  }
}

class ProductVarientImages {
  int? id;
  String? imagePath;
  Null? productVarientId;
  String? createdAt;
  String? updatedAt;

  ProductVarientImages(
      {this.id,
        this.imagePath,
        this.productVarientId,
        this.createdAt,
        this.updatedAt});

  ProductVarientImages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imagePath = json['image_path'];
    productVarientId = json['product_varient_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image_path'] = this.imagePath;
    data['product_varient_id'] = this.productVarientId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class ProductPropertiesValues {
  String? value;
  String? property;

  ProductPropertiesValues({this.value, this.property});

  ProductPropertiesValues.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    property = json['property'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['property'] = this.property;
    return data;
  }
}

class AvaiableProperties {
  String? property;
  List<Values>? values;

  AvaiableProperties({this.property, this.values});

  AvaiableProperties.fromJson(Map<String, dynamic> json) {
    property = json['property'];
    if (json['values'] != null) {
      values = <Values>[];
      json['values'].forEach((v) {
        values!.add(new Values.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['property'] = this.property;
    if (this.values != null) {
      data['values'] = this.values!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Values {
  String? value;
  int? id;

  Values({this.value, this.id});

  Values.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['id'] = this.id;
    return data;
  }
}