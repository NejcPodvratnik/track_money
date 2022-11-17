import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List> FetchWpPosts() async {
  final response = await http.get(
      Uri.parse(
          "https://newsapi.org/v2/everything?q=finance&from=2022-11-17&sortBy=popularity&apiKey=b7e5ffea41874a2d9d662fc3bc5d596d"),
      headers: {"Accept": "application/json"});

  var convertedDataToJson = jsonDecode(response.body);
  return convertedDataToJson['articles'];
}