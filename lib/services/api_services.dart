import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:test_project/model/meal_plan_model.dart';

import '../model/recipe_model.dart';

class ApiService {
  ApiService._instantiate();
  static final ApiService instance = ApiService._instantiate();

  final String _baseURL = "api.spoonacular.com";
  static const String API_KEY ="ffba4c20eef44167a68f336e4a196007";

  Future<MealPlan> generateMealPlan({int targetCalories, String diet}) async {
    print("Generate Meal Plan - Target Calories: $targetCalories, Diet: $diet");
    //check if diet is null
    if (diet == 'None') diet = '';
    Map<String, String> parameters = {
      'timeFrame': 'day', //to get 3 meals
      'targetCalories': targetCalories.toString(),
      'diet': diet,
      'apiKey': API_KEY,
    };



    Uri uri = Uri.https(
      _baseURL,
      '/recipes/mealplans/generate',
      parameters,
    );



    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };



    try {

      var response = await http.get(uri, headers: headers);

      Map<String, dynamic> data = json.decode(response.body);
      print("API Response: $data"); // Add this line to print the API response

      MealPlan mealPlan = MealPlan.fromMap(data);
      return mealPlan;
    }catch (err) {

      throw err.toString();
    }

  }



  Future<Recipe> fetchRecipe(String id) async {
    Map<String, String> parameters = {
      'includeNutrition': 'false',
      'apiKey': API_KEY,
    };


    Uri uri = Uri.https(
      _baseURL,
      '/recipes/$id/information',
      parameters,
    );

    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };


    try{
      var response = await http.get(uri, headers: headers);
      Map<String, dynamic> data = json.decode(response.body);
      Recipe recipe = Recipe.fromMap(data);
      return recipe;
    }catch (err) {
      throw err.toString();
    }

  }

}