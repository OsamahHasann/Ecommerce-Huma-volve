import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Storage {
  static final storage = FlutterSecureStorage();

  static Future<void> saveAccessToken(String token) async {
    await storage.write(key: 'access_token', value: token);
  }

  static Future<String?> getAccessToken() async {
    String? accessToken = await storage.read(key: 'access_token');
    return accessToken;
  }

  static Future<void> saveRefreshToken(String token) async {
    await storage.write(key: 'refresh_token', value: token);
  }

  static Future<String?> getRefreshToken() async {
    String? refreshToken = await storage.read(key: 'refresh_token');
    return refreshToken;
  }

  static Future<void> deleteAccessToken() async {
    await storage.deleteAll();
  }
}
