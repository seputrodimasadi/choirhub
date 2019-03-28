import "package:flutter/material.dart";

class Event {
  final int userId;
  final int teamId;
  final String createdAt;
  final String updatedAt;
  final int id;

  final String name;
  final String body;
  final String startAt;
  final String endAt;
  final String startToEnd;
  final String address;
  final String suburb;
  final int postcode;
  final String state;
  final String country;

  Event({
    @required this.userId,
    @required this.teamId,
    @required this.createdAt,
    @required this.updatedAt,
    @required this.id,
    @required this.name,
    @required this.body,
    @required this.startAt,
    @required this.endAt,
    @required this.startToEnd,
    @required this.address,
    @required this.suburb,
    @required this.postcode,
    @required this.state,
    @required this.country,
  });
}