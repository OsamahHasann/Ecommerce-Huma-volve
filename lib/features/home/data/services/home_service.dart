import 'package:ecommerce_app_huma_volve/core/constants/api_endpoints.dart';
import 'package:ecommerce_app_huma_volve/core/dummy_data.dart';
import 'package:ecommerce_app_huma_volve/core/network/api_claint.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/models/category_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/models/product_model.dart';

class HomeService {
  late final ApiClient apiClient;
  HomeService(this.apiClient);

  Future<List<CategoryModel>> getCategories() async {
    final response = await apiClient.dio.get(ApiEndpoints.categories);
    final jsonData = response.data;
    final List<CategoryModel> categories = jsonData
        .map<CategoryModel>((categoryJson) => CategoryModel.fromJson(categoryJson))
        .toList();
    return categories;
  }
  
  Future<List<Product>> getProducts(int cateId) async {
    final response = await apiClient.dio.get("${ApiEndpoints.categories}/$cateId/${ApiEndpoints.products}");
    final jsonData = response.data;
    final List<Product> products = jsonData
      .map<Product>((e) => ProductModel.fromJson(e).toProduct())
      .toList();
    return products;
  }

}