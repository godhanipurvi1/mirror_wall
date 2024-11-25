import 'package:flutter/material.dart';
import 'package:mirrorwall/provider/provider.dart';
import 'package:mirrorwall/views/homepage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WebViewModel()),
      ],
      child: MaterialApp(
        home: WebViewScreen(),
      ),
    );
  }
}
