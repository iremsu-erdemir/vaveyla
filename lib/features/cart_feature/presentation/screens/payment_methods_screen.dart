import 'package:flutter/material.dart';
import 'package:flutter_sweet_shop_app_ui/core/theme/dimens.dart';
import 'package:flutter_sweet_shop_app_ui/core/theme/theme.dart';
import 'package:flutter_sweet_shop_app_ui/core/utils/check_theme_status.dart';
import 'package:flutter_sweet_shop_app_ui/core/widgets/app_divider.dart';
import 'package:flutter_sweet_shop_app_ui/core/widgets/app_scaffold.dart';
import 'package:flutter_sweet_shop_app_ui/core/widgets/general_app_bar.dart';
import 'package:flutter_sweet_shop_app_ui/features/cart_feature/presentation/widgets/payment_item_widget.dart';

import '../../../../core/gen/assets.gen.dart';
import '../../../../core/widgets/app_button.dart';

class PaymentMethodsScreen extends StatelessWidget {
  const PaymentMethodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appTypography = context.theme.appTypography;
    return AppScaffold(
      appBar: GeneralAppBar(title: 'Ödeme yöntemleri'),
      body: SingleChildScrollView(
        child: Column(
          spacing: Dimens.largePadding,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PaymentItemWidget(
              onTap: () {},
              title: 'Nakit',
              iconPath: Assets.icons.money3,
            ),
            PaymentItemWidget(
              onTap: () {},
              title: 'Cüzdan',
              iconPath: Assets.icons.wallet,
            ),
            SizedBox.shrink(),
            Text('Kredi kartı ekle', style: appTypography.bodyLarge),
            PaymentItemWidget(
              onTap: () {},
              title: 'Kart ekle',
              iconPath: Assets.icons.card,
              showRadio: false,
            ),
            SizedBox.shrink(),
            Text('Diğer ödeme seçenekleri', style: appTypography.bodyLarge),
            Column(
              children: [
                PaymentItemWidget(
                  onTap: () {},
                  title: 'PayPal',
                  logoPath:
                      checkDarkMode(context) ? null : Assets.icons.paypalLogo,
                  showBorder: false,
                ),
                AppDivider(),
                PaymentItemWidget(
                  onTap: () {},
                  title: 'Apple Pay',
                  logoPath:
                      checkDarkMode(context) ? null : Assets.icons.appleLogo,
                  showBorder: false,
                ),
                AppDivider(),
                PaymentItemWidget(
                  onTap: () {},
                  title: 'Google Pay',
                  logoPath:
                      checkDarkMode(context) ? null : Assets.icons.googleLogo,
                  showBorder: false,
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          left: Dimens.largePadding,
          right: Dimens.largePadding,
          bottom: Dimens.padding,
        ),
        child: AppButton(
          onPressed: () {},
          title: 'Ödemeyi onayla',
          textStyle: appTypography.bodyLarge,
          borderRadius: Dimens.corners,
          margin: EdgeInsets.symmetric(vertical: Dimens.largePadding),
        ),
      ),
    );
  }
}
