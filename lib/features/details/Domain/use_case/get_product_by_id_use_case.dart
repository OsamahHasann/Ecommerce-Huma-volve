import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/Failure/Failure.dart';
import 'package:ecommerce_app_huma_volve/features/details/Domain/repository/details_repository.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entities/product_entity.dart';

class GetProductByIdUseCase {
  final DetailsRepository detailsRepository;

  GetProductByIdUseCase(this.detailsRepository);

  Future<Either<Failure, ProductEntity>> execute(int productId) {
    return detailsRepository.getProductById(productId);
  }
}
