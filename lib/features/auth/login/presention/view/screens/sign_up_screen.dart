import 'package:ecommerce_app_huma_volve/core/network/api_claint.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/data/data_source/auth_data_source.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/data/data_source/auth_remote_data_source_imp.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/data/repository_imp/auth_repository_imp.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/domain/entities/sign_up_req_entity.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/domain/repository/auth_repository.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/domain/use_cases/login_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/domain/use_cases/sign_up_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/presention/view_model/auth_cubit.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/presention/view_model/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/widgets/custom_text_field.dart';
import '../../../../../../core/widgets/primary_button.dart';
import '../../../../../../core/theme.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final ApiClient apiClient;
  late final AuthDataSource authDataSource;
  late final AuthRepository authRepository;
  late final SignUpUseCase signUpUseCase;
  late final LoginUseCase loginUseCase;
  late final AuthCubit authCubit;

  @override
  void initState() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    apiClient = ApiClient();
    authDataSource = AuthRemoteDataSourceImp(apiClient);
    authRepository = AuthRepositoryImp(authDataSource);
    signUpUseCase = SignUpUseCase(authRepository);
    loginUseCase = LoginUseCase(authRepository);
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AuthCubit(loginUseCase: loginUseCase, signUpUseCase: signUpUseCase),
      child: Scaffold(
        backgroundColor: AppTheme.background,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 40),
                  Icon(Icons.person_add, size: 80, color: AppTheme.primary),
                  const SizedBox(height: 32),
                  Text(
                    'Create Account',
                    style: Theme.of(
                      context,
                    ).textTheme.displayLarge?.copyWith(fontSize: 32),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Sign up to get started',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 48),
                  CustomTextField(
                    controller: nameController,
                    hintText: 'Full Name',
                    prefixIcon: Icons.person_outline,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: emailController,
                    hintText: 'Email Address',
                    prefixIcon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!value.contains('@')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    prefixIcon: Icons.lock_outline,
                    isPassword: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 40),
                  BlocConsumer<AuthCubit, AuthState>(
                    listenWhen: (previous, current) =>
                        current is SignUpSuccess || current is SignUpError,
                    listener: (context, state) {
                      if (state is SignUpSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "SignUp is successfuly",
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.black,
                          ),
                        );

                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      } else if (state is SignUpError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.errorMessage),
                            backgroundColor: Colors.red[300],
                          ),
                        );
                      }
                    },
                    buildWhen: (previous, current) =>
                        current is SignUpLoding ||
                        current is SignUpSuccess ||
                        current is SignUpError,
                    builder: (context, state) {
                      final isLoading = state is SignUpLoding;

                      return PrimaryButton(
                        text: 'SignUp',
                        onPressed: isLoading
                            ? null
                            : () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  context.read<AuthCubit>().signUp(
                                    
                                    SignUpReqEntity(
                                      email: emailController.text,
                                      name: nameController.text,
                                      password: passwordController.text,
                                      avatar: "https://i.imgur.com/LDOO2Qs.jpg"  ),
                                  );
                                }
                              },
                        widget: isLoading
                            ? const SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.5,
                                ),
                              )
                            : const Text(
                                "SignUp",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account? '),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      const LoginScreen(),
                              transitionsBuilder:
                                  (
                                    context,
                                    animation,
                                    secondaryAnimation,
                                    child,
                                  ) {
                                    return FadeTransition(
                                      opacity: animation,
                                      child: child,
                                    );
                                  },
                            ),
                          );
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: AppTheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
