import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sweet_shop_app_ui/core/theme/dimens.dart';
import 'package:flutter_sweet_shop_app_ui/core/theme/theme.dart';
import 'package:flutter_sweet_shop_app_ui/core/widgets/app_button.dart';
import 'package:flutter_sweet_shop_app_ui/core/widgets/app_scaffold.dart';
import 'package:flutter_sweet_shop_app_ui/core/widgets/shaded_container.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  late final TapGestureRecognizer _loginTap;

  @override
  void initState() {
    super.initState();
    _loginTap =
        TapGestureRecognizer()
          ..onTap = () {
            Navigator.of(context).maybePop();
          };
  }

  @override
  void dispose() {
    _loginTap.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.appColors;
    return AppScaffold(
      backgroundColor: colors.secondaryShade1,
      padding: EdgeInsets.zero,
      safeAreaTop: false,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final height = constraints.maxHeight;
          final width = constraints.maxWidth;
          final isCompact = width < 360;
          final headerHeight = (height * 0.32).clamp(180.0, 280.0);
          final titleFontSize = (width * 0.085).clamp(26.0, 34.0);
          final inputHeight = isCompact ? 46.0 : 52.0;
          final horizontalPadding =
              width < Dimens.smallDeviceBreakPoint
                  ? Dimens.largePadding
                  : Dimens.extraLargePadding;
          final contentTopPadding = headerHeight * 0.8;
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
                child: SizedBox(
                  height: headerHeight,
                  width: width,
                  child: Image.asset(
                    'assets/images/splash header.png',
                    width: width,
                    fit: BoxFit.fitWidth,
                  ),
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
                            SizedBox(height: sectionSpacing),
                            Text(
                              'HESAP OLUSTUR',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.lobsterTwo(
                                color: colors.primary,
                                fontWeight: FontWeight.w700,
                                fontSize: titleFontSize + 2,
                                letterSpacing: 0.8,
                              ),
                            ),
                            SizedBox(height: sectionSpacing),
                            _RegisterInputField(
                              hintText: 'Ad Soyad',
                              icon: Icons.person,
                              keyboardType: TextInputType.name,
                              height: inputHeight,
                            ),
                            SizedBox(height: fieldSpacing),
                            _RegisterInputField(
                              hintText: 'E-posta',
                              icon: Icons.email,
                              keyboardType: TextInputType.emailAddress,
                              height: inputHeight,
                            ),
                            SizedBox(height: fieldSpacing),
                            _RegisterInputField(
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
                            SizedBox(height: fieldSpacing),
                            _RegisterInputField(
                              hintText: 'Şifre (Tekrar)',
                              icon: Icons.lock,
                              obscureText: _obscureConfirmPassword,
                              height: inputHeight,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _obscureConfirmPassword =
                                        !_obscureConfirmPassword;
                                  });
                                },
                                color: colors.gray4,
                                icon: Icon(
                                  _obscureConfirmPassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: fieldSpacing + Dimens.extraLargePadding,
                            ),
                            AppButton(
                              title: 'Hesap Oluştur',
                              onPressed: () {},
                              margin: EdgeInsets.zero,
                              borderRadius: 28,
                              textStyle: Theme.of(
                                context,
                              ).textTheme.titleMedium?.copyWith(
                                color: colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: Dimens.padding),
                            RichText(
                              text: TextSpan(
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(color: colors.gray4),
                                children: [
                                  const TextSpan(
                                    text: 'Zaten hesabın var mı? ',
                                  ),
                                  TextSpan(
                                    text: 'Giriş Yap',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodySmall?.copyWith(
                                      color: colors.primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    recognizer: _loginTap,
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

class _RegisterInputField extends StatelessWidget {
  const _RegisterInputField({
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
