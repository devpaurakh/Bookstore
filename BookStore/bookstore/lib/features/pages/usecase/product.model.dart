// ignore_for_file: unnecessary_new, unnecessary_this, prefer_collection_literals

class ProductModel {
  bool? success;
  String? messsage;
  List<Data>? data;

  ProductModel({this.success, this.messsage, this.data});

  ProductModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    messsage = json['messsage'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }
  

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['messsage'] = this.messsage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? name;
  int? price;
  String? image;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.sId,
      this.name,
      this.price,
      this.image,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Data.fromJson(Map<dynamic, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    price = json['price'];
    image = json['image'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['price'] = this.price;
    data['image'] = this.image;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
