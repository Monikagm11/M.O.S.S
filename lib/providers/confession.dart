import 'package:flutter/material.dart';

class Confession with ChangeNotifier {
  final String id;
  final String description;
  bool isLiked;

  Confession({
    required this.id,
    required this.description,
    this.isLiked = false,
  });
  void toggleLikedStatus() {
    isLiked = !isLiked;
    notifyListeners();
  }
}
