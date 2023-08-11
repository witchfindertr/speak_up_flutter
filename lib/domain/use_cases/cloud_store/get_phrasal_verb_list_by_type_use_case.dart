import 'package:speak_up/data/repositories/cloud_store/firestore_repository.dart';
import 'package:speak_up/domain/entities/phrasal_verb/phrasal_verb.dart';
import 'package:speak_up/domain/use_cases/use_case.dart';
import 'package:speak_up/injection/injector.dart';

class GetPhrasalVerbListByTypeUseCase
    extends FutureUseCase<int, List<PhrasalVerb>> {
  @override
  Future<List<PhrasalVerb>> run(int input) {
    return injector.get<FirestoreRepository>().getPhrasalVerbListByType(input);
  }
}