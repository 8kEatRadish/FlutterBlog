// To parse this JSON data, do
//
//     final article = articleFromJson(jsonString);

import 'dart:convert';

class Results {
  Results({
    this.results,
  });

  final List<ArticleModel> results;

  factory Results.fromRawJson(String str) => Results.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Results.fromJson(Map<String, dynamic> json) => json == null
      ? null
      : Results(
          results: json["results"] == null
              ? null
              : List<ArticleModel>.from(
                  json["results"].map((x) => ArticleModel.fromJson(x))),
        );

  Map<String, dynamic> toJson() => {
        "results": results == null
            ? null
            : List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class ArticleModel {
  ArticleModel({
    this.tags,
    this.updatedAt,
    this.top,
    this.content,
    this.objectId,
    this.createTime,
    this.cover,
    this.createdAt,
    this.title,
  });

  final String tags;
  final String updatedAt;
  final bool top;
  final String content;
  final String objectId;
  final int createTime;
  final String cover;
  final String createdAt;
  final String title;

  factory ArticleModel.fromRawJson(String str) =>
      ArticleModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ArticleModel.fromJson(Map<String, dynamic> json) => json == null
      ? null
      : ArticleModel(
          tags: json["tags"] == null ? null : json["tags"],
          updatedAt: json["updatedAt"] == null ? null : json["updatedAt"],
          top: json["top"] == null ? null : json["top"],
          content: json["content"] == null ? null : json["content"],
          objectId: json["objectId"] == null ? null : json["objectId"],
          createTime: json["createTime"] == null ? null : json["createTime"],
          cover: json["cover"] == null ? null : json["cover"],
          createdAt: json["createdAt"] == null ? null : json["createdAt"],
          title: json["title"] == null ? null : json["title"],
        );

  Map<String, dynamic> toJson() => {
        "tags": tags == null ? null : tags,
        "updatedAt": updatedAt == null ? null : updatedAt,
        "top": top == null ? null : top,
        "content": content == null ? null : content,
        "objectId": objectId == null ? null : objectId,
        "createTime": createTime == null ? null : createTime,
        "cover": cover == null ? null : cover,
        "createdAt": createdAt == null ? null : createdAt,
        "title": title == null ? null : title,
      };
}
