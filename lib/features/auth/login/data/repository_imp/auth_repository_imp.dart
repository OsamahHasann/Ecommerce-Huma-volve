import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/error/error_handling.dart';
import 'package:ecommerce_app_huma_volve/core/failure/failure.dart';
import 'package:ecommerce_app_huma_volve/core/storage/storage.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/data/data_source/auth_data_source.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/domain/entities/login_entity.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/domain/entities/sign_up_respon_entity.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/domain/repository/auth_repository.dart';

class AuthRepositoryImp extends AuthRepository {
  final AuthDataSource authDataSource;
  AuthRepositoryImp(this.authDataSource);
  @override
  Future<Either<Failure, LoginEntity>> login(
    String email,
    String password,
  ) async {
    try {
      final loginRespon = await authDataSource.login(email, password);
      Storage.saveRefreshToken(loginRespon.refreshToken!);
      Storage.saveAccessToken(loginRespon.accessToken!);
      return Right(loginRespon as LoginEntity);
    } catch (e) {
      return Left(ErrorHandler.handle(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SignUpResponEntity>> signUp(
    dynamic signUpReqModel,
  ) async {
    try {
      final signUpRespon = await authDataSource.signUp(signUpReqModel);
      return Right(signUpRespon as SignUpResponEntity);
    } catch (e) {
      return Left(ErrorHandler.handle(e.toString()));
    }
  }
}
