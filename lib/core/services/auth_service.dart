import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/auth_response.dart';

class AuthService {
  AuthService({String? baseUrl, List<String>? baseUrls})
    : _baseUrls = _resolveBaseUrls(baseUrl, baseUrls);

  static const String _envBaseUrl = String.fromEnvironment('API_BASE_URL');
  final List<String> _baseUrls;

  Future<AuthResponse> login({
    required String email,
    required String password,
  }) async {
    final response = await _postWithFallback(
      path: '/api/auth/login',
      body: {'email': email, 'password': password},
    );
    return _handleAuthResponse(response);
  }

  Future<AuthResponse> register({
    required String fullName,
    required String email,
    required String password,
    required int roleId,
  }) async {
    final response = await _postWithFallback(
      path: '/api/auth/register',
      body: {
        'fullName': fullName,
        'email': email,
        'password': password,
        'roleId': roleId,
      },
    );
    return _handleAuthResponse(response);
  }

  Future<http.Response> _postWithFallback({
    required String path,
    required Map<String, dynamic> body,
  }) async {
    for (final baseUrl in _baseUrls) {
      try {
        return await http
            .post(
              Uri.parse('$baseUrl$path'),
              headers: const {'Content-Type': 'application/json'},
              body: jsonEncode(body),
            )
            .timeout(const Duration(seconds: 8));
      } on Exception catch (error) {
        if (kDebugMode) {
          debugPrint('AuthService bağlantı hatası ($baseUrl): $error');
        }
      }
    }
    throw AuthException(
      'Sunucuya bağlanılamadı. Lütfen bağlantınızı kontrol edin.',
    );
  }

  AuthResponse _handleAuthResponse(http.Response response) {
    final status = response.statusCode;
    if (status >= 200 && status < 300) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return AuthResponse.fromJson(data);
    }

    throw AuthException(_extractMessage(response));
  }

  String _extractMessage(http.Response response) {
    try {
      final data = jsonDecode(response.body);
      if (data is Map<String, dynamic> && data['message'] != null) {
        return data['message'].toString();
      }
    } catch (_) {}

    if (response.body.isNotEmpty) {
      return response.body;
    }
    return 'İşlem sırasında bir hata oluştu.';
  }

  static List<String> _resolveBaseUrls(
    String? baseUrl,
    List<String>? baseUrls,
  ) {
    final urls = <String>[];
    if (baseUrl != null && baseUrl.trim().isNotEmpty) {
      urls.add(baseUrl.trim());
      return urls;
    }
    if (baseUrls != null && baseUrls.isNotEmpty) {
      urls.addAll(baseUrls.where((url) => url.trim().isNotEmpty));
      if (urls.isNotEmpty) {
        return urls;
      }
    }
    if (_envBaseUrl.trim().isNotEmpty) {
      urls.add(_envBaseUrl.trim());
      return urls;
    }
    if (kIsWeb) {
      urls.add('http://localhost:5000');
      return urls;
    }
    urls.addAll([
      'http://10.0.2.2:5000',
      'http://192.168.45.149:5000',
    ]);
    return urls;
  }
}

class AuthException implements Exception {
  AuthException(this.message);

  final String message;

  @override
  String toString() => message;
}
