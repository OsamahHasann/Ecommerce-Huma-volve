import 'package:ecommerce_app_huma_volve/core/dummy_data.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/models/category_model.dart';

abstract class HomeState {}

class HomeInital extends HomeState {}

class CategorisLoding extends HomeState {}

class CategorisSuccess extends HomeState {
  List<CategoryModel> categoris;
  CategorisSuccess(this.categoris);
}

class CategorisError extends HomeState {
  String errorMessage;
  CategorisError(this.errorMessage);
}

class ProductsLoding extends HomeState {}

class ProductsSuccess extends HomeState {
  List<Product> products;
  ProductsSuccess(this.products);
}

class ProductsError extends HomeState {
  String errorMessage;
  ProductsError(this.errorMessage);
}
