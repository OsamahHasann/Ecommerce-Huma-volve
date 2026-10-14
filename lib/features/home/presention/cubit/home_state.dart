import 'package:ecommerce_app_huma_volve/features/home/domain/entities/category_entity.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entities/product_entity.dart';

abstract class HomeState {}

class HomeInital extends HomeState {}

class CategorisLoding extends HomeState {}

class CategorisSuccess extends HomeState {
  List<CategoryEntity> categoris;
  CategorisSuccess(this.categoris);
}

class CategorisError extends HomeState {
  String errorMessage;
  CategorisError(this.errorMessage);
}

class ProductsLoding extends HomeState {}

class ProductsSuccess extends HomeState {
  List<ProductEntity> products;
  ProductsSuccess(this.products);
}

class ProductsError extends HomeState {
  String errorMessage;
  ProductsError(this.errorMessage);
}
