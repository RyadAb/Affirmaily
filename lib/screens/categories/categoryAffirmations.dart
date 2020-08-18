import 'package:Affirmation/models/affirmation.dart';
import 'package:Affirmation/services/affirmation_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CategoryAffirmations extends StatefulWidget {
  final String category;
  CategoryAffirmations({this.category});

  @override
  _CategoryAffirmationsState createState() =>
      _CategoryAffirmationsState(category);
}

class _CategoryAffirmationsState extends State<CategoryAffirmations> {
  final String categoryName;
  Future category;
  _CategoryAffirmationsState(this.categoryName);

  Future getAffirmations() async {
    String categoryName = this.categoryName.replaceAll(new RegExp(r"\s+"), "");
    try {
      Response response = await get(
          'https://raw.githubusercontent.com/RyadAb/AffirmailyAssets/master/data/categories/' +
              categoryName +
              '.json');
      Map data = jsonDecode(response.body);
      return data['affirmations'];
    } catch (e) {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    category = getAffirmations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
        backgroundColor: Colors.redAccent[700],
      ),
      body: Container(
        child: FutureBuilder(
          future: category,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return AffirmationTile(
                      affirmation: snapshot.data[index]['body']);
                },
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return SafeArea(
              child: Center(
                child: SpinKitFadingCube(
                  itemBuilder: (BuildContext context, int index) {
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        color: index.isEven ? Colors.red[400] : Colors.red[900],
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class AffirmationTile extends StatelessWidget {
  final affirmation;
  AffirmationTile({this.affirmation});

  var _affirmation = Affirmation();
  var _affirmationService = AffirmationService();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(5.0),
      child: ListTile(
        title: Text(
          affirmation,
          style: TextStyle(fontSize: 19.0),
        ),
        trailing: IconButton(
          icon: Icon(Icons.add),
          onPressed: () async {
            final snackbar = SnackBar(
              content: Text('Affirmation added.'),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.redAccent[700],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0))),
            );

            _affirmation.body = affirmation;
            var result =
                await _affirmationService.saveAffirmation(_affirmation);
            print(result);
            if (result != null) {
              Scaffold.of(context).showSnackBar(snackbar);
            } else {
              print('Error adding');
            }
          },
        ),
        contentPadding: EdgeInsets.all(15.0),
      ),
    );
  }
}
