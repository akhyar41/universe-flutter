# MoM Note

Aplikasi **Minutes of Meeting (Notulen Rapat)** berbasis Flutter untuk mencatat dan mengelola hasil rapat secara lokal di perangkat.

---

## Fitur

- **Autentikasi** — Daftar akun, masuk, dan keluar dengan penyimpanan data lokal
- **Buat Notulen** — Isi judul, tanggal & waktu, lokasi, agenda, peserta, dan diskusi/catatan
- **Edit & Hapus Notulen** — Perbarui atau hapus data rapat yang sudah tersimpan
- **Daftar Rapat** — Tampilan semua notulen diurutkan berdasarkan tanggal terbaru
- **Perbarui Profil** — Ubah nama dan email akun
- **Perbarui Kata Sandi** — Ganti kata sandi dengan verifikasi kata sandi lama
- **Versi Aplikasi** — Ditampilkan di halaman pengaturan

---

## Tech Stack

| Kebutuhan | Package |
|---|---|
| State, Routing, DI | `get ^4.7.2` |
| Database lokal | `hive ^2.2.3` + `hive_flutter ^1.1.0` |
| Penyimpanan token | `flutter_secure_storage ^9.2.4` |
| Preferensi ringan | `get_storage ^2.1.1` |
| Hash kata sandi | `crypto ^3.0.3` |
| UUID | `uuid ^4.5.1` |
| Date & time picker | `omni_datetime_picker ^2.0.4` |
| Format tanggal | `intl ^0.20.2` |
| Info versi app | `package_info_plus ^8.3.0` |

---

## Struktur Proyek

```
lib/
├── main.dart
├── app.dart                          # Root widget — GetMaterialApp
│
├── core/
│   ├── constants/
│   │   ├── storage_keys.dart         # Key untuk secure storage
│   │   └── app_strings.dart
│   ├── errors/
│   │   ├── app_exception.dart
│   │   └── failure.dart
│   ├── services/
│   │   ├── hive_service.dart         # Inisialisasi & akses Hive box
│   │   ├── auth_service.dart         # Login, register, update profil & kata sandi
│   │   ├── meeting_service.dart      # CRUD notulen rapat
│   │   └── storage_service.dart      # Wrapper flutter_secure_storage
│   └── utils/
│       ├── form_validator.dart       # Validasi form (email, password, required)
│       ├── date_formatter.dart       # Format tanggal & waktu
│       └── snackbar_helper.dart      # Snackbar success / error / info
│
├── data/
│   └── models/
│       ├── user_model.dart           # Model user + Hive adapter (typeId 0)
│       ├── meeting_note_model.dart   # Model notulen + Hive adapter (typeId 2)
│       └── action_item_model.dart    # Model tindak lanjut + Hive adapter (typeId 1)
│
└── ui/
    ├── bindings/
    │   └── initial_binding.dart      # DI level app (AuthService, MeetingService)
    ├── routes/
    │   ├── app_routes.dart           # Konstanta nama route
    │   ├── app_pages.dart            # Daftar GetPage + binding
    │   └── app_middleware.dart       # AuthMiddleware — guard route terproteksi
    ├── themes/
    │   ├── app_theme.dart            # ThemeData Material 3
    │   ├── app_colors.dart           # Palet warna
    │   └── app_text_styles.dart      # TextStyle terpusat
    ├── _components/
    │   └── widgets/
    │       ├── app_button.dart       # Tombol utama dengan state loading
    │       ├── app_text_field.dart   # Input field dengan label & validasi
    │       └── app_loader.dart
    └── screens/
        ├── splash/                   # Cek token → redirect login atau home
        ├── auth/
        │   ├── login/                # Halaman masuk
        │   └── register/             # Halaman daftar akun
        ├── home/
        │   ├── home_screen.dart      # Host BottomNavigationBar (2 tab)
        │   ├── meeting_list/         # Tab daftar notulen + hapus
        │   ├── meeting_form/         # Form buat & edit notulen
        │   └── _components/          # MeetingCard, EmptyStateWidget
        └── settings/
            ├── settings_tab.dart     # Tab pengaturan + profil + keluar
            ├── update_profile/       # Form ubah nama & email
            └── update_password/      # Form ubah kata sandi
```

---

## Alur Navigasi

```
Splash
  ├── (tidak ada token) → Login → Register
  └── (ada token)       → Home
                              ├── Tab: Daftar Notulen → Form Rapat
                              └── Tab: Pengaturan → Perbarui Profil
                                                  → Perbarui Kata Sandi
```

---

## Menjalankan Proyek

```bash
flutter pub get
flutter run
```
