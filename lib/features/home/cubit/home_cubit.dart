import 'package:ecommerce_app_huma_volve/core/dummy_data.dart';
import 'package:ecommerce_app_huma_volve/features/home/cubit/home_state.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/models/category_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/models/product_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/services/home_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeService homeService;
  HomeCubit(this.homeService) : super(HomeInital());

  Future<void> getCategories() async {
    emit(CategorisLoding());
    emit(ProductsLoding());
    try {
      final List<CategoryModel> categories = await homeService.getCategories();
      emit(CategorisSuccess(categories));
      
      final List<Product> products = await homeService.getProducts(categories[0].id!);
      emit(ProductsSuccess(products));
    } catch (e) {
      emit(CategorisError(e.toString()));
    }
  }

  Future<void> getProducts(int cateId) async {
    emit(ProductsLoding());
    try {
      final List<Product> products = await homeService.getProducts(cateId);
      emit(ProductsSuccess(products));
    } catch (e) {
      emit(ProductsError(e.toString()));
    }
  }

}
