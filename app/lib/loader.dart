import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CatCard {
  final String imageUrl;
  final String id;
  final String origin;
  final String lifeSpan;
  final String temperament;
  final String breed;
  final String description;

  const CatCard({
    required this.imageUrl,
    required this.id,
    required this.origin,
    required this.lifeSpan,
    required this.temperament,
    required this.breed,
    required this.description,
  });

  factory CatCard.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'url': String url, 'id': String id, 'breeds': List<dynamic> breeds} =>
        CatCard(
          imageUrl: url,
          id: id,
          origin: breeds[0]["origin"] as String,
          lifeSpan: breeds[0]["life_span"] as String,
          temperament: breeds[0]["temperament"] as String,
          breed: breeds[0]["name"] as String,
          description: breeds[0]['description'],
        ),
      _ => throw const FormatException('Failed to parse card.'),
    };
  }
}

Future<CatCard> fetchCard() async {
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
    return CatCard.fromJson(
        jsonDecode(response.body)[0] as Map<String, dynamic>);
  } else {
    throw FormatException("Server returned %s", response.statusCode);
  }
}
