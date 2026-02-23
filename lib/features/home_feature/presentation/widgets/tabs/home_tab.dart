import 'package:flutter/material.dart';
import 'package:flutter_sweet_shop_app_ui/core/theme/dimens.dart';
import 'package:flutter_sweet_shop_app_ui/core/utils/app_navigator.dart';
import 'package:flutter_sweet_shop_app_ui/features/home_feature/presentation/screens/categories_screen.dart';
import 'package:flutter_sweet_shop_app_ui/features/home_feature/presentation/screens/special_offers.dart';
import 'package:flutter_sweet_shop_app_ui/features/home_feature/presentation/widgets/banner_slider_widget.dart';
import 'package:flutter_sweet_shop_app_ui/features/home_feature/presentation/widgets/products_list.dart';

import '../../../../../core/widgets/app_title_widget.dart';
import '../categories_list.dart';
import '../location_info_card.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: Dimens.largePadding),
          const LocationInfoCard(),
          const SizedBox(height: Dimens.largePadding),
          AppTitleWidget(
            onPressed: () {
              appPush(context, SpecialOffers());
            },
            title: 'Özel Teklifler',
          ),
          BannerSliderWidget(),
          AppTitleWidget(
            onPressed: () {
              appPush(context, CategoriesScreen());
            },
            title: 'Kategoriler',
          ),
          CategoriesList(),
          ProductsList(),
          SizedBox(height: Dimens.largePadding),
        ],
      ),
    );
  }
}
