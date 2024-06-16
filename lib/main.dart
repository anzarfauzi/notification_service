import 'package:flutter/material.dart';
import 'package:notification_service/notification_service.dart'; // Sesuaikan path ini

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi notifikasi
  NotificationService().initialize();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Notification Demo'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Meminta izin notifikasi
            NotificationService().requestPermission(context);
            // Mengirim notifikasi dasar
            NotificationService().sendBasicNotification(
              'Hello',
              'This is a basic notification',
            );
          },
          child: Text('Show Notification'),
        ),
      ),
    );
  }
}
