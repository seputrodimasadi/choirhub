import "package:flutter/material.dart";

class Product {
  final String id;
  final String title;
  final String description;
  final double price;
  final String image;
  final String userEmail;
  final int userId;
  final bool isFavourite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.image,
    @required this.userEmail,
    @required this.userId,
    this.isFavourite = false
  });
}