import 'package:mysql1/mysql1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class DatabaseService{

  final settings = ConnectionSettings(
    host: '34.134.68.69',
    port: 3306,
    user: 'root',
    password: 'test123',
    db: 'mealapp',
  );
  
  void registerEmail({
    required String userId,
    required String email,
    required String userName,
  }) async {
    final conn = await MySqlConnection.connect(settings);
    String sql = "INSERT INTO users (user_id, user_name, email) VALUES(?,?,?)";
    List args = [userId, userName, email];
    await conn.query(sql, args);
  }
 

}