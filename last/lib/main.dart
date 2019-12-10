//kode utama Aplikasi tampilan 
import 'home.dart';
import 'package:flutter/material.dart';
//package letak folder Anda
void main() => runApp(MyApp());
// Future<void> main() async {
//   runApp(MyApp());
// }


// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Home(),
//     );
//   }
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    //judul
      title: 'Tambahkan Daftar',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Home(),
    );
  }
}