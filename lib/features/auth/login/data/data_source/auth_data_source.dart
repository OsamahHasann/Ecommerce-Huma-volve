import 'package:ecommerce_app_huma_volve/features/auth/login/data/models/login_model.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/data/models/sign_up_req_model.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/data/models/sign_up_respon_model.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/domain/entities/sign_up_req_entity.dart';

abstract class AuthDataSource {
  Future<LoginModel> login(String email, String password);
  Future<SignUpResponModel> signUp(SignUpReqEntity signUpReqModel);
}
