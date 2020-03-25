import 'dart:wasm';
import 'package:feetback/utils/date_utils.dart';
import 'package:intl/intl.dart';

import 'package:feetback/models/jump.dart';

import 'package:firebase_database/firebase_database.dart';

import 'package:feetback/services/service_locator.dart';
import 'package:feetback/services/auth_service.dart';

class DatabaseService {
  final AuthService _authService = locator<AuthService>();

  Future<List<Jump>> getAllJumps() async {
    if (await _authService.isUserSignedIn()) {
      try {
        final DatabaseReference ourDB = FirebaseDatabase.instance.reference().child("users").child(_authService.currentUser.uid).child("jumps");
        DataSnapshot snap = await ourDB.reference().orderByChild("date").once();
        Map<dynamic, dynamic> data = snap.value;
        List<Jump> allJumps = new List<Jump>();
        data.forEach((key, value) {
        allJumps.add(Jump.fromDB(key, value));
        });
        allJumps.forEach((element) {
          print (element.toString());
        });
        return allJumps;
      } on Exception catch (e) {
        print(e);
      }
    }

    return null;
  }

  Future<Jump> getHighestJump() async {
    if (await _authService.isUserSignedIn()) {
      try {
        final DatabaseReference ourDB = FirebaseDatabase.instance.reference().child("users").child(_authService.currentUser.uid).child("jumps");
        DataSnapshot snap = await ourDB.orderByChild("height").limitToLast(1).once();
        Map<dynamic, dynamic> data = snap.value;
        String highestJumpId = data.keys.first;
        Jump highestJump = Jump.fromDB(highestJumpId, data[highestJumpId]);
        print (highestJump.toString());
        return highestJump;
      } on Exception catch (e) {
        print(e);
      }
    }
    
    return null;
  }  

  void addJump(double height, double airtime, bool isFavorite)async {
    if (await _authService.isUserSignedIn()) {
      final DatabaseReference ourDB = FirebaseDatabase.instance.reference().child("users").child(_authService.currentUser.uid).child("jumps");
    try {
      await ourDB.reference().push().set({
        'height': height,
        'date': DateTime.now().toString(),
        'airtime': airtime,
        'favorite': isFavorite,
      });
      print('Add successful');
    } on Exception catch (e) {
      print(e);
    }
    }
    
  }
}