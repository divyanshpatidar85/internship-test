import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quadb_tech/model.dart';
import 'dart:developer';

class ApiData with ChangeNotifier{
  // ignore: prefer_final_fields
  List<TvShowResponse>_data=[];

   List<TvShowResponse> get data=>_data;
  Future<void> fetchTvShows() async {

  
  final response = await http.get(Uri.parse('https://api.tvmaze.com/search/shows?q=all'));
  List<dynamic> dataa=List<dynamic>.from(jsonDecode(response.body));
  if (response.statusCode == 200) {
  for(int i=0;i<dataa.length;i++){
  _data.add(TvShowResponse.fromJson(dataa[i] as Map<String,dynamic>));

  print("here is data ${_data[i].show.url}");
  }

   print("final length is here  ${_data.length}");
  notifyListeners();
  
  } else {
    throw Exception('Failed to load TV shows');
  }
}
}
