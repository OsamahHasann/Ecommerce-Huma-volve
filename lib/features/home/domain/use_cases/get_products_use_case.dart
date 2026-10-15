// import 'package:dartz/dartz.dart';
// import 'package:ecommerce_app_huma_volve/core/failure/failure.dart';
// import 'package:ecommerce_app_huma_volve/features/home/domain/entities/product_entity.dart';
// import 'package:ecommerce_app_huma_volve/features/home/domain/repository/home_repository.dart';

// class GetProductsUseCase {
//   final HomeRepository homeRepository;

//   GetProductsUseCase(this.homeRepository);

//   static const String _fallbackImage =
//       'https://placehold.co/600x600/png?text=Product';

//   Future<Either<Failure, List<ProductEntity>>> invoke(
//     int cateId, {
//     required int limit,
//     required int offset,
//   }) async {
//     final result = await homeRepository.getProducts(
//       cateId,
//       limit: limit,
//       offset: offset,
//     );

//     return result.fold((failure) => Left(failure), (products) {
//       for (final product in products) {
//         final validImages = _extractValidImageUrls(product.images!);

//         product.images = validImages.isNotEmpty
//             ? validImages
//             : [_fallbackImage];
//       }

//       return Right(products);
//     });
//   }

//   List<String> _extractValidImageUrls(List<String> rawImages) {
//     final List<String> validUrls = [];
//     final urlRegex = RegExp(r'https?://[^\s"\[\]\\]+');

//     for (final raw in rawImages) {
//       final str = raw.trim();
//       if (str.isEmpty) continue;

//       final matches = urlRegex.allMatches(str);

//       for (final match in matches) {
//         String url = match.group(0)!;
//         url = url.replaceAll(RegExp(r'[,.]+$'), '').trim();

//         if (_isValidImageUrl(url)) {
//           validUrls.add(url);
//         }
//       }
//     }

//     return validUrls;
//   }

//   bool _isValidImageUrl(String url) {
//     if (url.isEmpty) return false;

//     final uri = Uri.tryParse(url);

//     if (uri == null) return false;

//     if (!uri.hasScheme || (uri.scheme != 'http' && uri.scheme != 'https')) {
//       return false;
//     }

//     return uri.host.isNotEmpty;
//   }
// }
// // class GetProductsUseCase {

// //   final HomeRepository homeRepository;
// //   GetProductsUseCase(this.homeRepository);

// //     Future<Either<Failure,List<ProductEntity>>> invoke(int cateId,{required int limit, required int offset}) async{
// //       return await homeRepository.getProducts(cateId, limit: limit, offset: offset);
// //     }

// // }

import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/failure/failure.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entities/product_entity.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/repository/home_repository.dart';

class GetProductsUseCase {
  final HomeRepository homeRepository;

  GetProductsUseCase(this.homeRepository);

  static const String _fallbackImage =
      'https://placehold.co/600x600/png?text=Product';

  Future<Either<Failure, List<ProductEntity>>> invoke(
    int cateId, {
    required int limit,
    required int offset,
  }) async {
    final result = await homeRepository.getProducts(
      cateId,
      limit: limit,
      offset: offset,
    );

    return result.fold(
      (failure) => Left(failure),
      (products) {
        for (final product in products) {
          final rawImages = product.images ?? [];
          
          // 1. تنظيف الروابط واستخراج الروابط الحقيقية فقط
          final validImages = _extractValidImageUrls(rawImages);

          // 2. إذا لم يتبقَ أي رابط صالح، نضع صورة افتراضية
          product.images = validImages.isNotEmpty
              ? validImages
              : [_fallbackImage];
        }

        return Right(products);
      },
    );
  }

  //  تطهير وتصفية القائمة قادمة من الـ API
  List<String> _extractValidImageUrls(List<String> rawImages) {
    final List<String> validUrls = [];
    
    // هاس للقبض على روابط http/https فقط واستبعاد أسطر الـ Base64 الطويلة
    final urlRegex = RegExp(r'https?://[^\s"\[\]\\]+');

    for (final raw in rawImages) {
      final str = raw.trim();
      if (str.isEmpty) continue;

      // تجنب نصوص الـ Base64 الطويلة جداً التي تسبب تجميد الواجهة (Lag)
      if (str.length > 500 || str.startsWith('data:image')) continue;

      final matches = urlRegex.allMatches(str);

      for (final match in matches) {
        String url = match.group(0)!;
        
        // تنظيف أي علامات ترقيم متبقية في أواخر الرابط مثل أسطر ، . ] "
        url = url.replaceAll(RegExp(r'[,.\]"\\-]+$'), '').trim();

        if (_isValidImageUrl(url)) {
          validUrls.add(url);
        }
      }
    }

    return validUrls;
  }

  bool _isValidImageUrl(String url) {
    if (url.isEmpty) return false;

    final uri = Uri.tryParse(url);
    if (uri == null) return false;

    // التأكد أنه رابط شبكة حقيقي وليس مسار محلي أو نص مشفر
    if (!uri.hasScheme || (uri.scheme != 'http' && uri.scheme != 'https')) {
      return false;
    }

    return uri.host.isNotEmpty && uri.host.contains('.');
  }
}
