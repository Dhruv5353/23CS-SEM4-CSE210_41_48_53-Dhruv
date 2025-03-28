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
        await storage.write(key: 'email', value: email);
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

  Future<Map<String, dynamic>> saveStudentProfile({
    required String name,
    required String phone,
    required String collegeId,
    required String birthdate,
    required String email,
  }) async {
    try {
      final token = await storage.read(key: 'auth_token');
      if (token == null) throw Exception('No authentication token found');

      final response = await http.post(
        Uri.parse(
            'https://authantication-dcj6.onrender.com/api/students/profile'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'name': name,
          'phone': phone,
          'collegeId': collegeId,
          'birthdate': birthdate,
          'email': email,
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to save profile: ${response.body}');
      }
    } catch (e) {
      print('Error saving profile: $e');
      throw Exception('Error saving profile: $e');
    }
  }

  Future<Map<String, dynamic>> saveFacultyProfile({
    required String department,
  }) async {
    try {
      final token = await storage.read(key: 'auth_token');
      if (token == null) throw Exception('No authentication token found');

      final response = await http.post(
        Uri.parse(
            'https://authantication-dcj6.onrender.com/api/faculty/profile'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'department': department,
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to save profile: ${response.body}');
      }
    } catch (e) {
      print('Error saving profile: $e');
      throw Exception('Error saving profile: $e');
    }
  }
}
