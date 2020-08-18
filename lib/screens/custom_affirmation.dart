import 'package:Affirmation/models/affirmation.dart';
import 'package:Affirmation/services/affirmation_service.dart';
import 'package:flutter/material.dart';

class CustomAffirmation extends StatefulWidget {
  @override
  _CustomAffirmationState createState() => _CustomAffirmationState();
}

class _CustomAffirmationState extends State<CustomAffirmation> {
  final _affirmationController = TextEditingController();
  String affirmation = "";

  var _affirmation = Affirmation();
  var _affirmationService = AffirmationService();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Affirmation'),
        backgroundColor: Colors.redAccent[700],
        actions: [
          FlatButton(
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  _affirmation.body = _affirmationController.text;
                  var result =
                      await _affirmationService.saveAffirmation(_affirmation);
                  print(result);
                  Navigator.of(context).popAndPushNamed('/home');
                }
              },
              child: Text('SAVE',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      .copyWith(color: Colors.white))),
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Affirmation can't be empty.";
                    }
                    return null;
                  },
                  maxLines: 5,
                  controller: _affirmationController,
                  decoration: InputDecoration(
                      hintText: 'Affirmaton',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 3.0,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.green,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      )),
                )
              ],
            ),
          )
          // Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: <Widget>[
          //     TextField(
          //       maxLines: 5,
          //       controller: _affirmationController,
          //       decoration: InputDecoration(
          //           hintText: 'Affirmation',
          //           enabledBorder: OutlineInputBorder(
          //             borderSide: BorderSide(
          //               color: Colors.redAccent[700],
          //             ),
          //             borderRadius: BorderRadius.all(Radius.circular(20.0)),
          //           ),
          //           focusedBorder: OutlineInputBorder(
          //             borderSide: BorderSide(
          //               color: Colors.greenAccent[700],
          //             ),
          //             borderRadius: BorderRadius.all(Radius.circular(20.0)),
          //           )),
          //     ),
          //   ],
          // ),
          ),
    );
    ;
  }
}
