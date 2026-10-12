import 'package:ecommerce_app_huma_volve/core/dummy_data.dart';
import 'package:flutter/material.dart';

class ProductModel {
  int? id;
  String? title;
  String? slug;
  int? price;
  String? description;
  Category? category;
  List<String>? images;
  String? creationAt;
  String? updatedAt;

  ProductModel(
      {this.id,
      this.title,
      this.slug,
      this.price,
      this.description,
      this.category,
      this.images,
      this.creationAt,
      this.updatedAt});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    price = json['price'];
    description = json['description'];
    category = json['category'] != null
        ? Category.fromJson(json['category'])
        : null;
    images = json['images'].cast<String>();
    creationAt = json['creationAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['slug'] = slug;
    data['price'] = price;
    data['description'] = description;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    data['images'] = images;
    data['creationAt'] =creationAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
   Product toProduct() {
    return Product(
      id: id?.toString() ?? '',
      name: title ?? '',
      description: description ?? '',
      price: (price ?? 0).toDouble(),
      imageUrl: (images != null && images!.isNotEmpty)
          ? images!.first
          : 'https://picsum.photos/300/300',
      colors: [Colors.black, Colors.grey], 
      sizes: ['S', 'M', 'L'],             
    );
  }
}

class Category {
  int? id;
  String? name;
  String? slug;
  String? image;
  String? creationAt;
  String? updatedAt;

  Category(
      {this.id,
      this.name,
      this.slug,
      this.image,
      this.creationAt,
      this.updatedAt});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    image = json['image'];
    creationAt = json['creationAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['image'] = image;
    data['creationAt'] = creationAt;
    data['updatedAt'] = updatedAt;
    return data;
  }

 
}
