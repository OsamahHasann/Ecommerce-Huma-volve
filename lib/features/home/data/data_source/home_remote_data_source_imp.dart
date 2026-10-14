import 'package:ecommerce_app_huma_volve/core/constants/api_endpoints.dart';
import 'package:ecommerce_app_huma_volve/core/network/api_claint.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/data_source/home_data_source.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/models/category_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/models/product_model.dart';

class HomeRemoteDataSourceImp implements HomeDataSource {
  late final ApiClient apiClient;
  HomeRemoteDataSourceImp(this.apiClient);
  @override
  Future<List<CategoryModel>> getCategories() async {
    final response = await apiClient.dio.get(ApiEndpoints.categories);
    final jsonData = response.data;
    final List<CategoryModel> categories = jsonData
        .map<CategoryModel>(
          (categoryJson) => CategoryModel.fromJson(categoryJson),
        )
        .toList();
    return categories;
  }

  @override
  Future<List<ProductModel>> getProducts(int cateId) async {
    final response = await apiClient.dio.get(
      "${ApiEndpoints.categories}/$cateId/${ApiEndpoints.products}",
    );
    final jsonData = response.data;
    final List<ProductModel> products = jsonData
        .map<ProductModel>((e) => ProductModel.fromJson(e))
        .toList();
    return products;
  }
}
