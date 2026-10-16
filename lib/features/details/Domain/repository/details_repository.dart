import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/Failure/Failure.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entities/product_entity.dart';

abstract class DetailsRepository {
  Future<Either<Failure, ProductEntity>> getProductById(int productId);
}
