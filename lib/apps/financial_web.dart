import 'package:flutter/material.dart';

import '../pages/initial_page.dart';

const String appName = 'FinancialWeb';

class FinancialApp extends StatelessWidget {
  const FinancialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: InitialPage(),
    );
  }
}
