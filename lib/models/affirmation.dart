class Affirmation {
  int id;
  String body;

  affirmationMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id;
    mapping['body'] = body;

    return mapping;
  }
}
