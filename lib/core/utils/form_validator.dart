abstract class FormValidator {
  static final _emailRegex = RegExp(r"^[\w.+-]+@[\w-]+\.[\w.]+$");

  static String? validateRequired(String? value, {String fieldName = "Kolom ini"}) {
    if (value == null || value.trim().isEmpty) {
      return "$fieldName wajib diisi";
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return "Email wajib diisi";
    if (!_emailRegex.hasMatch(value.trim())) return "Masukkan alamat email yang valid";
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return "Kata sandi wajib diisi";
    if (value.length < 8) return "Kata sandi minimal 8 karakter";
    return null;
  }

  static String? validateConfirmPassword(String? value, String original) {
    if (value == null || value.isEmpty) return "Harap konfirmasi kata sandi Anda";
    if (value != original) return "Kata sandi tidak cocok";
    return null;
  }

  static String? validateMinLength(String? value, int min, {String fieldName = "Kolom ini"}) {
    if (value == null || value.trim().isEmpty) return "$fieldName wajib diisi";
    if (value.trim().length < min) return "$fieldName minimal $min karakter";
    return null;
  }
}
