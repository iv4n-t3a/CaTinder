import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:app/domain/entities/cat.dart';
import 'package:app/data/cats/model.dart';

class CatLoaderImpl implements CatLoader {
  @override
  Future<Cat> loadCat() async {
    final queryParameters = {
      'size': 'med',
      'mime_types': 'jpg',
      'format': 'json',
      'has_breeds': 'true',
      'order': 'RANDOM',
      'page': '0',
      'limit': '1'
    };

    const headers = {
      "Content-Type": "application/json",
      "x-api-key":
          "live_rAxM6y87Cf77PI4SjVAePN7ZKpgg4ELhIG4xn9WizqDOvV2mLNAxjeJf9DfyRe4q"
    };
    final uri =
        Uri.https('api.thecatapi.com', 'v1/images/search', queryParameters);

    final response = await http.get(uri, headers: headers);

    if (response.statusCode == HttpStatus.ok) {
      return CatModel.fromJson(
              jsonDecode(response.body)[0] as Map<String, dynamic>)
          .getCat();
    } else {
      throw FormatException("Server returned %s", response.statusCode);
    }
  }
}
