// To parse this JSON data, do
//
//     final gushiModel = gushiModelFromJson(jsonString);

import 'dart:convert';

class GushiModel {
  GushiModel({
    this.content,
    this.origin,
    this.author,
    this.category,
  });

  final String content;
  final String origin;
  final String author;
  final String category;

  factory GushiModel.fromRawJson(String str) => GushiModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GushiModel.fromJson(Map<String, dynamic> json) => GushiModel(
    content: json["content"] == null ? null : json["content"],
    origin: json["origin"] == null ? null : json["origin"],
    author: json["author"] == null ? null : json["author"],
    category: json["category"] == null ? null : json["category"],
  );

  Map<String, dynamic> toJson() => {
    "content": content == null ? null : content,
    "origin": origin == null ? null : origin,
    "author": author == null ? null : author,
    "category": category == null ? null : category,
  };
}
