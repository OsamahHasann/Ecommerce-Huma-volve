import 'package:ecommerce_app_huma_volve/core/constants/api_endpoints.dart';
import 'package:ecommerce_app_huma_volve/core/network/api_claint.dart';
import 'package:ecommerce_app_huma_volve/features/details/Data/data_source/details_remote_data_source.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/models/product_model.dart';

class DetailsRemoteDataSourceIm implements DetailsRemoteDataSource {
  final ApiClient apiClient;

  DetailsRemoteDataSourceIm({required this.apiClient});

  @override
  Future<ProductModel> getProductById(int productId) async {
    final response = await apiClient.dio.get(
      '${ApiEndpoints.products}/$productId',
    );
    final data = response.data as Map<String, dynamic>;
    return ProductModel.fromJson(data);
  }
}
