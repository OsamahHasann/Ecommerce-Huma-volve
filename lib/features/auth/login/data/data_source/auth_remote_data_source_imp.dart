import 'package:ecommerce_app_huma_volve/core/constants/api_endpoints.dart';
import 'package:ecommerce_app_huma_volve/core/network/api_claint.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/data/data_source/auth_data_source.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/data/models/login_model.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/data/models/sign_up_req_model.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/data/models/sign_up_respon_model.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/domain/entities/sign_up_req_entity.dart';

class AuthRemoteDataSourceImp implements AuthDataSource {
  final ApiClient apiClient;
  AuthRemoteDataSourceImp(this.apiClient);
  @override
  Future<LoginModel> login(String email, String password) async {
    final response = await apiClient.dio.post(
      ApiEndpoints.login,
      data: {'email': email, 'password': password},
    );
    final jsonData = response.data;
    final LoginModel loginModel = LoginModel.fromJson(jsonData);
    return loginModel;
  }

  @override
  Future<SignUpResponModel> signUp(SignUpReqEntity signUpReqModel) async {
    final response = await apiClient.dio.post(
      ApiEndpoints.signUp,
      data: {
        'email': signUpReqModel.email,
        'password': signUpReqModel.password,
        "name": signUpReqModel.name,
        "avatar":
            "https://drive.google.com/file/d/1Ghv56rGabQy_JtHR1RYkZKnzignS4JXe/view?usp=drivesdk",
      },
    );
    final jsonData = response.data;
    final SignUpResponModel signUpResponModel = SignUpResponModel.fromJson(jsonData);
    return signUpResponModel;
  }
}
