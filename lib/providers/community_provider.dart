import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './confession.dart';

import '../models/http_exception.dart';

class Confessions with ChangeNotifier {
  List<Confession> _items = [
    // Confession(
    //   id: 'A1',
    //   description:
    //       'It happened at the age of 12 when i was in grade 5. The age when i couldn\'t ... ',
    // ),
    // Confession(
    //   id: 'A2',
    //   description:
    //       'I think it\'s hard for me or anyone to share this kind of trauma that we went through. But if it helps others to come out of their fear and help with their trauma, why not?',
    // ),
  ];

//gets item from list
  List<Confession> get items {
    return [..._items]; //returns copy of item
  }

  Confession findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future<void> fetchAndSetConfessions() async {
    final url = Uri.parse(
        'https://moss-8a7cb-default-rtdb.firebaseio.com/confessions.json');
    try {
      final response = await http.get(url);
      // print(json.decode(response.body));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      final List<Confession> loadedConfession = [];
      extractedData.forEach((confId, confData) {
        loadedConfession.add(Confession(
          id: confId,
          description: confData['description'],
        ));
      });
      _items = loadedConfession;
      notifyListeners();
    } catch (error) {
      print(error);
      throw (error);
    }
  }

  Future<void> addConfession(Confession confession) async {
    //items.add(value);
    var url = Uri.https(
        'moss-8a7cb-default-rtdb.firebaseio.com', '/confessions.json');
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'description': confession.description,
          'isLiked': confession.isLiked,
        }),
      );
      // Check the response status code
      // if (response.statusCode == 200) {
      //   print('Data posted successfully.');
      // } else {
      //   print('Error posting data: ${response.statusCode}');
      //}
      final newConfession = Confession(
        id: json.decode(response.body)['name'],
        description: confession.description,
      );
      _items.add(newConfession);
      //_items.insert(0, newConfession); //at the start of the list
      notifyListeners();
    } catch (error) {
      // print(error);
      throw error;
    }
  }

  Future<void> updateConfession(String id, Confession newConfession) async {
    final confIndex = _items.indexWhere((conf) => conf.id == id);
    if (confIndex >= 0) {
      final url = Uri.parse(
          'https://moss-8a7cb-default-rtdb.firebaseio.com/confessions/$id.json');
      await http.patch(url,
          body: json.encode({
            'description': newConfession.description,
          }));
      _items[confIndex] = newConfession;
      notifyListeners();
    } else {
      print('...');
    }
  }

  Future<void> deleteConfession(String id) async {
    final url = Uri.parse(
        'https://moss-8a7cb-default-rtdb.firebaseio.com/confessions/$id.json');
    final existingConfessionIndex = _items.indexWhere((conf) => conf.id == id);
    Confession? existingConfession = _items[existingConfessionIndex];
    _items.removeAt(existingConfessionIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingConfessionIndex, existingConfession);
      notifyListeners();
      throw HttpException('Could not delete product.');
    }
    existingConfession = null;
  }
}
