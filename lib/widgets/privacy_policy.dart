import 'dart:async' show Future;

import 'package:flutter/material.dart';

import 'package:flutter_markdown/flutter_markdown.dart';


class PrivacyPolicy extends StatefulWidget {
  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();

  final VoidCallback onAccepted;

  PrivacyPolicy({@required this.onAccepted});
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  final ScrollController _scrollController = ScrollController();

  bool _isPrivacyPolicyAccepted = false;
  _valueChanged(bool newValue) => setState(() => _isPrivacyPolicyAccepted = newValue);

  Future<String> _loadPrivacyPolicy(BuildContext context) async {
    return await DefaultAssetBundle.of(context).loadString('lib/legal/privacy_policy.md');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<String>(
        future: _loadPrivacyPolicy(context),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          List<Widget> children;

          if (snapshot.hasData) {
            children = <Widget>[
              Expanded(
                child: Markdown(
                  controller: _scrollController,
                  selectable: false,
                  data: snapshot.data,
                ),
              ),
              CheckboxListTile(
                title: Text('I accept the privacy policy stated above.'),
                value: _isPrivacyPolicyAccepted,
                onChanged: _valueChanged,
                controlAffinity: ListTileControlAffinity.leading,
              ),
              RaisedButton(
                child: Text('Next'),
                onPressed: _isPrivacyPolicyAccepted ? widget.onAccepted : null,
              ),
            ];
          } else if (snapshot.hasError) {
            children = <Widget>[
              Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Text('Error: ${snapshot.error}'),
              ),
            ];
          } else {
            children = <Widget>[
              SizedBox(
                child: CircularProgressIndicator(),
                width: 60,
                height: 60,
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Text('Loading privacy policy...'),
              ),
            ];
          }

          return Container(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: children,
            ),
          );
        },
      ),
    );
  }
}