import "package:flutter/material.dart";

class News {
  final int id;
  final String title;
  final String body;
  final String image_path;
  final String created_at;
  final bool isFavourite;
//  final int userId;
//  final int teamId;

  News({
    @required this.id,
    @required this.title,
    @required this.body,
    @required this.image_path,
    @required this.created_at,
    this.isFavourite,
  });
//    @required this.userId,
//    @required this.teamId,
}