import 'package:ecommerce_app_huma_volve/core/constants/api_endpoints.dart';
import 'package:ecommerce_app_huma_volve/core/network/api_claint.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/models/login_model.dart';

class LoginServices {
  ApiClient apiClient;
  LoginServices(this.apiClient);
  Future<LoginModel> login(String email, String password) async {
   
      final response = await apiClient.dio.post(
        ApiEndpoints.login,
        data: {
          'email': email,
          'password': password,
        },
      );
      final jsonData = response.data;
      final LoginModel loginModel = LoginModel.fromJson(jsonData);
      return loginModel;
  
  }
}
