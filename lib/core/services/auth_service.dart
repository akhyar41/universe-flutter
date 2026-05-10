import "dart:convert";

import "package:crypto/crypto.dart";
import "package:get/get.dart";
import "package:uuid/uuid.dart";

import "../../../data/models/user_model.dart";
import "hive_service.dart";
import "storage_service.dart";

class AuthService extends GetxService {
  static AuthService get to => Get.find();

  final _hive = Get.find<HiveService>();
  final _storage = Get.find<StorageService>();

  bool get isLoggedIn => _storage.hasToken();

  String? get currentUserId => _storage.getCurrentUserId();

  UserModel? get currentUser {
    final id = currentUserId;
    if (id == null) return null;
    return _hive.users.get(id);
  }

  Future<void> login(String email, String password) async {
    final normalized = email.trim().toLowerCase();
    final user = _hive.users.values.cast<UserModel?>().firstWhere((u) => u?.email == normalized, orElse: () => null);
    if (user == null || _hash(password) != user.passwordHash) {
      throw Exception("Email atau kata sandi salah");
    }
    await _storage.saveToken(user.id);
  }

  Future<void> register(String name, String email, String password) async {
    final normalized = email.trim().toLowerCase();
    final exists = _hive.users.values.any((u) => u.email == normalized);
    if (exists) throw Exception("Email sudah terdaftar");

    final user = UserModel(id: const Uuid().v4(), name: name.trim(), email: normalized, passwordHash: _hash(password));
    await _hive.users.put(user.id, user);
    await _storage.saveToken(user.id);
  }

  Future<void> updateProfile(String name, String email) async {
    final id = currentUserId!;
    final user = _hive.users.get(id)!;
    final normalized = email.trim().toLowerCase();

    final emailTaken = _hive.users.values.any((u) => u.email == normalized && u.id != id);
    if (emailTaken) throw Exception("Email sudah digunakan oleh akun lain");

    await _hive.users.put(id, user.copyWith(name: name.trim(), email: normalized));
  }

  Future<void> updatePassword(String currentPassword, String newPassword) async {
    final id = currentUserId!;
    final user = _hive.users.get(id)!;
    if (_hash(currentPassword) != user.passwordHash) {
      throw Exception("Kata sandi saat ini tidak sesuai");
    }
    await _hive.users.put(id, user.copyWith(passwordHash: _hash(newPassword)));
  }

  Future<void> logout() async {
    await _storage.clearToken();
  }

  String _hash(String password) {
    final bytes = utf8.encode(password);
    return sha256.convert(bytes).toString();
  }
}
