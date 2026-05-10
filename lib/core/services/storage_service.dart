import "package:flutter_secure_storage/flutter_secure_storage.dart";
import "package:get/get.dart";
import "../constants/storage_keys.dart";

class StorageService extends GetxService {
  final _storage = const FlutterSecureStorage(aOptions: AndroidOptions(encryptedSharedPreferences: true));

  String? _cachedUserId;

  Future<StorageService> init() async {
    _cachedUserId = await _storage.read(key: StorageKeys.accessToken);
    return this;
  }

  bool hasToken() => _cachedUserId != null && _cachedUserId!.isNotEmpty;

  String? getToken() => _cachedUserId;

  String? getCurrentUserId() => _cachedUserId;

  Future<void> saveToken(String userId) async {
    _cachedUserId = userId;
    await _storage.write(key: StorageKeys.accessToken, value: userId);
  }

  Future<void> clearToken() async {
    _cachedUserId = null;
    await _storage.deleteAll();
  }
}
