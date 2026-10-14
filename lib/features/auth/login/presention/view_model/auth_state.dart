import 'package:ecommerce_app_huma_volve/features/auth/login/domain/entities/login_entity.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/domain/entities/sign_up_respon_entity.dart';

abstract class AuthState {}


class AuthInital extends AuthState {}

class LoginLoding extends AuthState {}

class LoginSuccess extends AuthState {
  LoginEntity loginRes;
  LoginSuccess(this.loginRes);
}

class LoginError extends AuthState {
  String errorMessage;
  LoginError(this.errorMessage);
}

class SignUpLoding extends AuthState {}

class SignUpSuccess extends AuthState {
  SignUpResponEntity signUpRespon;
  SignUpSuccess(this.signUpRespon);
}

class SignUpError extends AuthState {
  String errorMessage;
  SignUpError(this.errorMessage);
}
