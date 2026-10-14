import 'package:ecommerce_app_huma_volve/features/auth/login/domain/entities/login_entity.dart';

class LoginModel extends LoginEntity{

  LoginModel({super.accessToken, super.refreshToken});

  LoginModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
  }

}