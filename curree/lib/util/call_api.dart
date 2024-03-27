import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



Future<String> callGetAPI(Uri url) async {
  try {
    http.Response response = await http.get(url, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200 || response.statusCode == 201) {
      String data = utf8.decode(response.bodyBytes);
      return data;
    } else {
      throw Exception('Request failed with status: ${response.statusCode}');
    }
  } catch (error) {
    throw Exception('Request failed with error: $error');
    }
  }


Future<String> callMethodAPI(Uri url, Map<String, dynamic> body, String method) async {
  try {
    late http.Response response;
    if (method == "POST") {
      response = await http.post(
        url,
        body: jsonEncode(body),
        headers: {
          "Content-Type": "application/json",
        },
      );
    } else if (method == "PUT") {
      response = await http.put(
        url,
        body: jsonEncode(body),
        headers: {
          "Content-Type": "application/json",
        },
      );
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      String data = utf8.decode(response.bodyBytes);
      return data;
    } else {
      throw Exception('Request failed with status: ${response.statusCode}, ${utf8.decode(response.bodyBytes)}');
    }
  } catch (error) {
    throw Exception('Request failed with error: $error');
  }
}