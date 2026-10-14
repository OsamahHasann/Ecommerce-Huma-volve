import 'package:ecommerce_app_huma_volve/features/auth/login/domain/entities/sign_up_req_entity.dart';

class SignUpReqModel extends SignUpReqEntity{

  SignUpReqModel({ super.email,  super.name,  super.password,  super.avatar});

  SignUpReqModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    password = json['password'];
    avatar = json['avatar'];
  }
}