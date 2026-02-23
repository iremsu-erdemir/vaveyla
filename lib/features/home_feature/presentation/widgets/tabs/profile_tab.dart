import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sweet_shop_app_ui/core/theme/theme.dart';
import 'package:flutter_sweet_shop_app_ui/core/utils/check_theme_status.dart';
import 'package:flutter_sweet_shop_app_ui/core/widgets/app_scaffold.dart';
import 'package:flutter_sweet_shop_app_ui/core/widgets/bordered_container.dart';
import 'package:flutter_sweet_shop_app_ui/core/widgets/general_app_bar.dart';

import '../../../../../core/gen/assets.gen.dart';
import '../../../../../core/theme/dimens.dart';
import '../../../../../core/widgets/app_list_tile.dart';
import '../../../../../core/widgets/app_svg_viewer.dart';
import '../../../../../core/widgets/user_profile_image_widget.dart';
import '../../bloc/theme_cubit.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    final appTypography = context.theme.appTypography;
    return AppScaffold(
      appBar: GeneralAppBar(title: 'Profil', showBackIcon: false),
      body: SingleChildScrollView(
        child: Column(
          spacing: Dimens.largePadding,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BorderedContainer(
              child: ListTile(
                leading: UserProfileImageWidget(width: 56, height: 56),
                title: Text('Vanessa Lennox', style: appTypography.bodyLarge),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: Dimens.padding),
                  child: Text(
                    'VanessaLennox@gmail.com',
                    style: appTypography.bodySmall.copyWith(
                      color:
                          checkDarkMode(context)
                              ? appColors.white
                              : appColors.gray4,
                    ),
                  ),
                ),
                trailing: AppSvgViewer(
                  Assets.icons.edit,
                  width: 19,
                  color:
                      checkDarkMode(context)
                          ? appColors.white
                          : appColors.gray4,
                ),
              ),
            ),
            Text(
              'Genel',
              style: appTypography.bodyLarge.copyWith(fontSize: 20),
            ),
            BorderedContainer(
              child: Column(
                spacing: Dimens.largePadding,
                children: [
                  AppListTile(
                    onTap: () {},
                    title: 'Ödeme yöntemi',
                    leadingIconPath: Assets.icons.cardPos,
                    padding: EdgeInsets.zero,
                  ),
                  AppListTile(
                    onTap: () {},
                    title: 'Adresler',
                    leadingIconPath: Assets.icons.location,
                    padding: EdgeInsets.zero,
                  ),
                  AppListTile(
                    onTap: () {},
                    title: 'Dil',
                    leadingIconPath: Assets.icons.languageSquare,
                    padding: EdgeInsets.zero,
                  ),
                  AppListTile(
                    onTap: () {},
                    title: 'Bildirimler',
                    leadingIconPath: Assets.icons.notification,
                    trailing: Transform.scale(
                      scale: 0.7,
                      child: CupertinoSwitch(
                        value: true,
                        onChanged: (final value) {},
                        activeTrackColor: appColors.primary,
                      ),
                    ),
                    padding: EdgeInsets.zero,
                  ),
                  AppListTile(
                    onTap: () {
                      context.read<ThemeCubit>().toggleTheme();
                    },
                    title: 'Koyu tema',
                    leadingIconPath: Assets.icons.moon,
                    trailing: Transform.scale(
                      scale: 0.7,
                      child: CupertinoSwitch(
                        value: checkDarkMode(context),
                        onChanged: (final value) {
                          context.read<ThemeCubit>().toggleTheme();
                        },
                        activeTrackColor: appColors.primary,
                      ),
                    ),
                    padding: EdgeInsets.zero,
                  ),
                  SizedBox.shrink(),
                ],
              ),
            ),
            Text(
              'Destek',
              style: appTypography.bodyLarge.copyWith(fontSize: 20),
            ),
            BorderedContainer(
              child: Column(
                spacing: Dimens.largePadding,
                children: [
                  AppListTile(
                    onTap: () {},
                    title: 'Geri bildirim',
                    leadingIconPath: Assets.icons.noteText,
                    padding: EdgeInsets.zero,
                  ),
                  AppListTile(
                    onTap: () {},
                    title: 'Yardım ve Destek',
                    leadingIconPath: Assets.icons.infoCircle,
                    padding: EdgeInsets.zero,
                  ),
                  SizedBox.shrink(),
                ],
              ),
            ),
            BorderedContainer(
              child: AppListTile(
                onTap: () {},
                title: 'Çıkış yap',
                leadingIconPath: Assets.icons.logout,
                padding: EdgeInsets.zero,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
