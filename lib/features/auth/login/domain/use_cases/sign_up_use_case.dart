import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/failure/failure.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/domain/entities/sign_up_req_entity.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/domain/entities/sign_up_respon_entity.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/domain/repository/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository authRepository;
  SignUpUseCase(this.authRepository);
  Future<Either<Failure,SignUpResponEntity>> invoke(SignUpReqEntity signUpReqEntity) =>
    authRepository.signUp(signUpReqEntity);
}