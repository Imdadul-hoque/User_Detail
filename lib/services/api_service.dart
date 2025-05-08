import 'dart:convert';

import 'package:user_diteals/models/user.dart';
import 'package:http/http.dart'as http;

class ApiService{
  static Future<List<User>> fetchUsers() async{
    final response= await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    if(response.statusCode==200){
      List jsonResponse=jsonDecode(response.body);
      return jsonResponse.map<User>((json) => User.fromJson(json)).toList();

    }else{
      throw Exception('Failed to load user.Server responded with ${response.statusCode}.');
    }
  }
}