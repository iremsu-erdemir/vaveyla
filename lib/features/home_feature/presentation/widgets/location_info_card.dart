import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sweet_shop_app_ui/core/theme/dimens.dart';
import 'package:flutter_sweet_shop_app_ui/core/theme/theme.dart';

import '../bloc/location_cubit.dart';

class LocationInfoCard extends StatelessWidget {
  const LocationInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    final appTypography = context.theme.appTypography;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.largePadding),
      child: BlocBuilder<LocationCubit, LocationState>(
        builder: (context, state) {
          String message;
          if (state.status == LocationStatus.loading) {
            message = 'Konum alınıyor...';
          } else if (state.status == LocationStatus.success) {
            final city = (state.city == null || state.city!.isEmpty)
                ? 'Bilinmiyor'
                : state.city!;
            final country = (state.country == null || state.country!.isEmpty)
                ? 'Bilinmiyor'
                : state.country!;
            message = '📍 Bulunduğunuz Konum: $city / $country';
          } else if (state.status == LocationStatus.idle) {
            message = 'Konum bilgisi bekleniyor...';
          } else {
            message = state.message ?? 'Konum alınamadı';
          }

          return Container(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimens.largePadding,
              vertical: Dimens.padding,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(Dimens.corners * 1.4),
              boxShadow: [
                BoxShadow(
                  color: appColors.black.withValues(alpha: 0.12),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: appColors.primary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    Icons.location_on_rounded,
                    color: appColors.primary,
                  ),
                ),
                const SizedBox(width: Dimens.largePadding),
                Expanded(
                  child: Text(
                    message,
                    style: appTypography.bodyLarge.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
