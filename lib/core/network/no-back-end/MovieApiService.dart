import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:streamrank/core/utils/Config.dart';

class MovieApiService {
  final String baseUrl = Config.moviesBaseUrl;
}