import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/error/error_handling.dart';
import 'package:ecommerce_app_huma_volve/core/failure/failure.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/data_source/home_data_source.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entities/category_entity.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entities/product_entity.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/repository/home_repository.dart';

class HomeRepositoryImp implements HomeRepository {
  final HomeDataSource homeDataSource;
  HomeRepositoryImp(this.homeDataSource);
  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() async {
    try {
      final categoris = await homeDataSource.getCategories();
      return Right(categoris as List<CategoryEntity>);
    } catch (e) {
      return Left(ErrorHandler.handle(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts(int cateId) async {
    try {
      final products = await homeDataSource.getProducts(cateId);
      return Right(products as List<ProductEntity>);
    } catch (e) {
      return Left(ErrorHandler.handle(e.toString()));
    }
  }
}
