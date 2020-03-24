import 'dart:wasm';

import 'package:feetback/models/jump.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class DatabaseService {
  List<Jump> getAllJumps(String uid) async {
    final DatabaseReference ourDB = FirebaseDatabase.instance.reference().child("users").child(uid).child("jumps");
    return await ourDB.reference().orderByChild("date").once().value();
  }

  Jump getHighestJump(String uid) async {
    final DatabaseReference ourDB = FirebaseDatabase.instance.reference().child("users").child(uid).child("jumps");
    return await ourDB.reference().orderByChild('height').limitToFirst(1);
  }  
  void addJump(Float height, String uid) async {
    final DatabaseReference ourDB = FirebaseDatabase.instance.reference().child("users").child(uid).child("jumps");
    try {
      await ourDB.reference().push().set({
        'height': height,
        'date': DateFormat('dd-MM-yyyy – hh:mm').format(DateTime.now())
      });
    } on Exception catch (e) {
      print(e);
    }
  }
}