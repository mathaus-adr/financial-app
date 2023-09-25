import 'package:financialweb/components/app/app_navbar.dart';
import 'package:financialweb/components/conta/conta_list.dart';
import 'package:flutter/material.dart';

class AtividadePage extends StatefulWidget {
  const AtividadePage({ Key? key }) : super(key: key);

  @override
  State<AtividadePage> createState() => _AtividadePageState();
}

class _AtividadePageState extends State<AtividadePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ContaList(),
      bottomNavigationBar: AppNavBar(),
    );
  }
}