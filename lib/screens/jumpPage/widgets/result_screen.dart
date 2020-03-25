
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResultScreen extends Container {
  
  ResultScreen(String jumpResult):super(
    child:Center(
      child: Container(
        height: 136,
        child:Column( children :<Widget>[
          Text(
            "Congrats, you've jumped",
            style: TextStyle(
            fontSize: 24,
          ),
            ),
          Text(
            jumpResult,
            style: TextStyle(
              fontSize: 92,
            ),
          ),
        ]
      ),
      ),
    ),
  );
}