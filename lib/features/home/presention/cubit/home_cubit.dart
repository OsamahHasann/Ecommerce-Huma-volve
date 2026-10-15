import 'package:ecommerce_app_huma_volve/features/home/domain/entities/product_entity.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/use_cases/get_categories_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/use_cases/get_products_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/home/presention/cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetProductsUseCase getProductsUseCase;
  HomeCubit({
    required this.getCategoriesUseCase,
    required this.getProductsUseCase,
  }) : super(HomeInital());

  final List<ProductEntity> _products = [];

  int limit = 10;
  int offset = 0;
  int selectedCategoriesID = 0;
  bool isLoadingMore = false;
  bool hasMore = true;

  Future<void> getCategories() async {
    emit(CategorisLoding());
    emit(ProductsLoading());
    final categories = await getCategoriesUseCase.invoke();
    categories.fold(
      (failure) {
        emit(CategorisError(failure.failureMessage));
      },
      (categories) {
        selectedCategoriesID = categories.first.id!;
        emit(CategorisSuccess(categories));
      },
    );

    getProducts(selectedCategoriesID);
  }

  Future<void> getProducts(int cateId) async {
    selectedCategoriesID = cateId;
    offset = 0;
    hasMore = true;
    isLoadingMore = false;
    emit(ProductsLoading());
    final products = await getProductsUseCase.invoke(
      cateId,
      limit: limit,
      offset: offset,
    );
    products.fold(
      (failure) {
        emit(ProductsMoreError(failure.failureMessage));
      },
      (products) {
        _products.clear();
        selectedCategoriesID = cateId;
        _products.addAll(products);
        print("the categories is ");
        offset = _products.length;
        print("products $_products");
        print("offset $offset");
        if (products.length < limit) {
          hasMore = false;
        }
        emit(ProductsSuccess(List.from(_products)));
      },
    );
  }

  void loadingMoreProducts() async {
    if (!hasMore || isLoadingMore) return;
    isLoadingMore = true;
    emit(ProductsMoreLoading());
    final products = await getProductsUseCase.invoke(
      selectedCategoriesID,
      limit: limit,
      offset: offset,
    );
    products.fold(
      (failure) {
        isLoadingMore = false;
        emit(ProductsError(failure.failureMessage));
      },
      (newProducts) {
        _products.addAll(newProducts);
        offset = _products.length;
        if (newProducts.length < limit) {
          hasMore = false;
        }
        emit(ProductsSuccess(List.from(_products)));
      },
    );
  }
}
