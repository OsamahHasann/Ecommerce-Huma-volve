import 'package:ecommerce_app_huma_volve/features/auth/login/domain/entities/sign_up_req_entity.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/domain/use_cases/login_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/domain/use_cases/sign_up_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/presention/view_model/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final SignUpUseCase signUpUseCase;
  AuthCubit({required this.loginUseCase, required this.signUpUseCase}) : super(AuthInital());

  Future<void> login({required String email,required String password}) async {
    emit(LoginLoding());
    final loginRespon = await loginUseCase.invoke(email, password);
    loginRespon.fold(
      (failure) {
        emit(LoginError(failure.failureMessage));
      },
      (loginRespon) {
        emit(LoginSuccess(loginRespon));
      },
    );
  }

  Future<void> signUp(SignUpReqEntity signUpReqEntity) async {
    emit(SignUpLoding());
    final signRespon = await signUpUseCase.invoke(signUpReqEntity);
    signRespon.fold(
      (failure) {
        emit(SignUpError(failure.failureMessage));
      },
      (signRespon) {
        emit(SignUpSuccess(signRespon));
      },
    );
  }
}
