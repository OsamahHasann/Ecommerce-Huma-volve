import 'package:ecommerce_app_huma_volve/core/network/api_claint.dart';
import 'package:ecommerce_app_huma_volve/core/storage/storage.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/data/data_source/auth_data_source.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/data/data_source/auth_remote_data_source_imp.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/data/repository_imp/auth_repository_imp.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/domain/repository/auth_repository.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/domain/use_cases/login_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/domain/use_cases/sign_up_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/presention/view_model/auth_cubit.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/data_source/home_data_source.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/data_source/home_remote_data_source_imp.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/repository_imp/home_repository_imp.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/repository/home_repository.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/use_cases/get_categories_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/use_cases/get_products_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/home/presention/cubit/home_cubit.dart';
import 'package:ecommerce_app_huma_volve/features/main_navigation/screens/main_navigation_screen.dart';
import 'package:flutter/material.dart';
import '../../../core/theme.dart';
import '../../auth/login/presention/view/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final ApiClient apiClient;
  late final AuthDataSource authDataSource;
  late final AuthRepository authRepository;
  late final SignUpUseCase signUpUseCase;
  late final LoginUseCase loginUseCase;
  late final AuthCubit authCubit;
  late final HomeDataSource homeDataSource;
  late final HomeRepository homeRepository;
  late final GetCategoriesUseCase getCategoriesUseCase;
  late final GetProductsUseCase getProductsUseCase;
  late final HomeCubit homeCubit;

  @override
  void initState() {
    apiClient = ApiClient();
    authDataSource = AuthRemoteDataSourceImp(apiClient);
    authRepository = AuthRepositoryImp(authDataSource);
    signUpUseCase = SignUpUseCase(authRepository);
    loginUseCase = LoginUseCase(authRepository);
    homeDataSource = HomeRemoteDataSourceImp(apiClient);
    homeRepository = HomeRepositoryImp(homeDataSource);
    getCategoriesUseCase = GetCategoriesUseCase(homeRepository);
    getProductsUseCase = GetProductsUseCase(homeRepository);
    super.initState();
    _navigateToNext();
  }

  Future<void> _navigateToNext() async {
    await Future.delayed(const Duration(seconds: 2));
    final token = await Storage.getAccessToken();
    if (mounted) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
             token != null && token.isNotEmpty ? MainNavigationScreen(): const LoginScreen(),

          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_bag, size: 120, color: AppTheme.primary),
            const SizedBox(height: 24),
            Text(
              'Huma-volve',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontSize: 40,
                color: AppTheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Your Ultimate E-Commerce App',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 48),
            CircularProgressIndicator(color: AppTheme.primary),
          ],
        ),
      ),
    );
  }
}
