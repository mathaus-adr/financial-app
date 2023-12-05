import 'package:hive_flutter/hive_flutter.dart';

import '../models/user.dart';

class UserRepository {
  late Box<String> box;
  User? _user;
  UserRepository() {
    initHive();
  }

  getAuthenticatedUser() {
    return _user;
  }

  openBox() async {
    await initHive();
    box = await Hive.openBox<String>('users');
  }

  login(String email, String password) async {
    var users = await list();
    final user = users
        .where((user) => user.email == email && user.password == password)
        .toList();

    if (user.isNotEmpty) {
      _user = user.first;
      return true;
    }
    return false;
  }

  bool cadastrar(String email, String password, String nome) {
    if (!box.isOpen) {
      openBox();
    }
    return save(User(email: email, password: password, name: nome));
  }

  save(User user) {
    if (!box.isOpen) {
      openBox();
    }
    // box.add(user);
    return true;
  }

  saveToken(String token) async {
    await openBox();
    if (!box.isOpen) {
      openBox();
    }
    box.put('token', token);
  }

  Future<String?> getToken() async {
    await openBox();
    if (!box.isOpen) {
      openBox();
    }
    return Future.value(box.get('token'));
  }

  initHive() async {
    await Hive.initFlutter();
  }

  list() async {
    await openBox();

    return box.values.toList();
  }
}
