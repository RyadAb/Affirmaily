import 'package:Affirmation/models/affirmation.dart';
import 'package:Affirmation/repositories/repository.dart';

class AffirmationService {
  Repository _repository;
  AffirmationService() {
    _repository = Repository();
  }

  //creating data
  saveAffirmation(Affirmation affirmation) async {
    return await _repository.insertData(
        'affirmations', affirmation.affirmationMap());
  }

  readAffirmations() async {
    return await _repository.readData('affirmations');
  }

  deleteCategory(affirmationId) async {
    return await _repository.deleteData('affirmations', affirmationId);
  }
}
