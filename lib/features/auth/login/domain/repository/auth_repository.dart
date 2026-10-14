import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/failure/failure.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/domain/entities/login_entity.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/domain/entities/sign_up_req_entity.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/domain/entities/sign_up_respon_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure,LoginEntity>> login(String email, String password);
  Future<Either<Failure,SignUpResponEntity>> signUp(SignUpReqEntity signUpReqModel);
}