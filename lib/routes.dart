import 'package:flutter/widgets.dart';

import 'package:feetback/screens/homePage/home.dart';
import 'package:feetback/screens/jumpHistory/jump_history.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/jump_history": (BuildContext context) => JumpHistoryPage(),
};
