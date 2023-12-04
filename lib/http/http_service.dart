import 'package:financialweb/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HttpService {
  String baseUrl;
  UserRepository repository;
  late String authToken;

  HttpService(this.baseUrl, this.repository);

  Future<http.Response> get(String path) async {
    final url = Uri.parse("$baseUrl$path");
    final token = await repository.getToken();

    final headers = {'Authorization': 'Bearer $token'};
    return await http.get(url, headers: headers);
  }

  Future<http.Response> post(String path, dynamic body) async {
    final url = Uri.parse("$baseUrl$path");
    final token = await repository.getToken();
    final headers = {'Authorization': 'Bearer $token'};
    return await http.post(url, headers: headers, body: body);
  }

  // Add more methods for other HTTP methods as needed

  // BEGIN: add-authentication-method
  void updateAuthToken(String newAuthToken) {
    authToken = newAuthToken;
  }

  Future<http.Response> put(String path, dynamic body) async {
    final url = Uri.parse("$baseUrl$path");
    final token = await repository.getToken();
    final headers = {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};
    return await http.put(url, headers: headers, body: body);
  }
}
