import 'package:flutter/material.dart';

class FoodModel {
  final String image;
  final String name;
  final Color color;

  FoodModel({
    required this.image,
    required this.color,
    required this.name,
  });
}

List<FoodModel> foodModel = [
  FoodModel(
      image: "assets/image4.png", color: Colors.blueAccent, name: 'James Joy'),
  FoodModel(
      image: "assets/image2.png",
      color: Colors.greenAccent,
      name: "Sixtus Eton"),
  FoodModel(
      image: "assets/image3.png",
      color: Colors.redAccent,
      name: "Jenniffer John"),
  FoodModel(
      image: "assets/image1.png",
      color: Colors.pinkAccent,
      name: "Williams Becca"),
  FoodModel(
      image: "assets/image4.png", color: Colors.amber, name: "Betta Ralpheal"),
];

List<Map<String, dynamic>> categories = [
  {
    "name": "Banana",
    "price": "72.5",
    "color": const Color(0xffebd04c),
    "image": "assets/image5.png"
  },
  {
    "name": "Turnip",
    "price": "50.5",
    "color": const Color(0xfffea9b0),
    "image": "assets/image6.png"
  },
  {
    "name": "Renegade",
    "price": "40.0",
    "color": const Color(0xff717ba8),
    "image": "assets/image7.jpg"
  },
];
List<Map<String, dynamic>> recentSearch = [
  {
    "name": "ORANGE",
    "color": const Color(0xfffebf57),
    "image": "assets/image8.png"
  },
  {
    "name": "GUAVA",
    "color": const Color(0xfffd576c),
    "image": "assets/image8.png"
  },
  {
    "name": "PEACH",
    "color": const Color(0xfffeb2a4),
    "image": "assets/image8.png"
  },
];
List<Map<String, dynamic>> tags = [
  {"name": "Salad", "isSelected": true},
  {"name": "Vegan", "isSelected": false},
  {"name": "Plum", "isSelected": false},
  {"name": "Green", "isSelected": false},
  {"name": "Meat", "isSelected": false},
  {"name": "Spicy", "isSelected": true},
  {"name": "Cook", "isSelected": false},
  {"name": "Hot", "isSelected": false},
  {"name": "Red", "isSelected": false}
];
