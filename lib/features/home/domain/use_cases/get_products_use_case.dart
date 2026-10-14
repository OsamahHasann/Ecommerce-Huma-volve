import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/failure/failure.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entities/product_entity.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/repository/home_repository.dart';

class GetProductsUseCase {

  final HomeRepository homeRepository;
  GetProductsUseCase(this.homeRepository);

    Future<Either<Failure,List<ProductEntity>>> invoke(int cateId) async{
      return await homeRepository.getProducts(cateId);
    }
    
}
