import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sweet_shop_app_ui/core/theme/dimens.dart';
import 'package:flutter_sweet_shop_app_ui/core/theme/theme.dart';
import 'package:flutter_sweet_shop_app_ui/core/services/auth_service.dart';
import 'package:flutter_sweet_shop_app_ui/core/utils/app_navigator.dart';
import 'package:flutter_sweet_shop_app_ui/core/widgets/app_button.dart';
import 'package:flutter_sweet_shop_app_ui/core/widgets/app_scaffold.dart';
import 'package:flutter_sweet_shop_app_ui/core/widgets/shaded_container.dart';
import 'package:flutter_sweet_shop_app_ui/features/home_feature/presentation/screens/splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isSubmitting = false;
  late final TapGestureRecognizer _loginTap;
  final List<String> _roles = const ['Restoran Sahibi', 'Müşteri', 'Kurye'];
  late String _selectedRole;
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final AuthService _authService = AuthService();
  final RegExp _hasUpperCase = RegExp(r'[A-Z]');
  final RegExp _hasLowerCase = RegExp(r'[a-z]');
  final RegExp _hasDigit = RegExp(r'[0-9]');
  final RegExp _hasSpecial = RegExp(r"[!@#$%^&*(),.?{}|<>_\-+=;'\[\]\\\/`~]");

  @override
  void initState() {
    super.initState();
    _selectedRole = _roles.first;
    _loginTap =
        TapGestureRecognizer()
          ..onTap = () {
            Navigator.of(context).maybePop();
          };
  }

  @override
  void dispose() {
    _loginTap.dispose();
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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

  int _roleIdFor(String role) {
    switch (role) {
      case 'Restoran Sahibi':
        return 1;
      case 'Müşteri':
        return 2;
      case 'Kurye':
        return 3;
      default:
        return 2;
    }
  }

  Future<void> _handleRegister() async {
    if (_isSubmitting) {
      return;
    }
    final colors = context.theme.appColors;
    final fullName = _fullNameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();
    if (fullName.isEmpty || email.isEmpty || password.isEmpty) {
      _showMessage(
        message: 'Lütfen tüm alanları doldurun.',
        backgroundColor: colors.error,
      );
      return;
    }
    final passwordError = _validatePassword(password);
    if (passwordError != null) {
      _showMessage(message: passwordError, backgroundColor: colors.error);
      return;
    }
    if (password != confirmPassword) {
      _showMessage(
        message: 'Şifreler eşleşmiyor.',
        backgroundColor: colors.error,
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      await _authService.register(
        fullName: fullName,
        email: email,
        password: password,
        roleId: _roleIdFor(_selectedRole),
      );
      if (!mounted) {
        return;
      }
      _showMessage(
        message: 'Hesabınız başarı ile oluşturuldu.',
        backgroundColor: colors.success,
      );
      await Future.delayed(const Duration(seconds: 2));
      if (!mounted) {
        return;
      }
      await appPushReplacement(context, const SplashScreen());
    } catch (error) {
      if (!mounted) {
        return;
      }
      final message =
          error is AuthException
              ? error.message
              : 'Hesap oluşturma başarısız. Lütfen tekrar deneyin.';
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
                              controller: _fullNameController,
                            ),
                            SizedBox(height: fieldSpacing),
                            _RegisterInputField(
                              hintText: 'E-posta',
                              icon: Icons.email,
                              keyboardType: TextInputType.emailAddress,
                              height: inputHeight,
                              controller: _emailController,
                            ),
                            SizedBox(height: fieldSpacing),
                            _RegisterRoleField(
                              roles: _roles,
                              value: _selectedRole,
                              height: inputHeight,
                              onChanged: (value) {
                                if (value == null) {
                                  return;
                                }
                                setState(() {
                                  _selectedRole = value;
                                });
                              },
                            ),
                            SizedBox(height: fieldSpacing),
                            _RegisterInputField(
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
                            SizedBox(height: fieldSpacing),
                            _RegisterInputField(
                              hintText: 'Şifre (Tekrar)',
                              icon: Icons.lock,
                              obscureText: _obscureConfirmPassword,
                              height: inputHeight,
                              controller: _confirmPasswordController,
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
                              onPressed: _handleRegister,
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

class _RegisterRoleField extends StatelessWidget {
  const _RegisterRoleField({
    required this.roles,
    required this.value,
    required this.onChanged,
    this.height = 50,
  });

  final List<String> roles;
  final String value;
  final ValueChanged<String?> onChanged;
  final double height;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.appColors;
    final typography = context.theme.appTypography;
    return ShadedContainer(
      height: height,
      borderRadius: 26,
      child: DropdownButtonFormField<String>(
        value: value,
        onChanged: onChanged,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(Icons.badge, color: colors.primary),
          contentPadding: const EdgeInsets.symmetric(
            vertical: Dimens.mediumPadding,
          ),
        ),
        icon: Icon(Icons.keyboard_arrow_down, color: colors.gray4),
        dropdownColor: colors.secondaryShade1,
        style: typography.bodySmall.copyWith(
          color: colors.primaryTint2,
          fontWeight: FontWeight.w600,
        ),
        items:
            roles
                .map(
                  (role) =>
                      DropdownMenuItem<String>(value: role, child: Text(role)),
                )
                .toList(),
      ),
    );
  }
}
