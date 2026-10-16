import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/Failure/Failure.dart';
import 'package:ecommerce_app_huma_volve/core/error/error_handling.dart';
import 'package:ecommerce_app_huma_volve/features/details/Data/data_source/details_remote_data_source.dart';
import 'package:ecommerce_app_huma_volve/features/details/Domain/repository/details_repository.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/models/product_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entities/category_entity.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entities/product_entity.dart';
class DetailsRepositoryIm implements DetailsRepository {
  final DetailsRemoteDataSource detailsRemoteDataSource;

  DetailsRepositoryIm(this.detailsRemoteDataSource);

  @override
  Future<Either<Failure, ProductEntity>> getProductById(
    int productId,
  ) async {
    try {
      final product = await detailsRemoteDataSource.getProductById(productId);
      return Right(_mapToEntity(product));
    } catch (e) {
      return Left(ErrorHandler.handle(e) as Failure );
    }
  }

  ProductEntity _mapToEntity(ProductModel model) {
    return ProductEntity(
      id: model.id,
      title: model.title,
      slug: model.slug,
      price: model.price,
      description: model.description,
      category: model.category == null
          ? null
          : CategoryEntity(
              id: model.category!.id,
              name: model.category!.name,
            ),
      images: model.images,
    );
  }
}
