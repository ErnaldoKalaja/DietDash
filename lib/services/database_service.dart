import 'package:intl/intl.dart';
import 'package:mysql1/mysql1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_project/model/grocery_item.dart';
import '../main.dart';

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
    await conn.close();
  }
  
  void registerGoogle({
    required String userId,
    required String email,
    required String userName,
  }) async {
    final conn = await MySqlConnection.connect(settings);
    //check if user exists
    String sql = "SELECT * FROM users WHERE user_id = ?";
    List args = [userId];
    var results = await conn.query(sql, args);
    if (results.isEmpty){
      //doesn't exist  
      String sql = "INSERT INTO users (user_id, user_name, email) VALUES(?,?,?)";
      List args = [userId, userName, email];
      await conn.query(sql, args);
    }
    //else nothing happens
    await conn.close();
  }
  
  addGroceryItem({
    required String name,
    required String importance,
    required Color color,
    required int quantity,
    required DateTime date,
  }) async {
    final conn = await MySqlConnection.connect(settings);
    final formatDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(date);
    String sql = 
    "INSERT INTO shopping_list (user_id, item_name, importance_level, date_time, color, quantity) VALUES(?,?,?,?,?,?)";
    var userId = FirebaseAuth.instance.currentUser!; 
    List args = [userId, name, importance, formatDate, color, quantity];
    var result = await conn.query(sql, args);
    await conn.close();
    return result.insertId!;
  }

  updateGroceryItem({
    required int id,
    required String name,
    required String importance,
    required Color color,
    required int quantity,
    required DateTime date,
  }) async {
    final conn = await MySqlConnection.connect(settings);
    final formatDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(date);
    String sql = 
      """UPDATE shopping_list 
      SET user_id = ?, 
      item_name = ?, 
      importance_level = ?, 
      date_time = ?, 
      color = ?, 
      quantity = ?
      WHERE item_id = ? 
      """;
    var userId = FirebaseAuth.instance.currentUser!; 
    List args = [userId, name, importance, formatDate, color, quantity, id];
    await conn.query(sql, args);
    await conn.close();
  }

  getGroceryItem({  
    required int id,
  }) async {
    final conn = await MySqlConnection.connect(settings);
    String sql = 
    "SELECT item_name, importance_level, date_time, color, quantity FROM shopping_list WHERE item_id = ?";
    List args = [id];
    var results = await conn.query(sql, args);
    await conn.close();
    //return results.first; //uncomment if you want to use the array as is
    var result = results.first;
    var groceryItem = { //a map to make the returned object more readable
      "name": result[0], 
      "importance": result[1], 
      "date": result[2],
      "color": result[3],
      "quantity": result[4], 
    };
    return groceryItem;
  }

  deleteGroceryItem({
    required int id,
  }) async {
    final conn = await MySqlConnection.connect(settings);
    String sql = "DELETE FROM shopping_list WHERE item_id = ?";
    List args = [id];
    await conn.query(sql, args);
    await conn.close();
  }

  getGroceryItems() async {
    final conn = await MySqlConnection.connect(settings);
    var userId = FirebaseAuth.instance.currentUser!; 
    String sql = 
    "SELECT item_id, item_name, importance_level, date_time, color, quantity FROM shopping_list WHERE user_id = ?";
    List args = [userId];
    var results = await conn.query(sql, args);
    await conn.close();
    List items = [];
    for (var result in results){
      var item = {
        "id": result[0],
        "name": result[1], 
        "importance": result[2], 
        "date": result[3],
        "color": result[4],
        "quantity": result[5], 
      };
      items.add(item);
    }
    return items;
  }

}