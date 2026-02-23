import 'package:flutter/material.dart';
import 'package:flutter_sweet_shop_app_ui/core/theme/dimens.dart';
import 'package:flutter_sweet_shop_app_ui/core/theme/theme.dart';
import 'package:flutter_sweet_shop_app_ui/core/widgets/app_button.dart';
import 'package:flutter_sweet_shop_app_ui/core/widgets/app_scaffold.dart';
import 'package:flutter_sweet_shop_app_ui/core/widgets/shaded_container.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.appColors;
    final typography = context.theme.appTypography;
    return AppScaffold(
      backgroundColor: colors.secondaryShade1,
      padding: EdgeInsets.zero,
      safeAreaTop: false,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final height = constraints.maxHeight;
          final width = constraints.maxWidth;
          final isCompact = width < 360;
          final headerHeight = (height * 0.22).clamp(150.0, 220.0);
          final titleFontSize = (width * 0.085).clamp(26.0, 34.0);
          final inputHeight = isCompact ? 46.0 : 52.0;
          final horizontalPadding =
              width < Dimens.smallDeviceBreakPoint
                  ? Dimens.largePadding
                  : Dimens.extraLargePadding;
          final contentTopPadding = headerHeight * 0.95;
          final contentBottomPadding = Dimens.extraLargePadding;
          final contentMaxWidth = width > 520 ? 420.0 : width;
          final fieldSpacing = isCompact ? Dimens.padding : Dimens.largePadding;
          final sectionSpacing =
              isCompact ? Dimens.largePadding : Dimens.extraLargePadding;

          return Stack(
            children: [
              /// Arka Plan
              Positioned.fill(child: Container(color: colors.secondaryShade1)),

              /// ÜST HEADER
              Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  'assets/images/splash header.png',
                  width: width,
                  fit: BoxFit.fitWidth,
                ),
              ),

              /// FORM ALANI
              SafeArea(
                top: false,
                child: Center(
                  child: Scrollbar(
                    thumbVisibility: true,
                    child: SingleChildScrollView(
                      padding: EdgeInsets.fromLTRB(
                        horizontalPadding,
                        contentTopPadding,
                        horizontalPadding,
                        contentBottomPadding,
                      ),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: contentMaxWidth),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                          Text(
                            'VAVEYLA',
                            style: GoogleFonts.lobsterTwo(
                              color: const Color(0xFFF9DFDF),
                              fontWeight: FontWeight.w700,
                              fontSize: titleFontSize + 4,
                              letterSpacing: 1.0,
                            ),
                          ),
                            SizedBox(
                              height: sectionSpacing + Dimens.largePadding,
                            ),
                            _LoginInputField(
                              hintText: 'E-posta',
                              icon: Icons.person,
                              keyboardType: TextInputType.emailAddress,
                              height: inputHeight,
                            ),
                            SizedBox(height: fieldSpacing),
                            _LoginInputField(
                              hintText: 'Şifre',
                              icon: Icons.lock,
                              obscureText: _obscurePassword,
                              height: inputHeight,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                                color: colors.gray4,
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                              ),
                            ),
                          SizedBox(
                            height: fieldSpacing + Dimens.extraLargePadding,
                          ),
                          AppButton(
                              title: 'Giriş Yap',
                              onPressed: () {},
                              margin: EdgeInsets.zero,
                              borderRadius: 28,
                              textStyle: typography.titleMedium.copyWith(
                                color: colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: Dimens.padding),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'Şifrenizi mi unuttunuz?',
                                style: typography.bodySmall.copyWith(
                                  color: colors.gray4,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            SizedBox(height: Dimens.smallPadding),
                            RichText(
                              text: TextSpan(
                                style: typography.bodySmall.copyWith(
                                  color: colors.gray4,
                                ),
                                children: [
                                  const TextSpan(text: 'Hesabınız yok mu? '),
                                  TextSpan(
                                    text: 'Kayıt ol',
                                    style: typography.bodySmall.copyWith(
                                      color: colors.primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _LoginInputField extends StatelessWidget {
  const _LoginInputField({
    required this.hintText,
    required this.icon,
    this.obscureText = false,
    this.keyboardType,
    this.suffixIcon,
    this.height = 50,
  });

  final String hintText;
  final IconData icon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final double height;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.appColors;
    final typography = context.theme.appTypography;
    return ShadedContainer(
      height: height,
      borderRadius: 26,
      child: TextField(
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: typography.bodySmall.copyWith(color: colors.gray4),
          prefixIcon: Icon(icon, color: colors.primary),
          suffixIcon: suffixIcon,
          contentPadding: const EdgeInsets.symmetric(
            vertical: Dimens.mediumPadding,
          ),
        ),
        style: typography.bodySmall.copyWith(
          color: colors.primaryTint2,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
