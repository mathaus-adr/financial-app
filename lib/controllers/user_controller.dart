import 'package:financialweb/repositories/user_repository.dart';
import 'package:flutter/material.dart';

import '../models/user.dart';

class UserController extends ChangeNotifier {
  final UserRepository repository;
  bool loading = false;
  List<User> users = [];

  UserController(this.repository) {
    load();
  }

  Future<List<User>> load() async {
    loading = true;
    notifyListeners();

    users = await repository.list();
    loading = false;
    notifyListeners();

    return users;
  }

  login(String email, String password) {
    if (users.isNotEmpty) {
      List<User> foundedUser = users
          .where((user) => user.email == email && user.password == password)
          .toList();
      if (foundedUser.isNotEmpty) return true;
    }
    return false;
  }

  cadastrar(String nome, String email, String password) {
    if (users.isNotEmpty) {
      List<User> foundedUser =
          users.where((user) => user.email == email).toList();
      if (foundedUser.isNotEmpty) return false;
    }
    return repository.cadastrar(email, password, nome);
  }
}
