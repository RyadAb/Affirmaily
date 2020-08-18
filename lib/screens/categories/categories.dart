import 'package:Affirmation/screens/categories/categoryAffirmations.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  Future categories;

  Future getData() async {
    try {
      Response response = await get(
          'https://raw.githubusercontent.com/RyadAb/AffirmailyAssets/master/data/categories.json');
      Map data = jsonDecode(response.body);
      return data['categories'];
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    categories = getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: categories,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              itemCount: snapshot.data.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (BuildContext context, int index) {
                return Category(
                    name: snapshot.data[index]["name"],
                    url: snapshot.data[index]["url"]);
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
    );
  }
}

class Category extends StatelessWidget {
  final name;
  final url;

  Category({this.name, this.url});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
          tag: name,
          child: Material(
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CategoryAffirmations(category: name),
                ));
              },
              child: GridTile(
                footer: Container(
                  color: Colors.black54,
                  child: ListTile(
                    // leading: Text(
                    //   name,
                    //   style: TextStyle(
                    //       fontWeight: FontWeight.bold, color: Colors.white),
                    // ),
                    title: Center(
                      child: Text(
                        name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                child: Image.network(url, fit: BoxFit.cover),
              ),
            ),
          )),
    );
  }
}
