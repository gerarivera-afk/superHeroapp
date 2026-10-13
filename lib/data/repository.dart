import 'dart:convert';

import 'package:superheroapp/data/model/superhero_response.dart';
import 'package:http/http.dart' as http;


class Repository {

 Future<SuperheroResponse?> fetchSuperheroInfo(String name) async{
    final response = await http.get(Uri.parse(
      "https://superheroapi.com/api/df1a7994a23be1a83030d85e62b0f2d6/search/$name"
    ));

    if (response.statusCode == 200) {
      var decodedJson =jsonDecode(response.body);
      SuperheroResponse superheroResponse = SuperheroResponse.fromJson(decodedJson); 
      return superheroResponse;
    }else{
      return null;
    }
 } 
}