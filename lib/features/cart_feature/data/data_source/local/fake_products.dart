import 'package:flutter_sweet_shop_app_ui/features/cart_feature/data/models/product_model.dart';

import '../../../../../core/gen/assets.gen.dart';

class FakeProducts {
  static final List<ProductModel> products = [
    ProductModel(
      id: 0,
      name: 'Çikolatalı Pasta',
      price: 99.99,
      imageUrl: Assets.images.birthdayCakeCategory1.path,
      rate: 6.5,
      weight: 1.5,
    ),
    ProductModel(
      id: 1,
      name: 'Çilekli Pasta',
      price: 69.99,
      imageUrl: Assets.images.birthdayCakeCategory2.path,
      rate: 7.5,
      weight: 1.0,
    ),
    ProductModel(
      id: 2,
      name: 'Kirazlı Pasta',
      price: 49.99,
      imageUrl: Assets.images.birthdayCakeCategory3.path,
      rate: 6.5,
      weight: 1.5,
    ),
    ProductModel(
      id: 3,
      name: 'Çilekli kapkek',
      price: 39.99,
      imageUrl: Assets.images.cupcakeCategory1.path,
      rate: 7.5,
      weight: 1.5,
    ),
    ProductModel(
      id: 4,
      name: 'Kapkek',
      price: 40.00,
      imageUrl: Assets.images.cupcakeCategory2.path,
      rate: 9.3,
      weight: 1.5,
    ),
    ProductModel(
      id: 5,
      name: 'Kapkek',
      price: 50.00,
      imageUrl: Assets.images.cupcakeCategory3.path,
      rate: 8.5,
      weight: 0.5,
    ),
    ProductModel(
      id: 6,
      name: 'Sünger donut',
      price: 39.99,
      imageUrl: Assets.images.donutCategory1.path,
      rate: 6.5,
      weight: 1.5,
    ),
    ProductModel(
      id: 7,
      name: 'Çikolatalı donut',
      price: 29.99,
      imageUrl: Assets.images.donutCategory2.path,
      rate: 6.5,
      weight: 1.5,
    ),
    ProductModel(
      id: 7,
      name: 'Karışık donut',
      price: 29.99,
      imageUrl: Assets.images.donutCategory3.path,
      rate: 6.5,
      weight: 1.5,
    ),
  ];
}
