import 'package:ecommerce_app_huma_volve/features/home/domain/entities/category_entity.dart';

class ProductEntity {
  int? id;
  String? title;
  String? slug;
  int? price;
  String? description;
  CategoryEntity? category;
  List<String>? images;
  String? creationAt;
  String? updatedAt;

  ProductEntity({
    this.id,
    this.title,
    this.slug,
    this.price,
    this.description,
    this.category,
    this.images,
    this.creationAt,
    this.updatedAt,
  });
}
