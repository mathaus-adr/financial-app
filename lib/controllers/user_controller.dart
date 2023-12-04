import 'dart:convert';

import 'package:financialweb/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
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

    // users = await repository.list();
    loading = false;
    notifyListeners();

    return users;
  }

  login(String email, String password) async {
    var response = await http.post(Uri.parse('http://192.168.207.1/api/login'),
        body: {"email": email, "password": password});

    if (response.statusCode != 200) {
      return Future.value(false);
    }
    Map mappedResponse = json.decode(response.body);

    if (mappedResponse.containsKey('token')) {
      // _token = mappedResponse['token'];
      repository.saveToken(mappedResponse['token']);
      // notifyListeners();
      return Future.value(true);
    }
    return Future.value(false);
  }

  cadastrar(String nome, String email, String password) async {
    var response = await http.post(Uri.parse('http://192.168.207.1/api/signup'),
        body: {"email": email, "password": password, "name": nome});

    if (response.statusCode == 201) {
      
      return Future.value(true);
    }

    return Future.value(false);
  }


}
