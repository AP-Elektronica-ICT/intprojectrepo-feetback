import 'package:flutter/material.dart';
import 'package:feetback/widgets/feetback_app_bar.dart';
import 'package:feetback/services/navigation_service.dart';


class NotConnectedPage extends StatefulWidget {
  @override
  _NotConnectedState createState() => _NotConnectedState();
}

class _NotConnectedState extends State<NotConnectedPage> {
  NavigationService _navService = NavigationService();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FeetbackAppBar(
        title: const Text("Home"),
        height: 92,
        contentAlignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 16, right: 16),
      ),
      body: Padding(
        padding: EdgeInsets.all(32),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                  child: Image(
                      image: AssetImage("lib/images/notConnected.png"))),
              
              SizedBox(height: 32),
              Text('Oops seems like you are not connected',
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      .copyWith(fontWeight: FontWeight.bold)),
              
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _navService.clearStackTo('/connect');
        },
        label: const Text('Connect to a jump mat'),
        backgroundColor : Theme.of(context).primaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
