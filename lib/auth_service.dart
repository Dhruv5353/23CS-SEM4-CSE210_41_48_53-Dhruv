import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  static const String baseUrl =
      'https://authantication-dcj6.onrender.com/api/auth';
  final storage = const FlutterSecureStorage();

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // Store the token securely
        await storage.write(key: 'auth_token', value: data['token']);
        await storage.write(key: 'user_role', value: data['role']);
        await storage.write(key: 'user_name', value: data['name']);
        return data;
      } else {
        throw Exception('Failed to login: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error during login: $e');
    }
  }

  Future<Map<String, dynamic>> register(
      String name, String email, String password, String role) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': name,
          'email': email,
          'password': password,
          'role': role,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(response.body);
        // Store the token securely
        await storage.write(key: 'auth_token', value: data['token']);
        await storage.write(key: 'user_role', value: data['role']);
        await storage.write(key: 'user_name', value: data['name']);
        return data;
      } else {
        throw Exception('Failed to register: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error during registration: $e');
    }
  }

  Future<String?> getToken() async {
    return await storage.read(key: 'auth_token');
  }

  Future<String?> getUserRole() async {
    return await storage.read(key: 'user_role');
  }

  Future<String?> getUserName() async {
    return await storage.read(key: 'user_name');
  }

  Future<void> logout() async {
    await storage.deleteAll();
  }
}
