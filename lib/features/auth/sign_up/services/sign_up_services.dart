import 'package:ecommerce_app_huma_volve/core/constants/api_endpoints.dart';
import 'package:ecommerce_app_huma_volve/core/network/api_claint.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/models/SignUpReqModel.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/models/SignUpResponModel.dart';

class SignUpServices {
  ApiClient apiClient;
  SignUpServices(this.apiClient);
  Future<SignUpResponModel> signUp(SignUpReqModel signUpReqModel) async {
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
