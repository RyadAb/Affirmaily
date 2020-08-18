import 'package:Affirmation/models/affirmation.dart';
import 'package:Affirmation/screens/custom_affirmation.dart';
import 'package:Affirmation/services/affirmation_service.dart';
import 'package:flutter/material.dart';
import 'package:Affirmation/screens/home/bottomBar.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: Text('Affirmations'),
        centerTitle: true,
        backgroundColor: Colors.redAccent[700],
      ),
      body: AffirmationsSaved(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          return showDialog(
              context: context,
              builder: (BuildContext context) {
                return SimpleDialog(
                  children: <Widget>[
                    SimpleDialogOption(
                      child: FlatButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return CustomAffirmation();
                                },
                                fullscreenDialog: true));
                          },
                          child: Text(
                            'Create your own affirmation',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 19.5,
                            ),
                          )),
                    ),
                    SimpleDialogOption(
                      child: Text(
                        'OR',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                    SimpleDialogOption(
                        child: FlatButton(
                      onPressed: () {
                        Navigator.popAndPushNamed(context, '/chooseCategory');
                      },
                      child: Text(
                        'Choose one from a handfull of categories',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 19.5),
                      ),
                    )),
                  ],
                );
              });
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.amber[900],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomBar(),
    );
  }
}

class AffirmationsSaved extends StatefulWidget {
  @override
  _AffirmationsSavedState createState() => _AffirmationsSavedState();
}

class _AffirmationsSavedState extends State<AffirmationsSaved> {
  var _affirmationService = AffirmationService();

  List<Affirmation> _affirmationList = List<Affirmation>();

  getAllAffirmations() async {
    _affirmationList = List<Affirmation>();
    var affirmations = await _affirmationService.readAffirmations();
    affirmations.forEach((affirmation) {
      setState(() {
        var affirmationModel = Affirmation();
        affirmationModel.id = affirmation['id'];
        affirmationModel.body = affirmation['body'];
        _affirmationList.add(affirmationModel);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getAllAffirmations();
  }

  @override
  Widget build(BuildContext context) {
    if (_affirmationList.length > 0) {
      return ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: _affirmationList.length,
          itemBuilder: (context, index) {
            return Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 4.0),
                child: Card(
                  child: ListTile(
                      title: Text(
                        _affirmationList[index].body,
                        style: TextStyle(fontSize: 18.5),
                      ),
                      trailing: PopupMenuButton(
                          itemBuilder: (context) {
                            var list = List<PopupMenuEntry<Object>>();
                            list.add(PopupMenuItem(
                              child: ListTile(
                                leading: Icon(Icons.delete),
                                title: Text('Remove'),
                                onTap: () async {
                                  await _affirmationService.deleteCategory(
                                      _affirmationList[index].id);
                                  setState(() {
                                    getAllAffirmations();
                                  });
                                  Navigator.pop(context);
                                },
                              ),
                              value: 1,
                            ));
                            return list;
                          },
                          icon: Icon(Icons.more_vert))),
                ));
          });
    } else {
      return Container(
        child: Center(
            child: Text(
          'No affirmations added.',
          style: TextStyle(
            fontSize: 22.0,
          ),
          textAlign: TextAlign.center,
        )),
      );
    }
  }
}
