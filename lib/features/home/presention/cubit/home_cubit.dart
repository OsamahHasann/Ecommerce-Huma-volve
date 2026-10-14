import 'package:ecommerce_app_huma_volve/features/home/domain/use_cases/get_categories_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/use_cases/get_products_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/home/presention/cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetProductsUseCase getProductsUseCase;
  HomeCubit({required this.getCategoriesUseCase,required this.getProductsUseCase})
    : super(HomeInital());

  Future<void> getCategories() async {
    emit(CategorisLoding());
    emit(ProductsLoding());
    int categoriesID = 0;
    final categories = await getCategoriesUseCase.invoke();
    categories.fold(
      (failure) {
        emit(CategorisError(failure.failureMessage));
      },
      (categories) {
        categoriesID = categories[0].id!;
        emit(CategorisSuccess(categories));
      },
    );

    getProducts(categoriesID);
    
  }

  Future<void> getProducts(int cateId) async {
    final products = await getProductsUseCase.invoke(cateId);
    products.fold((failure){
      emit(ProductsError(failure.failureMessage));
    },(products){
      emit(ProductsSuccess(products));
    });
  }
}
