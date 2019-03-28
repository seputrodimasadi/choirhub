import "package:flutter/material.dart";

class Song {
  final int id;
  final String name;
  final String body;
  final String created_at;
  final String updated_at;
  final int user_id;
  final int team_id;

  Song({
    @required this.id,
    @required this.name,
    @required this.body,
    @required this.created_at,
    @required this.updated_at,
    @required this.user_id,
    @required this.team_id,
  });
}