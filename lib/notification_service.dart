import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class NotificationService {
  // Singleton pattern
  static final NotificationService _instance = NotificationService._internal();

  factory NotificationService() {
    return _instance;
  }

  NotificationService._internal();

  /// Menginisialisasi notifikasi dengan channel dan ikon default.
  void initialize() {
    AwesomeNotifications().initialize(
      // Set ikon default untuk notifikasi
      'resource://drawable/res_app_icon',
      [
        NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: Color(0xFF9D50DD),
          ledColor: Colors.white,
          importance: NotificationImportance.High,
        )
      ],
    );
  }

  /// Meminta izin untuk menampilkan notifikasi kepada pengguna.
  Future<void> requestPermission(BuildContext context) async {
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) {
      // Menampilkan dialog permintaan izin kepada pengguna
      await _showPermissionDialog(context);
    }
  }

  Future<void> _showPermissionDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // Dialog tidak dapat ditutup dengan mengetuk di luar
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Izin Notifikasi'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Aplikasi ini membutuhkan izin untuk menampilkan notifikasi.'),
                Text('Harap izinkan notifikasi di pengaturan.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () async {
                Navigator.of(context).pop();
                // Meminta izin notifikasi setelah pengguna menekan "OK"
                await AwesomeNotifications().requestPermissionToSendNotifications();
              },
            ),
          ],
        );
      },
    );
  }

  /// Mengirim notifikasi dasar.
  void sendBasicNotification(String title, String body) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 10,
        channelKey: 'basic_channel',
        title: title,
        body: body,
      ),
    );
  }
}
