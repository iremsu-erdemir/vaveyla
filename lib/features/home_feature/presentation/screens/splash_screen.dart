import 'package:flutter/material.dart';
import 'package:flutter_sweet_shop_app_ui/core/theme/dimens.dart';
import 'package:flutter_sweet_shop_app_ui/core/theme/theme.dart';
import 'package:flutter_sweet_shop_app_ui/core/widgets/app_button.dart';
import 'package:flutter_sweet_shop_app_ui/core/widgets/app_scaffold.dart';
import 'package:flutter_sweet_shop_app_ui/core/widgets/shaded_container.dart';
import 'package:flutter_sweet_shop_app_ui/core/services/auth_service.dart';
import 'package:flutter_sweet_shop_app_ui/core/utils/app_navigator.dart';
import 'package:flutter_sweet_shop_app_ui/features/home_feature/presentation/screens/home_screen.dart';
import 'package:flutter_sweet_shop_app_ui/features/home_feature/presentation/screens/register_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _obscurePassword = true;
  bool _isSubmitting = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  final RegExp _hasUpperCase = RegExp(r'[A-Z]');
  final RegExp _hasLowerCase = RegExp(r'[a-z]');
  final RegExp _hasDigit = RegExp(r'[0-9]');
  final RegExp _hasSpecial = RegExp(r"[!@#$%^&*(),.?{}|<>_\-+=;'\[\]\\\/`~]");

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _showMessage({required String message, required Color backgroundColor}) {
    final colors = context.theme.appColors;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: colors.white, fontWeight: FontWeight.w600),
        ),
        backgroundColor: backgroundColor,
      ),
    );
  }

  String? _validatePassword(String password) {
    if (password.length < 6) {
      return 'Şifre en az 6 karakter olmalıdır.';
    }
    if (!_hasUpperCase.hasMatch(password)) {
      return 'Şifre en az bir büyük harf içermelidir.';
    }
    if (!_hasLowerCase.hasMatch(password)) {
      return 'Şifre en az bir küçük harf içermelidir.';
    }
    if (!_hasDigit.hasMatch(password)) {
      return 'Şifre en az bir rakam içermelidir.';
    }
    if (!_hasSpecial.hasMatch(password)) {
      return 'Şifre en az bir özel karakter içermelidir.';
    }
    return null;
  }

  Future<void> _handleLogin() async {
    if (_isSubmitting) {
      return;
    }
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final colors = context.theme.appColors;
    if (email.isEmpty || password.isEmpty) {
      _showMessage(
        message: 'Lütfen e-posta ve şifre alanlarını doldurun.',
        backgroundColor: colors.error,
      );
      return;
    }
    final passwordError = _validatePassword(password);
    if (passwordError != null) {
      _showMessage(message: passwordError, backgroundColor: colors.error);
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      final result = await _authService.login(email: email, password: password);
      if (!mounted) {
        return;
      }
      _showMessage(
        message: 'Giriş başarılı, yönlendiriliyorsunuz ${result.fullName}.',
        backgroundColor: colors.success,
      );
      await Future.delayed(const Duration(seconds: 2));
      if (!mounted) {
        return;
      }
      await appPushReplacement(context, const HomeScreen());
    } catch (error) {
      if (!mounted) {
        return;
      }
      final message =
          error is AuthException
              ? error.message
              : 'Giriş başarısız. Lütfen tekrar deneyin.';
      _showMessage(message: message, backgroundColor: colors.error);
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

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
          final headerHeight = (height * 0.32).clamp(180.0, 280.0);
          final titleFontSize = (width * 0.085).clamp(26.0, 34.0);
          final headerTopOffset = (height * 0.03).clamp(8.0, 24.0);
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
              Positioned(
                top: headerTopOffset,
                left: 0,
                right: 0,
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
                              'VAVEYLA',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.lobsterTwo(
                                color: colors.primary,
                                fontWeight: FontWeight.w700,
                                fontSize: titleFontSize + 4,
                                letterSpacing: 1.0,
                              ),
                            ),
                            SizedBox(height: sectionSpacing),
                            _LoginInputField(
                              hintText: 'E-posta',
                              icon: Icons.person,
                              keyboardType: TextInputType.emailAddress,
                              height: inputHeight,
                              controller: _emailController,
                            ),
                            SizedBox(height: fieldSpacing),
                            _LoginInputField(
                              hintText: 'Şifre',
                              icon: Icons.lock,
                              obscureText: _obscurePassword,
                              height: inputHeight,
                              controller: _passwordController,
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
                              onPressed: _handleLogin,
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
                            Wrap(
                              alignment: WrapAlignment.center,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Text(
                                  'Hesabınız yok mu? ',
                                  style: typography.bodySmall.copyWith(
                                    color: colors.gray4,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) => const RegisterScreen(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Kayıt ol',
                                    style: typography.bodySmall.copyWith(
                                      color: colors.primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
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
    this.controller,
  });

  final String hintText;
  final IconData icon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final double height;
  final TextEditingController? controller;

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
        controller: controller,
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
